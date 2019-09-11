package com.dajeong.myapp.dto;

public class Reply {
	private int reply_id;
	private int board_id;
	private int depth;
	private int group_id;
	private int parent_id;
	private int order_no;
	private String reply_content;
	private String reply_writer_email;
	private String reply_writer_nickname;
	private String regDate;
	private String repyl_cnt;
	
	public int getReply_id() {
		return reply_id;
	}
	public void setReply_id(int reply_id) {
		this.reply_id = reply_id;
	}
	public int getBoard_id() {
		return board_id;
	}
	public void setBoard_id(int board_id) {
		this.board_id = board_id;
	}
	public int getDepth() {
		return depth;
	}
	public void setDepth(int depth) {
		this.depth = depth;
	}
	public int getGroup_id() {
		return group_id;
	}
	public void setGroup_id(int group_id) {
		this.group_id = group_id;
	}
	public int getParent_id() {
		return parent_id;
	}
	public void setParent_id(int parent_id) {
		this.parent_id = parent_id;
	}
	public int getOrder_no() {
		return order_no;
	}
	public void setOrder_no(int order_no) {
		this.order_no = order_no;
	}
	public String getReply_content() {
		return reply_content;
	}
	public void setReply_content(String reply_content) {
		this.reply_content = reply_content;
	}
	public String getReply_writer_email() {
		return reply_writer_email;
	}
	public void setReply_writer_email(String reply_writer_email) {
		this.reply_writer_email = reply_writer_email;
	}
	public String getReply_writer_nickname() {
		return reply_writer_nickname;
	}
	public void setReply_writer_nickname(String reply_writer_nickname) {
		this.reply_writer_nickname = reply_writer_nickname;
	}
	public String getRegDate() {
		return regDate;
	}
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
	public String getRepyl_cnt() {
		return repyl_cnt;
	}
	public void setRepyl_cnt(String repyl_cnt) {
		this.repyl_cnt = repyl_cnt;
	}
}
