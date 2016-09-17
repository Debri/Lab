package lab.bean;

public class Task {
	private int page;
	private int rows;
	private String sort;
	private String order;
	private int id;
	//删除用
	private String ids;
	private String url;
	
	//发布人
	private String userName;
	private String courseName;//任务名
	private int teacherCourseId;
	private String taskName;
	private String addTime;
	private String workDir;
	private String fileNameF;//最终的文件名
	private String uuid;
	
	public int getPage() {
		return page;
	}
	public void setPage(int page) {
		this.page = page;
	}
	public int getRows() {
		return rows;
	}
	public void setRows(int rows) {
		this.rows = rows;
	}
	public String getSort() {
		return sort;
	}
	public void setSort(String sort) {
		this.sort = sort;
	}
	public String getOrder() {
		return order;
	}
	public void setOrder(String order) {
		this.order = order;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getCourseName() {
		return courseName;
	}
	public void setCourseName(String courseName) {
		this.courseName = courseName;
	}
	public int getTeacherCourseId() {
		return teacherCourseId;
	}
	public void setTeacherCourseId(int teacherCourseId) {
		this.teacherCourseId = teacherCourseId;
	}
	public String getTaskName() {
		return taskName;
	}
	public void setTaskName(String taskName) {
		this.taskName = taskName;
	}
	public String getAddTime() {
		return addTime;
	}
	public void setAddTime(String addTime) {
		this.addTime = addTime;
	}
	public String getWorkDir() {
		return workDir;
	}
	public void setWorkDir(String workDir) {
		this.workDir = workDir;
	}

	public String getIds() {
		return ids;
	}
	public void setIds(String ids) {
		this.ids = ids;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getUuid() {
		return uuid;
	}
	public void setUuid(String uuid) {
		this.uuid = uuid;
	}
	public void setFileNameF(String fileNameF) {
		this.fileNameF = fileNameF;
	}
	public String getFileNameF(){
		return fileNameF;
	}
	

}
