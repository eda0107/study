package egovframework.example.postboard.web;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.support.SessionStatus;
import org.springmodules.validation.commons.DefaultBeanValidator;

import egovframework.example.postboard.service.CommentsService;
import egovframework.example.postboard.service.CommentsVO;
import egovframework.example.postboard.service.PostBoardService;
import egovframework.example.postboard.service.PostBoardVO;
import egovframework.example.postboard.service.VoteService;
import egovframework.example.postboard.service.VoteVO;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
public class PostBoardController {

	/** PostBoardService>>ServiceImpl에서 @Service로 선언한 이름이 들어가야 */
	@Resource(name = "PostBoardService")
	private PostBoardService postService;

	/** 댓글 서비스 */
	@Resource(name = "CommentsService")
	private CommentsService commentsService;

	/** 좋아요 싫어요 서비스 */
	@Resource(name = "VoteService")
	private VoteService voteService;

	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

	/** Validator */
	@Resource(name = "beanValidator")
	protected DefaultBeanValidator beanValidator;

	/**
	 * jsp page 글 전체 목록 조회
	 */
	@RequestMapping(value = "/pBoardList.do")
	// @ModelAttribute("")에 붙은 빈 클래스(getter, setter만 존재)가 model 객체에 추가되고 jsp까지 전달이 됨
	public String selectPostList(@ModelAttribute("PostBoardVO") PostBoardVO vo, ModelMap model, String date,
			String fromFormatString, String toFormatString) throws Exception {
		// 글 전체 목록을 조회할 때 사용할 PostBoardVO가 페이지에 관한 클래스 PostBoardDefaultVO를 상속받기 때문에 상관없음
		/** EgovPropertyService.sample */
		vo.setPageUnit(propertiesService.getInt("pageUnit"));
		vo.setPageSize(propertiesService.getInt("pageSize"));

		/** 목록 세팅 */
		// 페이징
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(vo.getPageIndex()); // currentPageNo: 현재 페이지 번호
		paginationInfo.setRecordCountPerPage(vo.getPageUnit()); // recordCountPerPage: 한 페이지에 게시되는 게시물 건수
		paginationInfo.setPageSize(vo.getPageSize()); // pageSize: 페이징 리스트의 사이즈

		vo.setFirstIndex(paginationInfo.getFirstRecordIndex() + 1);
		vo.setLastIndex(paginationInfo.getLastRecordIndex());
		vo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage()); // 한 페이지당 게시되는 게시물 건 수

		List<PostBoardVO> postList = postService.selectPostList(vo);
		
/*		for(PostBoardVO postBoardVO : postList) {
			System.out.println(new String(postBoardVO.getPostText()));
			System.out.println(postBoardVO.getStrPostText());
		}*/
		int totCnt = postService.selectPostListTotCnt(vo);// ROWNUM을 쓰지 않고 글 전체 목록에 번호를 주는 것, Service를 이용
		paginationInfo.setTotalRecordCount(totCnt); // totalRecordCount: 전체 게시물 갯수(끝 페이지의 번호 계산을 위해서 必)

		model.addAttribute("postList", postList);
		model.addAttribute("paginationInfo", paginationInfo);

