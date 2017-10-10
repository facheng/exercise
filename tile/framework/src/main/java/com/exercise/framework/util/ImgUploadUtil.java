package com.dt.framework.util;

import java.awt.Color;
import java.awt.Graphics;
import java.awt.Image;
import java.awt.image.BufferedImage;
import java.awt.image.ConvolveOp;
import java.awt.image.Kernel;
import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URL;
import java.net.URLConnection;
import java.util.UUID;

import javax.swing.ImageIcon;

import org.apache.log4j.Logger;
import org.springframework.web.multipart.MultipartFile;

import com.sun.image.codec.jpeg.JPEGCodec;
import com.sun.image.codec.jpeg.JPEGEncodeParam;
import com.sun.image.codec.jpeg.JPEGImageEncoder;

/**
 * 图片上传工具，上传后的图片存储为jpg格式
 * @author wei
 */
public class ImgUploadUtil {
	protected final static Logger logger = Logger.getLogger(ImgUploadUtil.class);
	
	private static final int BUFFER_SIZE = 16 * 1024;
	

	public static String getAccessURL(String accessURL, String url) {
		return accessURL + "/" + url + Constant.IMG_TYPE_JPG;
	}

	public static String uploadFileAndResize(String storeURL, MultipartFile file, int width){
		try {
			String url = uploadFile(storeURL, file.getInputStream());
			return uploadFileAndResize(storeURL, url, width);
		} catch (IOException e) {
			logger.error(e.getLocalizedMessage());
			return "";
		}
	}

	public static String uploadFileAndResize(String storeURL, InputStream src, int width){
		String url = uploadFile(storeURL, src);
		return uploadFileAndResize(storeURL, url, width);
	}

	public static String uploadFileAndResize(String storeURL, File src, int width){
		String url = uploadFile(storeURL, src);
		return uploadFileAndResize(storeURL, url, width);
	}
	
	private static String uploadFileAndResize(String storeURL, String url, int width) {
		if(url == null || url.trim().equals("")) {
			return "";
		}
		String newUrl = url + "1";

		File oldFile = new File(storeURL + File.separator + url + Constant.IMG_TYPE_JPG);
		File newFile = new File(storeURL + File.separator + newUrl + Constant.IMG_TYPE_JPG);
		resize(oldFile, newFile, width);
		oldFile.delete();
		return newUrl;
	}
	
	public static void resize(File originalFile, File resizedFile, int newWidth){
		resize(originalFile, resizedFile, newWidth, 1);
	}
	public static void resize(File originalFile, File resizedFile, int newWidth, float quality) {
		try{
			if (quality > 1) {
				throw new IllegalArgumentException("Quality has to be between 0 and 1");
			}
			
			ImageIcon ii = new ImageIcon(originalFile.getCanonicalPath());
			Image i = ii.getImage();
			Image resizedImage = null;
			
			int iWidth = i.getWidth(null);
			int iHeight = i.getHeight(null);
			
			if(newWidth > iWidth) {
				newWidth = iWidth;
			}
			
			if (iWidth > iHeight) {
				resizedImage = i.getScaledInstance(newWidth, (newWidth * iHeight) / iWidth, Image.SCALE_SMOOTH);
			} else {
				resizedImage = i.getScaledInstance((newWidth * iWidth) / iHeight, newWidth, Image.SCALE_SMOOTH);
			}
			
			// This code ensures that all the pixels in the image are loaded.
			Image temp = new ImageIcon(resizedImage).getImage();
			
			// Create the buffered image.
			BufferedImage bufferedImage = new BufferedImage(temp.getWidth(null), temp.getHeight(null), BufferedImage.TYPE_INT_RGB);
			
			// Copy image to buffered image.
			Graphics g = bufferedImage.createGraphics();
			
			// Clear background and paint the image.
			g.setColor(Color.white);
			g.fillRect(0, 0, temp.getWidth(null), temp.getHeight(null));
			g.drawImage(temp, 0, 0, null);
			g.dispose();
			
			// Soften.
			float softenFactor = 0.05f;
			float[] softenArray = {0, softenFactor, 0, softenFactor, 1 - (softenFactor * 4), softenFactor, 0, softenFactor, 0};
			Kernel kernel = new Kernel(3, 3, softenArray);
			ConvolveOp cOp = new ConvolveOp(kernel, ConvolveOp.EDGE_NO_OP, null);
			bufferedImage = cOp.filter(bufferedImage, null);
			
			// Write the jpeg to a file.
			FileOutputStream out = new FileOutputStream(resizedFile);
			JPEGImageEncoder encoder = JPEGCodec.createJPEGEncoder(out);
			JPEGEncodeParam param = encoder.getDefaultJPEGEncodeParam(bufferedImage);
			param.setQuality(quality, true);
			encoder.setJPEGEncodeParam(param);
			encoder.encode(bufferedImage);
		} catch (IOException e) {
			logger.error(e.getLocalizedMessage());
		}
	}
	public static String uploadFileFromUrl(String storeURL, String urlStr) {
		try {
			URL url = new URL(urlStr);
			URLConnection con = url.openConnection();
			return uploadFile(storeURL, con.getInputStream());
		} catch (IOException e) {
			e.printStackTrace();
			throw new RuntimeException(e.getLocalizedMessage());
		}
	}
	
	/**
	 * 上传图片到服务端，返回存放的路径。
	 * 如"2013/04/12/8149a013-aef2-4114-a8e3-d10ba2ea5f1f"
	 * @param src
	 * @return
	 * @throws FileNotFoundException
	 */
	public static String uploadFile(String storeURL, File src){
		try {
			return uploadFile(storeURL, new FileInputStream(src));
		} catch (FileNotFoundException e) {
			e.printStackTrace();
			return "";
		}
	}
	public static String uploadFile(File src, String topDir){
		try {
			return uploadFile(new FileInputStream(src), topDir);
		} catch (FileNotFoundException e) {
			e.printStackTrace();
			return "";
		}
	}

	public static String uploadFile(String storeURL, InputStream is){
		String token = UUID.randomUUID() + "";
		uploadFile(is, storeURL, token + Constant.IMG_TYPE_JPG);
		
		return token;
	}
	public static String uploadFile(InputStream is, String topDir){
		String token = UUID.randomUUID() + "";
		uploadFile(is, topDir, token + Constant.IMG_TYPE_JPG);
		
		return token;
	}
	/**
	 * 将文件上传到storeDir目录下，以fileName命名
	 * @param is
	 * @param storeDir
	 * @param fileName
	 */
	private static void uploadFile(InputStream is, String storeDir, String fileName){
		InputStream in = null;
		OutputStream out = null;
		try {
			File folder = new File(storeDir);
			if (!folder.exists()) folder.mkdirs();
			
			File file = new File(storeDir + File.separator + fileName);
			in = new BufferedInputStream(is);
			out = new BufferedOutputStream(new FileOutputStream(file));
			byte[] buffer = new byte[BUFFER_SIZE];
			int len = 0;
			while ((len = in.read(buffer)) > 0) {
				out.write(buffer, 0, len);
			}
		} catch (Exception e) {
			logger.error(e.getLocalizedMessage());
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
	}
	
}
