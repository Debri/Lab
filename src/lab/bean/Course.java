package lab.bean;

public class Course {
	private int page;
	private int rows;
	private String sort;
	private String order;
	private int id;
	private int studentCourseId;
	private int teacherCourseId;
	private int courseId;
	private String teacherCourseDir;
	private String courseName;
	private String term;
	private String userName;
	private String addTime;
	private String ids;
	private String courseIds;
	//用于获取实验课程
	private String type;
	private String userId;
	//课程编号
	private String courseNumber;
	
	public String getCourseNumber() {
		return courseNumber;
	}
	public void setCourseNumber(String courseNumber) {
		this.courseNumber = courseNumber;
	}
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
	public int getCourseId() {
		return courseId;
	}
	public String getIds() {
		return ids;
	}
	public void setIds(String ids) {
		this.ids = ids;
	}
	public String getCourseIds() {
		return courseIds;
	}
	public void setCourseIds(String courseIds) {
		this.courseIds = courseIds;
	}
	public void setCourseId(int courseId) {
		this.courseId = courseId;
	}
	public String getTeacherCourseDir() {
		return teacherCourseDir;
	}
	public void setTeacherCourseDir(String teacherCourseDir) {
		this.teacherCourseDir = teacherCourseDir;
	}
	public String getCourseName() {
		return courseName;
	}
	public void setCourseName(String courseName) {
		this.courseName = courseName;
	}
	public String getTerm() {
		return term;
	}
	public void setTerm(String term) {
		this.term = term;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getAddTime() {
		return addTime;
	}
	public void setAddTime(String addTime) {
		this.addTime = addTime;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public int getStudentCourseId() {
		return studentCourseId;
	}
	public void setStudentCourseId(int studentCourseId) {
		this.studentCourseId = studentCourseId;
	}
	public int getTeacherCourseId() {
		return teacherCourseId;
	}
	public void setTeacherCourseId(int teacherCourseId) {
		this.teacherCourseId = teacherCourseId;
	}
}