		//return "postviews/list";
		return "postviews/views";
	}

	/** 글 등록화면 */
	@RequestMapping(value = "/registerView.do")
	public String registerView() throws Exception {
		//return "postviews/reg";
		return "postviews/register";
	}

	/** 글을 등록한다 */
	@RequestMapping(value = "/register.do")
	public String register(@ModelAttribute("PostBoardVO") PostBoardVO vo, BindingResult bindingResult, Model model,
			SessionStatus status) throws Exception {
		vo.setPostText(vo.getBlobPostText().getBytes());
		postService.insertPost(vo);
		return "jsonView";
	}

	/** 글 수정화면 */
	@RequestMapping(value = "/editView.do")
	public String updateView(@ModelAttribute("PostBoardVO") PostBoardVO vo, Model model) throws Exception {
		PostBoardVO p = postService.selectPost(vo);
		model.addAttribute("p", p);
		return "postviews/edit";
		//return "postviews/mod";
	}

	/** 게시글, 답글을 조회한다 */
	@RequestMapping(value = "/updateView.do")
	public String selectPost(@ModelAttribute("PostBoardVO") PostBoardVO vo, CommentsVO cvo, Model model)
			throws Exception {
		/** 조회수를 카운트한다 */
		postService.updateCnt(vo);

		// 조회 게시물에 대한 객체 생성(조회할 때마다 p에 대해 postNo, postTitle, postText 등이 get
		PostBoardVO p = postService.selectPost(vo);
		model.addAttribute("p", p);

		// 게시글,답글일 때 로직 다르게 -> vo가 아니라 p를 가져와야함: p는 조회하면서 객체가 생성된 상태(=>postNo 값이 들어간 상태)
		if ("".equals(p.getOriginNo()) || p.getOriginNo() == null) { // 게시글일때 => p.postNo는 有 p.originNo는 無
			List<?> replyList = postService.selectReplyList(vo);
			model.addAttribute("replyList", replyList);
			
			VoteVO vvo = new VoteVO();
			vvo.setPostNo(p.getPostNo());
			//좋아요  
			vvo.setVoteYn("Y");
			int yCnt = voteService.selectLikeCnt(vvo);
			model.addAttribute("yCnt", yCnt);
			//싫어요
			vvo.setVoteYn("N");
			int nCnt = voteService.selectHateCnt(vvo);
			model.addAttribute("nCnt", nCnt);
			
		} else { // 답글일때(p.originNo가 있을 때)
			PostBoardVO postBoardVO = new PostBoardVO(); // 객체 생성해서
			postBoardVO.setPostNo(p.getOriginNo()); // 기존 p객체의 originNo를 새 객체 postNo에 꽂아준다 originNo=postNo로 title, text
													// 등 parameter 가지고 옴
			PostBoardVO originVO = postService.selectPost(postBoardVO); // postBoardVO의 postNo에 p의 originNo(조회한 답글의 원글
																		// 번호)가 들어갔기 때문에 SQL 쿼리 실행
			model.addAttribute("originVO", originVO);

		}

		/** 댓글 목록 조회 */
		List<CommentsVO> commentsList = commentsService.selectCommentsList(cvo);
		model.addAttribute("commentsList", commentsList);

		//return "postviews/content";
		return "postviews/update";
	}

	/** 글을 수정한다 */
	@RequestMapping(value = "/update.do")
	@ResponseBody
	public void update(@ModelAttribute("PostBoardVO") PostBoardVO vo, BindingResult bindingResult, Model model, SessionStatus status) throws Exception {
		vo.setPostText(vo.getBlobPostText().getBytes());
		postService.updatePost(vo);
	}

	/*	*//** 글을 삭제한다-단순 삭제 */
	/*
	 * @RequestMapping(value="/delete.do")
	 * 
	 * @ResponseBody public void deletePost(@RequestParam(value="chk[]")
	 * List<String> arr, PostBoardVO vo, Model model) throws Exception{ for(String i
	 * : arr){ vo.setPostNo(i); postService.deletePost(vo); } //return
	 * "redirect:/pBoardList.do"; }
	 */

