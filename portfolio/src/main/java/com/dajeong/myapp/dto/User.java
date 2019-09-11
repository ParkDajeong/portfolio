package com.dajeong.myapp.dto;

public class User {
	private String nickname;
	private String email;
	private String password;
	private int check;
	private String house;
	private String join_datetime;
	private String auth_key;
	
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public int getCheck() {
		return check;
	}
	public void setCheck(int check) {
		this.check = check;
	}
	public String getHouse() {
		return house;
	}
	public void setHouse(String house) {
		this.house = house;
	}
	public String getJoin_datetime() {
		return join_datetime;
	}
	public void setJoin_datetime(String join_datetime) {
		this.join_datetime = join_datetime;
	}
	public String getAuth_key() {
		return auth_key;
	}
	public void setAuth_key(String auth_key) {
		this.auth_key = auth_key;
	}
}
