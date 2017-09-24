package com.dt.framework.util;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

/**
 * 文件上传
 * @author jiaosf 
 * @since 2015-7-9
 */
public class FileUploadUtil {
	private static final int BUFFER_SIZE = 16 * 1024;
	
	/**
	 * 文件上传
	 * @param inputStream
	 * @param fileName
	 * @return
	 * @throws IOException
	 */
	public static boolean fileUpload(InputStream inputStream ,String fileName) throws IOException{
		boolean result = false;
		InputStream in = null;
		OutputStream out = null;
		try {
			File file = new File(fileName);
			File parent = file.getParentFile(); 
			if(parent != null && !parent.exists()){
				parent.mkdirs();
			}
			if(!file.exists()){
				file.createNewFile();
			}
			in = new BufferedInputStream(inputStream);
			out = new BufferedOutputStream(new FileOutputStream(file));
			byte[] buffer = new byte[BUFFER_SIZE];
			int len = 0;
			while ((len = in.read(buffer)) > 0) {
				out.write(buffer, 0, len);
			}
			result = true;
			
		} catch (Exception e) {
			return result;
		} finally {
			if (in != null) {
				try {
					in.close();
				} catch (IOException e) {
					
				}
			}
			if (out != null) {
				try {
					out.close();
				} catch (IOException e) {
					
				}
			}
		}
		return result;
	}
	
}
