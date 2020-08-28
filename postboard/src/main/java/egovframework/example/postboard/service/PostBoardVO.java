package egovframework.example.postboard.service;

import java.util.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;

import org.apache.commons.lang3.time.DateFormatUtils;

import egovframework.example.postboard.web.PostBoardController;


public class PostBoardVO extends PostBoardDefaultVO {
	
	private static final long serialVersionUID = 1L;
	
	private String rn;
	/** 글 번호 */
	private String postNo = "";

	/** 글 제목 */
	private String postTitle;
	
	/** 글 내용 */
	private String postText;
	
	/** 글 조회수 */
	private int postViews;
	
	/** 삭제 여부 */
	private String postDel;
	
	/** 등록자 */
	private String postInsert;
	
	/** 등록일 */
	private Date postInsdt;
	
	/** 수정자 */
	private String postModify;
	
	/** 수정일 */
	private String postModdt;
	
	/** 계층형 게시판(답변)을 위한 추가 */
	
	/** 원글 번호 */
	private String originNo = "";
	
	/** 원글(답변 포함)에 대한 순서 **/
	private int groupOrd;
	
	private int groupLayer;

	private String cnt;
	
	private String formattedDate;

	
	public String getPostNo() {
		return postNo;
	}

	public void setPostNo(String postNo) {
		this.postNo = postNo;
	}

	public String getPostTitle() {
		return postTitle;
	}

	public void setPostTitle(String postTitle) {
		this.postTitle = postTitle;
	}

	public String getPostText() {
		return postText;
	}

	public void setPostText(String postText) {
		this.postText = postText;
	}

	public int getPostViews() {
		return postViews;
	}

	public void setPostViews(int postViews) {
		this.postViews = postViews;
	}

	public String getPostDel() {
		return postDel;
	}

	public void setPostDel(String postDel) {
		this.postDel = postDel;
	}

	public String getPostInsert() {
		return postInsert;
	}

	public void setPostInsert(String postInsert) {
		this.postInsert = postInsert;
	}

	public Date getPostInsdt() {
		return postInsdt;
	}

	public void setPostInsdt(Date postInsdt) {
		this.postInsdt = postInsdt;
	}
	
	public void setFormattedDate(String formattedDate) {
		this.formattedDate = formattedDate;
	}
	
	public String getFormattedDate() {
		if(formattedDate == null || "".equals(formattedDate)) {
			return "";
		} 
		SimpleDateFormat toFormat = new SimpleDateFormat("yyyy/MM/dd");
		//format(): 날짜를 원하는 형태의 문자열로 반환
		//parse(): 문자열 형태의 날짜를 원하는 대로 반환
		//Date는 util.Date
		this.formattedDate = toFormat.format(postInsdt); //this->field 영역
		return this.formattedDate;
	}

	public String getPostModify() {
		return postModify;
	}

	public void setPostModify(String postModify) {
		this.postModify = postModify;
	}

	public String getPostModdt() {
		return postModdt;
	}

	public void setPostModdt(String postModdt) {
		this.postModdt = postModdt;
	}

	public String getRn() {
		return rn;
	}

	public void setRn(String rn) {
		this.rn = rn;
	}

	public String getOriginNo() {
		return originNo;
	}

	public void setOriginNo(String originNo) {
		this.originNo = originNo;
	}

	public int getGroupOrd() {
		return groupOrd;
	}

	public void setGroupOrd(int groupOrd) {
		this.groupOrd = groupOrd;
	}


	public int getGroupLayer() {
		return groupLayer;
	}

	public void setGroupLayer(int groupLayer) {
		this.groupLayer = groupLayer;
	}

	public String getCnt() {
		return cnt;
	}

	public void setCnt(String cnt) {
		this.cnt = cnt;
	}

	
}
