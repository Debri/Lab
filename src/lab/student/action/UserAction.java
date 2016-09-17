package lab.student.action;

import java.io.IOException;

import lab.bean.User;
import lab.student.service.UserService;
import lab.util.JsonUtil;

import com.google.gson.Gson;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

public class UserAction extends ActionSupport implements ModelDriven<User>{

	
	private static final long serialVersionUID = 1L;
	private User user = new User();
	/*
	 * 学生修改自己的信息
	 * */
	public String updateUser(){
		UserService us = new UserService();
		Gson g = new Gson();
		try {
			JsonUtil.writeJson(g.toJson(us.updateUser(user)));
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}
	/**
	 * 学生修改自己的密码并设置密保
	 */
	public String modifyPasswordAndSecurity(){
		UserService us=new UserService();
		Gson g=new Gson();
		try {
			JsonUtil.writeJson(g.toJson(us.updatePasswordAndSecurity(user)));
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}

	public User getModel() {
		return user;
	}
	
}
