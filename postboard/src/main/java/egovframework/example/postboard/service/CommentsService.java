package egovframework.example.postboard.service;

import java.util.List;

public interface CommentsService {
	
	/** 댓글을 등록한다 */
	void insertComments(CommentsVO cvo) throws Exception;
	
	/** 댓글 목록을 조회한다 */
	List<CommentsVO> selectCommentsList(CommentsVO cvo) throws Exception;

}
