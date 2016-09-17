package lab.action;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.text.DecimalFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import lab.service.SoftWareService;
import lab.util.JsonUtil;

import com.google.gson.Gson;
import com.opensymphony.xwork2.ActionSupport;

public class SoftWareUtilAction extends ActionSupport {
	private static final long serialVersionUID = 1L;

	private static final int BUFFER_SIZE = 2 * 1024;

	private int id = -1;

	private File upload;
	private String name;
	private List<String> names;
	private String uploadFileName;
	private String uploadContentType;
	private String userId;
	//file size
	//updatetime 2016/8/16
	private String size;
	private int chunk;
	private int chunks;

	private String result;

	private void copy(File src, File dst) {
		InputStream in = null;
		OutputStream out = null;
		try {
			if (dst.exists()) {
				out = new BufferedOutputStream(new FileOutputStream(dst, true),
						BUFFER_SIZE);
			} else {
				out = new BufferedOutputStream(new FileOutputStream(dst),
						BUFFER_SIZE);
			}
			in = new BufferedInputStream(new FileInputStream(src), BUFFER_SIZE);

			byte[] buffer = new byte[BUFFER_SIZE];
			int len = 0;
			while ((len = in.read(buffer)) > 0) {
				out.write(buffer, 0, len);
			}
			out.flush();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (null != in) {
				try {
					in.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
			if (null != out) {
				try {
					out.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
	}

	public String upload() throws Exception {

		String path = "e:\\lab\\SoftWare";
		File filePath = new File(path);
		if (!filePath.exists()) {
			filePath.mkdirs();
		}
		String dstPath = path + "\\" + this.getName();
		File dstFile = new File(dstPath);
		// 文件已存在（上传了同名的文件）
		if (chunk == 0 && dstFile.exists()) {
			dstFile.delete();
			dstFile = new File(dstPath);
		}
		copy(this.upload, dstFile);
		//get file size
		//updatetime 2016/8/16
		DecimalFormat df = new DecimalFormat("#0.00"); 
		Double lenth=(double) dstFile.length();
    	String size = df.format(lenth/1024/1024)+"M";
		if (chunk == chunks - 1) {
			// 完成一整个文件;
			//将信息存入数据库
			System.out.println("完成");
			SoftWareService sws = new SoftWareService();
			boolean b = sws.addSoftWare(userId, uploadFileName, dstPath,size);
			if(b){
				Map<String,Object> map = new HashMap<String,Object>();
				map.put("status", true);
				map.put("name", this.getName());
				Gson g = new Gson();
				try {
					JsonUtil.writeJson(g.toJson(map));
				} catch (IOException e) {
					e.printStackTrace();
				}
			}else{
				Map<String,Object> map = new HashMap<String,Object>();
				map.put("status", false);
				map.put("name", this.getName());
				Gson g = new Gson();
				try {
					JsonUtil.writeJson(g.toJson(map));
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
		return null;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getId() {
		return id;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getName() {
		return name;
	}

	public void setNames(List<String> names) {
		this.names = names;
	}

	public List<String> getNames() {
		return names;
	}

	public File getUpload() {
		return upload;
	}

	public void setUpload(File upload) {
		this.upload = upload;
	}

	public String getUploadFileName() {
		return uploadFileName;
	}

	public void setUploadFileName(String uploadFileName) {
		this.uploadFileName = uploadFileName;
	}

	public String getUploadContentType() {
		return uploadContentType;
	}

	public void setUploadContentType(String uploadContentType) {
		this.uploadContentType = uploadContentType;
	}

	public int getChunk() {
		return chunk;
	}

	public void setChunk(int chunk) {
		this.chunk = chunk;
	}

	public int getChunks() {
		return chunks;
	}

	public void setChunks(int chunks) {
		this.chunks = chunks;
	}

	public void setResult(String result) {
		this.result = result;
	}

	public String getResult() {
		return result;
	}

	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getSize() {
		return size;
	}

	public void setSize(String size) {
		this.size = size;
	}
	
}
