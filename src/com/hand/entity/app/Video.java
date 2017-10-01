package com.hand.entity.app;

import java.util.Date;

public class Video {

	private String ID;//主键
	private String VIDEONAME;//视频名称
	private String VIDEOPATH;//存储路径
	private Date UPLOADTIME;//上传时间
	private String USERNAME;//上传者用户名
	private String VIDEOGROUP;//分组名
	
	private VideoGroup videoGroup;
	
	public Video(){
		
	}
	public String getID() {
		return ID;
	}
	public void setID(String iD) {
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
	public VideoGroup getVideoGroup() {
		return videoGroup;
	}
	public void setVideoGroup(VideoGroup videoGroup) {
		this.videoGroup = videoGroup;
	}
	@Override
	public String toString() {
		return "Video [ID=" + ID + ", VIDEONAME=" + VIDEONAME + ", VIDEOPATH="
				+ VIDEOPATH + ", UPLOADTIME=" + UPLOADTIME + ", USERNAME="
				+ USERNAME + ", VIDEOGROUP=" + VIDEOGROUP + "]";
	}
	

}
