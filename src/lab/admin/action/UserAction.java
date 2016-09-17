package lab.admin.action;

import java.io.IOException;

import lab.admin.service.UserService;
import lab.bean.User;
import lab.util.JsonUtil;

import com.google.gson.Gson;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

public class UserAction extends ActionSupport implements ModelDriven<User>{

	private static final long serialVersionUID = 1L;
	private User user = new User();
	
	/*
	 * 添加用户信息
	 * */
	public String addUser(){
		UserService us = new UserService();
		Gson g = new Gson();
		try {
			JsonUtil.writeJson(g.toJson(us.addUser(user)));
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}
	/*
	 * 删除用户
	 * */
	
	public String deleteUser(){
		UserService us = new UserService();
		Gson g = new Gson();
		try {
			JsonUtil.writeJson(g.toJson(us.deleteUser(user)));
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	/*
	 * 修改自己的信息
	 * */
	public String  updateUser(){
		UserService us = new UserService();
		Gson g = new Gson();
		try {
			JsonUtil.writeJson(g.toJson(us.updateUser(user)));
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	} 
	
	public User getModel() {
		return user;
	}

}
