package egovframework.example.postboard.service;

public class CommentsVO {
	
private static final long serialVersionUID = 1L;
	
	/** 원글 번호 */
	private String postNo;
	
	/** 댓글 번호(key값) */
	private String cno;
	
	/** 댓글 작성자 */
	private String writer;
	
	/** 댓글 내용 */
	private String content;
	
	/** 댓글 작성 일자*/
	private String regDate;
	
	public String getPostNo() {
		return postNo;
	}

	public void setPostNo(String postNo) {
		this.postNo = postNo;
	}

	public String getCno() {
		return cno;
	}

	public void setCno(String cno) {
		this.cno = cno;
	}

	public String getWriter() {
		return writer;
	}

	public void setWriter(String writer) {
		this.writer = writer;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getRegDate() {
		return regDate;
	}

	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}


}
