package com.dajeong.myapp.dto;

public class Board {
	private int id;
	private int type;
	private String subject;
	private String content;
	private String writer_nickname;
	private String writer_email;
	private String register_datetime;
	private int read_count;
	private int reply_count;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getType() {
		return type;
	}
	public void setType(int type) {
		this.type = type;
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
	public String getWriter_nickname() {
		return writer_nickname;
	}
	public void setWriter_nickname(String writer_nickname) {
		this.writer_nickname = writer_nickname;
	}
	public String getWriter_email() {
		return writer_email;
	}
	public void setWriter_email(String writer_email) {
		this.writer_email = writer_email;
	}
	public String getRegister_datetime() {
		return register_datetime;
	}
	public void setRegister_datetime(String register_datetime) {
		this.register_datetime = register_datetime;
	}
	public int getRead_count() {
		return read_count;
	}
	public void setRead_count(int read_count) {
		this.read_count = read_count;
	}
	public int getReply_count() {
		return reply_count;
	}
	public void setReply_count(int reply_count) {
		this.reply_count = reply_count;
	}
}
