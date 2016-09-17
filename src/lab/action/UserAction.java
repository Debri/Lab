package lab.action;

import java.io.IOException;
import java.util.Map;

import lab.bean.User;
import lab.service.UserService;
import lab.util.JsonUtil;

import com.google.gson.Gson;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

public class UserAction extends ActionSupport implements ModelDriven<User>{
	
	private static final long serialVersionUID = 1L;
	private User user = new User();
	/*
	 * 用户登录验证
	 * */
	public String login(){
		Gson gson = new Gson();
		UserService us = new UserService();
		Map<String,Object> map = ActionContext.getContext().getSession(); 
		User u = us.login(user);
		map.put("user", u);
		try {
			JsonUtil.writeJson(gson.toJson(us.login(user)));
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	/*
	 * 用户退出登录
	 * */
	public String logout(){
		Map<String,Object> map = ActionContext.getContext().getSession();
		Gson gson = new Gson();
		boolean b = false;
		User s = (User)map.get("user");
		if(s == null){
			b = true;
			try {
				JsonUtil.writeJson(gson.toJson(b));
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		else if(s.getUserId().equals(user.getUserId())){
			map.remove("user");
			b = true;
			try {
				JsonUtil.writeJson(gson.toJson(b));
			} catch (IOException e) {
				e.printStackTrace();
			}
		}else{
			try {
				JsonUtil.writeJson(gson.toJson(b));
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return null;
	}
	/*
	 * 用户注册
	 * */
	public String register(){
		UserService us = new UserService();
		Gson g = new Gson();
		try {
			JsonUtil.writeJson(g.toJson(us.register(user)));
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	/*
	 * 根据类型获取所有用户信息
	 * */
	public String getUserByType(){
		UserService us = new UserService();
		Gson g = new Gson();
		try {
			JsonUtil.writeJson(g.toJson(us.getUserByType(user)));
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	/*
	 *通过userId获取自己的信息 
	 * */
	public String getUserByUserId(){
		UserService us = new UserService();
		Gson g = new Gson();
		try {
			JsonUtil.writeJson(g.toJson(us.getUserByUserId(user)));
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}
	/**
	 * 学生通过密保问题重置密码
	 */
	public String resetPasswordBySecurity(){
		UserService us=new UserService();
		Gson g=new Gson();
		try {
			JsonUtil.writeJson(g.toJson(us.resetPasswordBySecurity(user)));
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
	/**
	 *学生通过id获得密保问题
	 */
	public String  getSecurity(){
		UserService us=new UserService();
		Gson g=new Gson();
		try {
			JsonUtil.writeJson(g.toJson(us.getSecurity(user)));
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
	/*
	 * model注入
	 * */
	public User getModel() {
		return user;
	}
}
