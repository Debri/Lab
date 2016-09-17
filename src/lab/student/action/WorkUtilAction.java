package lab.student.action;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;

import lab.student.service.WorkService;
import lab.util.JsonUtil;

import com.google.gson.Gson;
import com.opensymphony.xwork2.ActionSupport;

public class WorkUtilAction extends ActionSupport {

	private static final long serialVersionUID = 1L;
	private int studentCourseId;
	private int taskId;
	private String workDir;
	private String userId;
	private File file;
	private String fileFileName;

	public int getStudentCourseId() {
		return studentCourseId;
	}

	public void setStudentCourseId(int studentCourseId) {
		this.studentCourseId = studentCourseId;
	}

	public int getTaskId() {
		return taskId;
	}

	public void setTaskId(int taskId) {
		this.taskId = taskId;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getWorkDir() {
		return workDir;
	}

	public void setWorkDir(String workDir) {
		this.workDir = workDir;
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

	
	// 学生上传作业
	public String uploadWork() {
		
		WorkService ws = new WorkService();
		Gson g = new Gson();
		int i = 0;	
		String url = this.getWorkDir() + "\\" + this.getUserId() + "-"
				+ this.getFileFileName().replace("+", "-");
		File ef = new File(url);
		if(!ef.exists()){
			// 将数据插入数据库
			i = ws.uploadWork(
					this.getStudentCourseId(), this.getTaskId(),
					this.getUserId(), url, this.getFileFileName());
		}
		
		// 文件流
		InputStream is = null;
		OutputStream os = null;
		
		try {
			is = new FileInputStream(file);
			os = new FileOutputStream(url);
			byte[] buf = new byte[1024];
			int length = 0;
			while ((length = is.read(buf)) > 0) {
				os.write(buf, 0, length);
			}
			os.flush();
			//返回信息
			if(i > 0){
				JsonUtil.writeJson(g.toJson("作业上传成功"));
			}else{
				JsonUtil.writeJson(g.toJson("该作业已存在或上传失败"));
			}
			
		} catch (Exception e) {
			try {
				JsonUtil.writeJson(g.toJson(-1));
			} catch (IOException e1) {
				e1.printStackTrace();
			}
			e.printStackTrace();
		} finally {
			try {
				os.close();
			} catch (IOException e) {
				e.printStackTrace();
			} finally {
				try {
					is.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
		return null;
	}
}
