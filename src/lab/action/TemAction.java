package lab.action;

import java.io.File;
import java.io.IOException;

import lab.util.FileUtil;
import lab.util.JsonUtil;

import com.google.gson.Gson;
import com.opensymphony.xwork2.ActionSupport;

public class TemAction extends ActionSupport {

	private static final long serialVersionUID = 1L;
	private String url;
	/*
	 * 文件清理
	 * */
	public String clear(){
		Gson g = new Gson();
		File dir = new File(this.url);
		if(!dir.exists()){
			try {
				JsonUtil.writeJson(g.toJson(false));
			} catch (IOException e) {
				e.printStackTrace();
			}
		}else{
			try {
				JsonUtil.writeJson(g.toJson(FileUtil.deleteDir(dir)));
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return null;
	}
	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}
}
