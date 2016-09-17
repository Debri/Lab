package lab.util;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.List;

import org.apache.commons.compress.archivers.zip.Zip64Mode;
import org.apache.commons.compress.archivers.zip.ZipArchiveEntry;
import org.apache.commons.compress.archivers.zip.ZipArchiveOutputStream;

public class FileUtil {

	// 删除文件(单文件删除)
	public static boolean deleteFile(String fileName) {
		boolean b = false;
		fileName.replaceAll("\\\\", "\\\\\\\\");
		File file = new File(fileName);
		if (!file.exists()) {
			return b;
		} else {
			file.delete();
			b = true;
		}
		return b;
	}

	// 删除目录及以下的文件
	public static boolean deleteDir(File dir) {
		if (dir.isDirectory()) {
			String[] children = dir.list();//以字符串形式返回目录下的所有文件
			// 递归删除目录中的子目录下
			for (int i = 0; i < children.length; i++) {
				boolean success = deleteDir(new File(dir, children[i]));
				if (!success) {
					return false;
				}
			}
		}
		// 目录此时为空，可以删除
		return dir.delete();
	}
	//删除空文件
	public static boolean deleteDirs(File dir) {
		
		if (dir.isDirectory()) {
			File[] files = dir.listFiles();//以file对象形式返回此目录下的所有文件
			for(int i=0;i<files.length ;i++){
				if(files[i].isDirectory()){
					boolean success = deleteDirs(files[i]);//是不是加else files[i].delete();-----------------
					if (!success) {
						return false;
					}
				}
			}
		}
		return dir.delete();
	} 

	// 上传文件
	public static boolean uploadFile(InputStream is, String file) {
		boolean b = false;
		OutputStream os = null;
		try {
			os = new FileOutputStream(file);
			byte[] buf = new byte[1024];
			int length = 0;
			while ((length = is.read(buf)) > 0) {
				os.write(buf, 0, length);
			}
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			if (os != null) {
				try {
					os.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
			if (is != null) {
				try {
					is.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
		return b;
	}

	// 多文件压缩
	public static String doCompressFiles(List<File> files, String temFileName) {
		ZipArchiveOutputStream zos = null;
		if (files.size() >= 0) {
			File tem = new File(temFileName);
			if (!tem.exists()) {
				try {
					tem.createNewFile();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}

			try {
				zos = new ZipArchiveOutputStream(tem);
				zos.setUseZip64(Zip64Mode.AsNeeded);
				for (File file : files) {
					ZipArchiveEntry zipArchiveEntry = new ZipArchiveEntry(file,
							file.getName());
					zos.putArchiveEntry(zipArchiveEntry);
					InputStream is = null;
					try {
						is = new BufferedInputStream(new FileInputStream(file));
						byte[] buf = new byte[1024 * 4];
						int len = 0;
						while ((len = is.read(buf)) > 0) {
							// 把缓冲区的字节写入到ZipArchiveEntry
							zos.write(buf, 0, len);
						}
						zos.closeArchiveEntry();
					} catch (Exception e) {
						e.printStackTrace();
						throw new RuntimeException(e);
					} finally {
						if (is != null)
							is.close();
					}
				}
				zos.finish();
			} catch (IOException e) {
				e.printStackTrace();
			} finally {
				try {
					if (null != zos) {
						zos.close();
					}
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
		return temFileName;
	}
}
