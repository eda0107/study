package egovframework.example.postboard.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import egovframework.example.postboard.service.CommentsVO;
import egovframework.example.postboard.service.CommentsService;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;

@Service("CommentsService")
public class CommentsServiceImpl extends EgovAbstractServiceImpl implements CommentsService{
	
	private static final Logger LOGGER = LoggerFactory.getLogger(PostBoardServiceImpl.class);
	
		//myBatis
		@Resource(name="CommentsMapper")
		private CommentsMapper commentsDAO;
		
		/** ID Generation */
		@Resource(name = "egovIdGnrService")
		private EgovIdGnrService egovIdGnrService;
		
		/** 댓글을 등록한다 */
		@Override
		public void insertComments(CommentsVO cvo) throws Exception{
			commentsDAO.insertComments(cvo);
		};
		
		/** 댓글 리스트를 조회한다 */
		@Override
		public List<CommentsVO> selectCommentsList(CommentsVO cvo) throws Exception{
			return commentsDAO.selectCommentsList(cvo);
		};
		

}
