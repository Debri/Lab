package lab.admin.action;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.List;

import lab.admin.service.CourseService;
import lab.bean.Course;
import lab.util.JsonUtil;

import com.google.gson.Gson;
import com.opensymphony.xwork2.ActionSupport;

public class CourseUtilAction extends ActionSupport {
	private static final long serialVersionUID = 1L;

	private File file; // 上传的文件
	private String fileFileName; // 保存原始文件名
	
	
	/*
	 * 管理员批量导入课程信息
	 */
	public String addAllCourse() {
		/*
		 * 获取客服端上传的文件流
		 * */
		InputStream is = null;
		OutputStream os = null;
		String url = "E:\\lab\\tem";
		File f = new File(url);
		if(!f.exists()){
			f.mkdirs();
		}
		url += "\\"+this.fileFileName;
		try {
			is = new FileInputStream(file);
			os = new FileOutputStream(url);
			byte [] buf = new byte[1024];
			int length = 0 ; 
			while((length = is.read(buf) )>0)
			{	
				os.write(buf,0,length);
			}
		}catch(Exception e){
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
		/*
		 * 创建文件用于导入信息
		 */
		File fi = new File(url);
		/*
		 * 获取客服端要批量添加课程的文件并将信息存入List中
		 * */
		List<Course> al = null;
		try {
			al = CourseExcel.readExcel(fi);
		} catch (IOException e1) {
			e1.printStackTrace();
		}
		
		/*
		 * 将List中用户的信息放入数据库并将传到客服端
		 * */
		CourseService cs = new CourseService();
		Gson g = new Gson();
		int total = cs.addAllCourse(al);
		/*
		 * 删除临时文件
		 * */
		fi.delete();
		/*
		 * 将信息写回客服端
		 * */
		try {
			if(total > 0){
				JsonUtil.writeJson(g.toJson("总共导入了 "+total+" 门课程！"));
			}else{
				JsonUtil.writeJson(g.toJson("对不起，课程导入失败！"));
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}

	public String getFileFileName() {
		return fileFileName;
	}

	public void setFileFileName(String fileFileName) {
		this.fileFileName = fileFileName;
	}

	public File getFile() {
		return file;
	}

	public void setFile(File file) {
		this.file = file;
	}
}
