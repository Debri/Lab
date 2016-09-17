package lab.teacher.action;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.Date;
import java.util.UUID;

import lab.bean.Task;
import lab.teacher.service.TaskIdCheckService;
import lab.teacher.service.TaskService;
import lab.util.FileUtil;
import lab.util.JsonUtil;

import com.google.gson.Gson;
import com.opensymphony.xwork2.ActionSupport;

public class TaskUtilAction extends ActionSupport {
	private static final long serialVersionUID = 1L;
	private int teacherCourseId;
	private int courseId;
	private String taskName; // 第几次任务的名称
	private String userId;
	private String name;
	private int taskId;// 任务id
	private File file;
	private String fileFileName;
	private String url;
	private String workDir;

	public int getTeacherCourseId() {
		return teacherCourseId;
	}

	public void setTeacherCourseId(int teacherCourseId) {
		this.teacherCourseId = teacherCourseId;
	}

	public int getCourseId() {
		return courseId;
	}

	public void setCourseId(int courseId) {
		this.courseId = courseId;
	}

	public String getTaskName() {
		return taskName;
	}

	public void setTaskName(String taskName) {
		this.taskName = taskName;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
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

	public int getTaskId() {
		return taskId;
	}

	public void setTaskId(int taskId) {
		this.taskId = taskId;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getWorkDir() {
		return workDir;
	}

	public void setWorkDir(String workDir) {
		this.workDir = workDir;
	}

	// 上传实验任务
	public String addTask() {
		TaskIdCheckService tis = new TaskIdCheckService();
		int taskId1 = tis.getTaskIdCheckService() + 1;
		UUID uuid = UUID.randomUUID();
		String workDir = "e:\\work\\" + this.getCourseId() + "\\"
				+ this.getUserId() + "\\" + taskId1 + "\\";
		// 教师为学生提交作业创建文件夹
		File workDir1 = new File(workDir);
		Gson g = new Gson();
		if (!workDir1.exists()) {
			workDir1.mkdirs();
		}
		String url = workDir + uuid + "-" + this.getFileFileName();

		// 将信息存入数据库
		TaskService us = new TaskService();

		if (this.getFileFileName() != null) {
			// 文件上传
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
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				if (null != os) {
					try {
						os.close();
					} catch (IOException e) {
						e.printStackTrace();
					}
				}
				if (null != is) {
					try {
						is.close();
					} catch (IOException e) {
						e.printStackTrace();
					}
				}
			}
		}
		int i = us.addTask(this.getTeacherCourseId(), this.getTaskName(), url,
				workDir, this.getFileFileName());
		try {
			if (i > 0) {

				JsonUtil.writeJson(g.toJson("恭喜你，任务发布成功！"));

			} else {
				JsonUtil.writeJson(g.toJson("对不起，任务发布失败，请重新发布！"));
			}
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return null;
	}

	// 教师修改自己的实验指导书和任务名称
	public String updateTask() {
		UUID uuid = UUID.randomUUID();
		// 删除之前的实验指导书
		FileUtil.deleteFile(this.url);
		String url1 = this.workDir + uuid + "-" + this.getFileFileName();
		Task tk = new Task();
		tk.setUrl(url1);
		tk.setId(this.getTaskId());
		tk.setFileNameF(this.getFileFileName());
		tk.setTaskName(this.getTaskName());

		TaskService ts = new TaskService();
		Gson g = new Gson();
		if (ts.updateTask(tk) > 0) {
			// 文件上传
			InputStream is = null;
			OutputStream os = null;
			try {
				is = new FileInputStream(file);
				os = new FileOutputStream(url1);
				byte[] buf = new byte[1024];
				int length = 0;
				while ((length = is.read(buf)) > 0) {
					os.write(buf, 0, length);
				}
				os.flush();
				// 修改成功
				JsonUtil.writeJson(g.toJson("实验指导书修改成功！"));
			} catch (Exception e) {
				try {
					// 修改失败
					JsonUtil.writeJson(g.toJson("实验指导书修改失败！"));
				} catch (IOException e1) {
					e1.printStackTrace();
				}
				e.printStackTrace();
			} finally {
				if (null != os) {
					try {
						os.close();
					} catch (IOException e) {
						e.printStackTrace();
					}
				}
				if (null != is) {
					try {
						is.close();
					} catch (IOException e) {
						e.printStackTrace();
					}
				}
			}
		}
		return null;

	}

	// 只修改文件名
	public String onlyUpdateTask() {
		Task tk = new Task();
		tk.setId(this.getTaskId());
		tk.setTaskName(this.getTaskName());

		TaskService ts = new TaskService();
		Gson g = new Gson();
		if (ts.onlyUpdateTask(tk) > 0) {
			try {
				// 修改成功
				JsonUtil.writeJson(g.toJson("实验指导书修改成功！"));
			} catch (IOException e1) {
				e1.printStackTrace();
			}
		} else
			try {
				// 修改失败
				JsonUtil.writeJson(g.toJson("实验指导书修改失败！"));
			} catch (IOException e2) {
				e2.printStackTrace();
			}
		return null;
	}
}
