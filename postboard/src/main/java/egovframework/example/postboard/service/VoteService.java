package egovframework.example.postboard.service;

public interface VoteService {
	
	/** 좋아요/싫어요를 등록한다 */
	void insertVote(VoteVO vvo) throws Exception;
	
	/** 좋아요/싫어요 카운트 */
	int selectVoteCnt(VoteVO vvo) throws Exception;
	
	/** 좋아요 카운트 */
	int selectLikeCnt(VoteVO vvo) throws Exception;
	
	/** 싫어요 카운트 */
	int selectHateCnt(VoteVO vvo)throws Exception;

}
