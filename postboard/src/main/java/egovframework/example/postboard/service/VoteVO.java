package egovframework.example.postboard.service;

import java.util.Date;
import java.util.UUID;

public class VoteVO {

	private static final long serialVersionUID = 1L;
	
	private String postNo = "";
	
	private String voteYn = "";
	
	private String voteKey = UUID.randomUUID().toString().replace("-", "");
	//toString으로 casting, replace()로 하이픈 제거
	
	private Date voteDate;
	
	private String yCnt;
	
	private String nCnt;


	public String getPostNo() {
		return postNo;
	}

	public void setPostNo(String postNo) {
		this.postNo = postNo;
	}

	public String getVoteYn() {
		return voteYn;
	}

	public void setVoteYn(String voteYn) {
		this.voteYn = voteYn;
	}

	public String getVoteKey() {
		return voteKey;
	}

	public void setVoteKey(String voteKey) {
		this.voteKey = voteKey;
	}

	public Date getVoteDate() {
		return voteDate;
	}

	public void setVoteDate(Date voteDate) {
		this.voteDate = voteDate;
	}

	public String getyCnt() {
		return yCnt;
	}

	public void setyCnt(String yCnt) {
		this.yCnt = yCnt;
	}

	public String getnCnt() {
		return nCnt;
	}

	public void setnCnt(String nCnt) {
		this.nCnt = nCnt;
	}

	public void setVoteYn(char c) {
		
	}

	

}
