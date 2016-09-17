package lab.action;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;
import java.util.StringTokenizer;
import java.util.UUID;

import lab.util.FileUtil;

import com.opensymphony.xwork2.ActionSupport;

public class WorkUtilAction extends ActionSupport {
	private static final long serialVersionUID = 1L;
	private String urls;
	private String num;
	public String downloadWork() throws Exception {
		
		List<File> al = new ArrayList<File>();
		File file = null;

		// 创建临时文件夹
		File temFilePath = new File("e:\\lab\\tem");
		if (!temFilePath.exists()) {
			temFilePath.mkdirs();
		}
//		String s = new String(urls.getBytes("iso-8859-1"), "GBk");
//		System.out.println(urls);
		// 文件地址分割
		StringTokenizer st = new StringTokenizer(urls, ","); // 可以更换分隔符
		while (st.hasMoreTokens()) {
			// 合理
			String url = st.nextToken();
			File path = new File(url.replace("\\\\", "\\\\\\\\"));
			if (path.isFile()) {
				file = new File(url);
				al.add(file);
			}
		}
		//生成临时文件名
		String uuid = UUID.randomUUID().toString();
		// 压缩文件到临时文件夹并返回文件名
		String temFileName = FileUtil.doCompressFiles(al, temFilePath + "\\"
				+ uuid+".zip");
		//设置返回流路径
		this.setUrls(temFileName);
		
		//添加打包信息系统
		/*WorkService ts = new WorkService();
		ts.addTem(this.urls,this.getNum());*/
		// 必须的
		return SUCCESS;
	}

	// 获得下载文件的内容，可以直接读入一个物理文件或从数据库中获取内容
	public InputStream getInputStream() throws Exception {
		// return new FileInputStream("somefile.rar"); 直接下载 somefile.rar
		// 和 Servlet 中不一样，这里我们不需对输出的中文转码为 ISO8859-1
		return new FileInputStream(this.urls);
	}
	public String getUrls() {
		return urls;
	}

	public void setUrls(String urls) {
		this.urls = urls;
	}

	// 对于配置中的 ${fileName}, 获得下载保存时的文件名
	public String getFileName() throws UnsupportedEncodingException {
		return new String(( this.num+"作业.zip").getBytes(), "iso-8859-1");
	}

	public String getNum() {
		return num;
	}

	public void setNum(String num) {
		this.num = num;
	}
	
	
}
