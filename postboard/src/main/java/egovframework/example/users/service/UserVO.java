package egovframework.example.users.service;

import java.util.Date;
import java.util.UUID;

public class UserVO {

	private static final long serialVersionUID = 1L;
	/**
	 * 	USER_KEY	VARCHAR2(100)	NOT NULL	PK
		USER_ID		VARCHAR(100)	NOT NULL	
		USER_PW		VARCHAR(200)	NOT NULL	
		USER_NAME	VARCHAR(30)		NOT NULL	
		USER_EMAIL	VARCHAR2(100)	NOT NULL	
		USER_REG_DATE	DATE		NULLABLE	
		USER_MOD_DATE	DATE		NULLABLE	
	 */
	
	/** 키값 */
	private String userKey = UUID.randomUUID().toString().replace("-", "");
	//toString으로 casting, replace()로 하이픈 제거
	
	/** 아이디 */
	private String userId;
	
	/** 비밀번호 */
	private String userPw;
	
	/** 이름 */
	private String userName;
	
	/** 이메일 */
	private String userEmail;
	
	/** 회원 가입일 */
	private Date userRegDate;
	
	/** 회원 정보 수정일 */
	private Date userModDate;

	public String getUserKey() {
		return userKey;
	}

	public void setUserKey(String userKey) {
		this.userKey = userKey;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getUserPw() {
		return userPw;
	}

	public void setUserPw(String userPw) {
		this.userPw = userPw;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getUserEmail() {
		return userEmail;
	}

	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}

	public Date getUserRegDate() {
		return userRegDate;
	}

	public void setUserRegDate(Date userRegDate) {
		this.userRegDate = userRegDate;
	}

	public Date getUserModDate() {
		return userModDate;
	}

	public void setUserModDate(Date userModDate) {
		this.userModDate = userModDate;
	}
	
	
}
