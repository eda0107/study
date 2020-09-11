package egovframework.example.postboard.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;


import egovframework.example.postboard.service.PostBoardService;
import egovframework.example.postboard.service.PostBoardVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;

//Controller에서 @Resource(name="")에 들어갈 이름
@Service("PostBoardService")
public class PostBoardServiceImpl  extends EgovAbstractServiceImpl implements PostBoardService{
	
	private static final Logger LOGGER = LoggerFactory.getLogger(PostBoardServiceImpl.class);
	
	//mybatis
	@Resource(name="PostMapper")
	private PostMapper postDAO;
	
	/** ID Generation */
	@Resource(name = "egovIdGnrService")
	private EgovIdGnrService egovIdGnrService;
	
	//PostBoardService 참고
	
	/** 글을 등록한다*/
	@Override
	public void insertPost(PostBoardVO vo) throws Exception{
		postDAO.insertPost(vo);
	}
	
	/** 글을 수정한다 */
	@Override
	public void updatePost(PostBoardVO vo) throws Exception {
		postDAO.updatePost(vo);
	}
	
	/** 글을 삭제한다 */
	@Override
	public void deletePost(PostBoardVO vo) throws Exception {
		postDAO.deletePost(vo);
	}
	
	/** 글 하나를 조회한다 */
	@Override
	public PostBoardVO selectPost(PostBoardVO vo) throws Exception{
		return postDAO.selectPost(vo);
	}
	
	/** 조회수 카운트한다 */
	@Override
	public int updateCnt(PostBoardVO postBoardVO) throws Exception {
		return postDAO.updateCnt(postBoardVO);
		
	}
	
	/** 글 목록을 조회한다 */
	@Override
	public List<PostBoardVO> selectPostList(PostBoardVO vo) throws Exception{
		return postDAO.selectPostList(vo);
	}
	
	/** 글 총 갯수를 조회한다 */
	@Override
	public int selectPostListTotCnt(PostBoardVO vo) {
		return postDAO.selectPostListTotCnt(vo);
	}

	@Override
	public int deletePost2(List<String> vo) throws Exception {
		PostBoardVO postBoard = new PostBoardVO();
		int j = 0;
		for(int i = 0 ; i < vo.size() ; i++) {
			postBoard.setPostNo(vo.get(i));
			postDAO.deletePost(postBoard);
			j++;
		}
		
		return j;
	}
	
	/** 답변을 단다 */
	@Override
	public void insertReply(PostBoardVO vo) throws Exception{
		postDAO.insertReply(vo);
	}
	
	/** 답변 목록을 조회한다*/
	@Override
	public List<PostBoardVO> selectReplyList(PostBoardVO vo) throws Exception{
		return postDAO.selectReplyList(vo);
		
	}
	
	/** 답변 갯수를 카운트한다 */
	@Override
	public int getReplyCnt(PostBoardVO vo) throws Exception{
		return postDAO.getReplyCnt(vo);
	}
}
