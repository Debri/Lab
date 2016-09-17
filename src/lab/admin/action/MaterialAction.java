package lab.admin.action;

import java.io.IOException;

import lab.admin.service.MaterialService;
import lab.bean.Material;
import lab.util.JsonUtil;

import com.google.gson.Gson;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

public class MaterialAction extends ActionSupport implements ModelDriven<Material>{

	
	private static final long serialVersionUID = 1L;
	private Material mt = new Material();
	/*
	 * 管理员删除学习资料
	 * */
	public String deleteMaterial(){
		MaterialService ms = new MaterialService();
		Gson g = new Gson();
		try {
			JsonUtil.writeJson(g.toJson(ms.deleteMaterial(mt)));
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}
	public Material getModel() {
		return mt;
	}
}
