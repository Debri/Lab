package lab.action;

import lab.bean.Material;
import lab.service.MaterialService;
import lab.util.JsonUtil;

import com.google.gson.Gson;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

public class MaterialAction extends ActionSupport implements ModelDriven<Material>{

	private static final long serialVersionUID = 1L;

	private Material mt = new Material();
	/*
	 * 获取学习资料信息
	 * */
	public String getMaterial(){
		MaterialService ms = new MaterialService();
		Gson gson = new Gson();
		try {
			JsonUtil.writeJson(gson.toJson(ms.getMaterial(mt)));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	/*
	 * 删除学习资料
	 * */
	public String deleteMaterialById(){
		MaterialService ms = new MaterialService();
		Gson gson = new Gson();
		try {
			JsonUtil.writeJson(gson.toJson(ms.deleteMaterialById(mt)));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	public Material getModel() {
		return mt;
	}
}
