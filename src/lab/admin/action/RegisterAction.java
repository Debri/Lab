package lab.admin.action;

import java.io.IOException;

import lab.admin.service.RegisterService;
import lab.bean.Register;
import lab.util.JsonUtil;

import com.google.gson.Gson;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

public class RegisterAction extends ActionSupport implements ModelDriven<Register>{

	private static final long serialVersionUID = 1L;
	private Register rgs = new Register();
	/*
	 * 获取注册用户信息
	 * */
	public String getRegister(){
		RegisterService rs = new RegisterService();
		Gson g = new Gson();
		try {
			JsonUtil.writeJson(g.toJson(rs.getRegister(rgs)));
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}
	/*
	 * 授权注册用户
	 * */
	public String grantRegister(){
		RegisterService rs = new RegisterService();
		Gson g = new Gson();
		try {
			JsonUtil.writeJson(g.toJson(rs.grantRegister(rgs)));
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}
	/*
	 * 删除注册用户
	 * */
	public String deleteRegister(){
		RegisterService rs = new RegisterService();
		Gson g = new Gson();
		try {
			JsonUtil.writeJson(g.toJson(rs.deleteRegister(rgs)));
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}
	public Register getModel() {
		return rgs;
	}
}
