package lab.action;

import java.io.File;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;

import com.opensymphony.xwork2.ActionSupport;

public class DownloadAction extends ActionSupport {
	private static final long serialVersionUID = 1L;
	// 返回流的文件名
	private String fileName;
	// 接收的文件名
	private String url;

	// 统一单文件下载方法
	public String downloadFile() {

		// 创建不存在的文件
		String noUrl = "e:\\lab\\tem\\文件不存在.txt";
		File noPath = new File("e:\\lab\\tem");
		if (!noPath.exists()) {
			noPath.mkdirs();
		}
		File noFile = new File(noUrl);
		try {
			if (!noFile.createNewFile()) {
				noFile.mkdir();
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
		// 判断地址
		if (null == url || url.equals("")) {
			this.fileName = "文件不存在";
			this.url = noUrl;
		} else {

			File path = new File(this.getUrl().replace("\\\\", "\\\\\\\\"));
			if (path.exists()) {
				if (path.isFile()) {
					this.setUrl(url.replaceAll("\\\\", "\\\\\\\\"));
				}
				if (path.isDirectory()) {
					this.fileName = "文件不存在";
					this.url = noUrl;
				}
			} else {
				this.fileName = "文件不存在";
				this.url = noUrl;
			}
		}

		// 这里必须要返回，否则下载不了
		return SUCCESS;
	}

	// 获得下载文件的内容，可以直接读入一个物理文件或从数据库中获取内容
	public InputStream getInputStream() throws Exception {
		// 和 Servlet 中不一样，这里我们不需对输出的中文转码为 ISO8859-1
		// 这只需要换为url即可
		return new FileInputStream(this.url);
	}

	// 对于配置中的 ${fileName}, 获得下载保存时的文件名
	public String getFileName() throws UnsupportedEncodingException {
		return new String(fileName.getBytes(), "iso-8859-1");
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}
}
