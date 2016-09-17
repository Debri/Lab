package lab.teacher.action;

import java.io.IOException;

import lab.bean.User;
import lab.teacher.service.UserService;
import lab.util.JsonUtil;

import com.google.gson.Gson;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

public class UserAction extends ActionSupport implements ModelDriven<User>{

	private static final long serialVersionUID = 1L;
	private User user = new User();

	

	/*
	 * 修改学生信息
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
	 * 重置学生密码为123
	 */
	public String resetStudentPassword(){
		UserService us=new UserService();
		Gson g=new Gson();
		try {
			JsonUtil.writeJson(g.toJson(us.resetUserPassword(user)));
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		//System.out.println(user.getUserId());
		
		return null;
	}

	public User getModel() {
		return user;
	}
	
}
