package egovframework.example.postboard.service.impl;

import java.util.List;


import egovframework.example.postboard.service.PostBoardVO;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("PostMapper")
public interface PostMapper {
	
	/** 글을 등록한다 */
	void insertPost(PostBoardVO vo) throws Exception;
	
	/** 글을 수정한다 */
	void updatePost(PostBoardVO vo) throws Exception;
	
	/** 글을 삭제한다 */
	void deletePost(PostBoardVO vo) throws Exception;
	
	/** 글 하나를 조회한다 */
	PostBoardVO selectPost(PostBoardVO vo) throws Exception;
	
	/** 조회수를 카운트한다 */
	int updateCnt(PostBoardVO vo) throws Exception;
	
	/** 글 목록을 조회한다 */
	List<PostBoardVO> selectPostList(PostBoardVO vo) throws Exception;
	
	/** 글 총 갯수를 조회한다 */
	int selectPostListTotCnt(PostBoardVO vo);
	
	/** 답변을 단다 */
	void insertReply(PostBoardVO vo) throws Exception;
	
	/** 답변 목록을 조회한다 */
	List<PostBoardVO> selectReplyList(PostBoardVO vo) throws Exception;
	
	/** 답변 갯수를 카운트한다 */
	int getReplyCnt(PostBoardVO vo) throws Exception;
}
