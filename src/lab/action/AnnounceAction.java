package lab.action;

import lab.bean.Announce;

import lab.service.AnnounceService;
import lab.util.JsonUtil;

import com.google.gson.Gson;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

public class AnnounceAction extends ActionSupport implements ModelDriven<Announce>{

	private static final long serialVersionUID = 1L;
	private Announce anc = new Announce();
	
	/*
	 * 获取公告信息
	 * */
	public String getAnnounce(){
		AnnounceService as = new AnnounceService();
		Gson gson = new Gson();
		try {
			JsonUtil.writeJson(gson.toJson(as.getAnnounce(anc)));
		} catch (Exception e) {
			e.printStackTrace();
		} 
		return null;
	}
	/*
	 * 通过id查看公告信息
	 * */
	public String getAnnounceById(){
		AnnounceService as = new AnnounceService();
		Gson gson = new Gson();
		try {
			JsonUtil.writeJson(gson.toJson(as.getAnnounceById(anc)));
		} catch (Exception e) {
			e.printStackTrace();
		} 
		return null;
	}
	public Announce getModel() {
		return anc;
	}
}
