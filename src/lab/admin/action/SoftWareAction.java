package lab.admin.action;

import java.io.IOException;

import lab.admin.service.SoftWareService;
import lab.bean.SoftWare;
import lab.util.JsonUtil;

import com.google.gson.Gson;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

public class SoftWareAction extends ActionSupport implements ModelDriven<SoftWare>{

	private static final long serialVersionUID = 1L;
	private SoftWare sw = new SoftWare();
	/*
	 * 删除学习软件
	 * */
	public String deleteSoftWare(){
		SoftWareService sws = new SoftWareService();
		Gson g = new Gson();
		try {
			JsonUtil.writeJson(g.toJson(sws.deleteSoftWare(sw)));
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}
	public SoftWare getModel() {
		return sw;
	}

}