//	몇 건 삭제했는지 alert로 띄워야 해서 해당 메소드 사용-Service, Service Impl 변경
	@RequestMapping(value = "/delete.do")
	// required=false 사용하면 해당 파라미터가 쿼리 스트링에 없어도 파라미터를 받아올 수 있음 default가 true여서 false
	// 해주지 않으면 chk[] not present 발생
	public String deletePost(@RequestParam(value = "chk[]", required = false) List<String> arr, PostBoardVO vo,
			ModelMap model, HttpServletResponse response) throws Exception {
		// ServiceImpl에서 배열이 증가할 때마다 j값이 증가하고 그 j값을 a가 받아옴
		// List<String> repArray = new ArrayList<String>();
		// for(int i = 0; i < arr.size(); i++) {
		// vo.setPost(arr.get(i));

		// [1] 체크된 게시글에서 답글 유무 확인
		for (String i : arr) {
			vo.setPostNo(i);
			int p = postService.getReplyCnt(vo); // resultType이 int, p는 답글 갯수
			// [2] 답글 있으면 삭제 불가 답글 없으면 삭제
			if (p > 0) {
				model.addAttribute("message", "exist"); // success에서 call
				return "jsonView";
			} // else { //답글 없는 게시물은 list에 담아줌
				// repArray.add(arr.get(i));
				// }
		}
		// [3] 게시글 중 삭제된 게 있으면 몇건
		if (arr != null && arr.size() > 0) {
			int a = postService.deletePost2(arr);
			model.addAttribute("data", a);
		}

		/*
		 * if(repArray.size() > 0) { int a = postService.deletePost2(arr);
		 * model.addAttribute("data", a); }
		 */
		return "jsonView";
	}

	/** 답변 등록화면 */
	@RequestMapping(value = "/replyView.do")
	public String replyView(@ModelAttribute("PostBoardVO") PostBoardVO vo, Model model) throws Exception {
		PostBoardVO p = postService.selectPost(vo);
		model.addAttribute("p", p);
		return "postviews/reply";

	}

	/** 답변 갯수 카운트용 */
	@RequestMapping(value = "/getReplyCount.do")
	public String getReplyCount(@ModelAttribute("PostBoardVO") PostBoardVO vo, Model model) throws Exception {
		int replyCount = postService.getReplyCnt(vo);
		model.addAttribute("replyCount", replyCount);
		return "jsonView";
	}

	/** 답변을 등록한다 */
	@RequestMapping(value = "/reply.do")
	@ResponseBody
	public void reply(@ModelAttribute("PostBoardVO") PostBoardVO vo, BindingResult bindingResult, Model model,
			SessionStatus status) throws Exception {
		postService.insertReply(vo);
	}

	/** 답변 리스트를 조회한다 */
	@RequestMapping(value = "/replyList.do")
	public String selectReplyList(@ModelAttribute("PostBoardVO") PostBoardVO vo, ModelMap model) throws Exception {
		List<PostBoardVO> replyList = postService.selectReplyList(vo);
		model.addAttribute("replyList", replyList);
		return "jsonView";
	}

	/** 댓글을 등록한다 */
	@RequestMapping(value = "/comments.do")
	public String comments(@ModelAttribute("CommentsVO") CommentsVO cvo, PostBoardVO vo, BindingResult bindingResult,
			Model model) throws Exception {
		cvo.setPostNo(vo.getPostNo());
		commentsService.insertComments(cvo);
		return "jsonView"; // 등록 성공+DB에 값은 저장
		// 데이터타입이 void면 통신 실패+DB에 값은 저장됨

	}

	/** 댓글 목록을 조회한다 */
	@RequestMapping(value = "/commentsList.do")
	public String commentsList(@ModelAttribute("CommentsVO") CommentsVO cvo, PostBoardVO vo,
			BindingResult bindingResult, Model model) throws Exception {
		cvo.setPostNo(vo.getPostNo());
		List<CommentsVO> commentsList = commentsService.selectCommentsList(cvo);
		model.addAttribute("commentsList", commentsList);
		return "postviews/commentsList";

	}

	/** 좋아요/싫어요를 등록한다 */
	@RequestMapping(value = "/votePost.do")
	public String votePost(VoteVO vvo, PostBoardVO vo, BindingResult bindingResult, Model model) throws Exception {
		vvo.setPostNo(vo.getPostNo());
		voteService.insertVote(vvo);
		return "jsonView";
	}

	/** 좋아요 싫어요 카운트 */
	@RequestMapping(value="/selectVoteCnt.do")
	public String selectVoteCnt(@ModelAttribute("VoteVO") VoteVO vvo, PostBoardVO vo, Model model) throws Exception {
		//게시글당 Y/N
		vvo.setPostNo(vo.getPostNo());
		//좋아요  
		vvo.setVoteYn("Y");
		int yCnt = voteService.selectLikeCnt(vvo);
		model.addAttribute("yCnt", yCnt);
		//싫어요
		vvo.setVoteYn("N");
		int nCnt = voteService.selectHateCnt(vvo);
		model.addAttribute("nCnt", nCnt);
		return "jsonView";
		
	}
	/** 좋아요 카운트 */
	@RequestMapping(value = "/selectLikeCnt.do")
	public String selectLikeCnt(@ModelAttribute("VoteVO") VoteVO vvo, PostBoardVO vo, Model model) throws Exception {
		vvo.setPostNo(vo.getPostNo());
		int yCnt = voteService.selectLikeCnt(vvo);
		model.addAttribute("yCnt", yCnt);
		return "jsonView";

	}

	/** 싫어요 카운트 */
	@RequestMapping(value = "/selectHateCnt.do")
	public String selectHateCnt(@ModelAttribute("VoteVO") VoteVO vvo, PostBoardVO vo, Model model) throws Exception {
		vvo.setPostNo(vo.getPostNo());
		int nCnt = voteService.selectHateCnt(vvo);
		model.addAttribute("nCnt", nCnt);
		return "jsonView";
	}
	


}
