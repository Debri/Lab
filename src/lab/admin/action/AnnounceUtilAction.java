package lab.admin.action;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.UUID;

import lab.admin.service.AnnounceService;
import lab.util.JsonUtil;

import com.google.gson.Gson;
import com.opensymphony.xwork2.ActionSupport;

public class AnnounceUtilAction extends ActionSupport {
	private static final long serialVersionUID = 1L;
	private File file;
	private String fileFileName;
	private String title;
	private String content;
	private String userName;
	
	//添加公告
	public String addAnnounceOf(){
		Gson g = new Gson();
		//创建文件夹
		File dir = new File("e:\\lab\\announce");
		if(!dir.exists()){
			dir.mkdirs();
		}
		UUID uuid = UUID.randomUUID(); 
		String url = "";
        String end ="";
        //判断文件是否有后缀
        if(this.getFileFileName().lastIndexOf(".") != -1){
        	end = this.getFileFileName().substring(this.getFileFileName().lastIndexOf("."));
        	url = dir+"\\"+uuid+end;
        }else{
        	url = dir+"\\"+uuid;
        }
        
        //将信息存入数据库
        AnnounceService as = new AnnounceService();
        //文件上传
        InputStream is = null;
		OutputStream os = null;
		try {
			is = new FileInputStream(file);
			os = new FileOutputStream(url);
			byte [] buf = new byte[1024];
			int length = 0 ; 
			while((length = is.read(buf) )>0)
			{	
				os.write(buf,0,length);
			}
			JsonUtil.writeJson(g.toJson(as.addAnnounceOf(this.title,this.content,this.userName,url,this.fileFileName)));
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			if(null != os){
				try {
					os.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
			if(null != is){
				try {
					is.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
		return null;
	}
	
	public File getFile() {
		return file;
	}
	public void setFile(File file) {
		this.file = file;
	}
	public String getFileFileName() {
		return fileFileName;
	}
	public void setFileFileName(String fileFileName) {
		this.fileFileName = fileFileName;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
}
