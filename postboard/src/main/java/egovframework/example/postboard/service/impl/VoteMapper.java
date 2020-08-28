package egovframework.example.postboard.service.impl;

import egovframework.example.postboard.service.VoteVO;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("VoteMapper")
public interface VoteMapper {
	
	/** 좋아요/싫어요를 등록한다 */
	void insertVote(VoteVO vvo) throws Exception;
	
	/** 좋아요/싫어요 카운트 */
	int selectVoteCnt(VoteVO vvo) throws Exception;
	
	/** 좋아요 카운트 */
	int selectLikeCnt(VoteVO vvo) throws Exception;
	
	/** 싫어요 카운트 */
	int selectHateCnt(VoteVO vvo) throws Exception;

}
