package com.hand.util;

import java.io.BufferedOutputStream;
import java.io.OutputStream;
import java.net.URLEncoder;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 下载文件
 * @author:	HAND 赵帮恩
 * 修改日期：2017/06/15
 * @version
 */
public class FileDownload {

	/**
	 * @param response 
	 * @param filePath		//文件完整路径(包括文件名和扩展名)
	 * @param fileName		//下载后看到的文件名
	 * @return  文件名
	 */
	public static void fileDownload(final HttpServletResponse response, String filePath, String fileName) throws Exception{  
		   
		byte[] data = FileUtil.toByteArray2(filePath);  
	    fileName = URLEncoder.encode(fileName, "UTF-8");  
	    response.reset();  
	    response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\"");  
	    response.addHeader("Content-Length", "" + data.length);  
	    response.setContentType("application/octet-stream;charset=UTF-8");  
	    OutputStream outputStream = new BufferedOutputStream(response.getOutputStream());  
	    outputStream.write(data);  
	    outputStream.flush();  
	    outputStream.close();
	    response.flushBuffer();
	    
	} 
	
	public static void fileDownloads(final HttpServletRequest request,final HttpServletResponse response, String filePath, String fileName) throws Exception{  
		   
		byte[] data = FileUtil.toByteArray2(filePath);  
		String agent = request.getHeader("USER-AGENT");    
		String downLoadName = null;  
		if (null != agent && -1 != agent.indexOf("MSIE"))   //IE  
		{    
		  downLoadName = java.net.URLEncoder.encode(fileName, "UTF-8");   
		}    
		  else if (null != agent && -1 != agent.indexOf("Mozilla")) //Firefox  
		{        
		  downLoadName = new String(fileName.getBytes("UTF-8"),"iso-8859-1");     
		}    
		else     
		{  
		  downLoadName = java.net.URLEncoder.encode(fileName, "UTF-8");   
		}      
	    response.reset();  
	    response.setHeader("Content-Disposition", "attachment; filename=\"" + downLoadName + "\"");  
	    response.addHeader("Content-Length", "" + data.length);  
	    response.setContentType("application/octet-stream;charset=UTF-8");  
	    OutputStream outputStream = new BufferedOutputStream(response.getOutputStream());  
	    outputStream.write(data);  
	    outputStream.flush();  
	    outputStream.close();
	    response.flushBuffer();
	    
	} 

}
