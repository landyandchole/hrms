package com.hand.entity.system;

import java.util.Date;

public class Video {
	
	private int ID;//主键
	private String VIDEONAME;//视频名称
	private String VIDEOPATH;//视频存储地址
	private Date UPLOADTIME;//上传时间
	private String USERNAME;//上传用户姓名
	private String VIDEOGROUP;//上传分组
	
	public int getID() {
		return ID;
	}
	public void setID(int iD) {
		ID = iD;
	}
	public String getVIDEONAME() {
		return VIDEONAME;
	}
	public void setVIDEONAME(String vIDEONAME) {
		VIDEONAME = vIDEONAME;
	}
	public String getVIDEOPATH() {
		return VIDEOPATH;
	}
	public void setVIDEOPATH(String vIDEOPATH) {
		VIDEOPATH = vIDEOPATH;
	}
	public Date getUPLOADTIME() {
		return UPLOADTIME;
	}
	public void setUPLOADTIME(Date uPLOADTIME) {
		UPLOADTIME = uPLOADTIME;
	}
	public String getUSERNAME() {
		return USERNAME;
	}
	public void setUSERNAME(String uSERNAME) {
		USERNAME = uSERNAME;
	}
	public String getVIDEOGROUP() {
		return VIDEOGROUP;
	}
	public void setVIDEOGROUP(String vIDEOGROUP) {
		VIDEOGROUP = vIDEOGROUP;
	}
	
	
	
}
