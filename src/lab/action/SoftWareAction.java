package lab.action;

import java.io.IOException;

import lab.bean.SoftWare;
import lab.service.SoftWareService;
import lab.util.JsonUtil;

import com.google.gson.Gson;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

public class SoftWareAction extends ActionSupport implements ModelDriven<SoftWare>{

	private static final long serialVersionUID = 1L;
	
	private SoftWare sw = new SoftWare();
	/*
	 * 获取学习软件信息
	 * */
	public String getSoftWare(){
		SoftWareService sws = new SoftWareService();
		Gson g = new Gson();
		try {
			JsonUtil.writeJson(g.toJson(sws.getSoftWare(sw)));
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}
	/*
	 * 删除学习软件
	 * */
	public String deleteSoftWareById(){
		SoftWareService sws = new SoftWareService();
		Gson g = new Gson();
		try {
			JsonUtil.writeJson(g.toJson(sws.deleteSoftWareById(sw)));
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}
	public SoftWare getModel() {
		return sw;
	}

}
