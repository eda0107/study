package egovframework.example.postboard.service.impl;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import egovframework.example.postboard.service.VoteService;
import egovframework.example.postboard.service.VoteVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service("VoteService")
public class VoteServiceImpl extends EgovAbstractServiceImpl implements VoteService{

	private static final Logger LOGGER = LoggerFactory.getLogger(PostBoardServiceImpl.class);
	
	@Resource(name="VoteMapper")
	private VoteMapper voteDAO;

	@Override
	public void insertVote(VoteVO vvo) throws Exception {
		voteDAO.insertVote(vvo);
	}

	@Override
	public int selectLikeCnt(VoteVO vvo) throws Exception {
		return voteDAO.selectLikeCnt(vvo);
	}

	@Override
	public int selectHateCnt(VoteVO vvo) throws Exception {
		return voteDAO.selectHateCnt(vvo);
	}

	@Override
	public int selectVoteCnt(VoteVO vvo) throws Exception {
		return voteDAO.selectVoteCnt(vvo);
	}
	
}
