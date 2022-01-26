package com.itwillbs.board;

import java.sql.Date;

public class BoardDTO { // Data Transfer Object
	// BoardBean와 동일함
	// => 디비 테이블에 있는 정보를 한번에 저장하는 객체
	
	private int num; 			// 글번호(pk)
	private String name; 		//글쓴이
	private String pass; 		// 글비밀번호
	private String subject; 	// 글 제목
	private String content; 	// 글 내용
	private int readcount; 		// 조회수
	private int re_ref; 		// 답글-그룹번호
	private int re_lev; 		// 답글-레벨값(깊이)
	private int re_seq; 		// 답글-순서
	private Date date; 			// 날짜정보
	private String ip; 			// ip주소
	private String file; 		// 파일정보(파일 이름정보)
	
	
	//alt shift s + r
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPass() {
		return pass;
	}
	public void setPass(String pass) {
		this.pass = pass;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public int getReadcount() {
		return readcount;
	}
	public void setReadcount(int readcount) {
		this.readcount = readcount;
	}
	public int getRe_ref() {
		return re_ref;
	}
	public void setRe_ref(int re_ref) {
		this.re_ref = re_ref;
	}
	public int getRe_lev() {
		return re_lev;
	}
	public void setRe_lev(int re_lev) {
		this.re_lev = re_lev;
	}
	public int getRe_seq() {
		return re_seq;
	}
	public void setRe_seq(int re_seq) {
		this.re_seq = re_seq;
	}
	public Date getDate() {
		return date;
	}
	public void setDate(Date date) {
		this.date = date;
	}
	public String getIp() {
		return ip;
	}
	public void setIp(String ip) {
		this.ip = ip;
	}
	public String getFile() {
		return file;
	}
	public void setFile(String file) {
		this.file = file;
	}
	
	// alt shift s + s
	@Override
	public String toString() {
		return "BoardDTO [num=" + num + ", name=" + name + ", pass=" + pass + ", subject=" + subject + ", content="
				+ content + ", readcount=" + readcount + ", re_ref=" + re_ref + ", re_lev=" + re_lev + ", re_seq="
				+ re_seq + ", date=" + date + ", ip=" + ip + ", file=" + file + "]";
	}
	
	
	
	
}
