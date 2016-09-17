package lab.admin.action;

import java.io.IOException;

import lab.admin.service.AnnounceService;
import lab.bean.Announce;
import lab.util.JsonUtil;

import com.google.gson.Gson;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

public class AnnounceAction extends ActionSupport implements ModelDriven<Announce>{

	private static final long serialVersionUID = 1L;
	private Announce anc = new Announce();
	/*
	 * 管理员发布实验公告(不带附件)
	 * */
	public String addAnnounce(){
		AnnounceService as = new AnnounceService();
		Gson g = new Gson();
		try {
			JsonUtil.writeJson(g.toJson(as.addAnnounce(anc)));
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}
	/*
	 * 删除公告
	 * */
	public String deleteAnnounce(){
		AnnounceService as = new AnnounceService();
		Gson g = new Gson();
		try {
			JsonUtil.writeJson(g.toJson(as.deleteAnnounce(anc)));
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}
	public Announce getModel() {
		return anc;
	}
}
