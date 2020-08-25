package egovframework.example.postboard.service.impl;

import java.util.List;

import egovframework.example.postboard.service.CommentsVO;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("CommentsMapper")
public interface CommentsMapper {
	
	/** 댓글을 등록한다 */
	void insertComments(CommentsVO cvo) throws Exception;
	
	/** 댓글 목록을 조회한다 */
	List<CommentsVO> selectCommentsList(CommentsVO cvo) throws Exception;
	
	
	

}
