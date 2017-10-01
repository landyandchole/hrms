package com.hand.entity.app;

import java.util.List;


public class VideoGroup {

	private String NAME;			//名称
	private String NAME_EN;			//英文名称
	private String BIANMA;			//编码
	private String PARENT_ID;		//上级ID
	private String HEADMAN;			//负责人
	private String BZ;				//备注
	private String VIDEO_ID;	//主键
	private String target;
	private VideoGroup video;
	private List<VideoGroup> subVideo;
	private boolean hasVideo = false;
	private String treeurl;
	private String icon;
	
	public String getIcon() {
		return icon;
	}
	public void setIcon(String icon) {
		this.icon = icon;
	}
	public String getNAME() {
		return NAME;
	}
	public void setNAME(String nAME) {
		NAME = nAME;
	}
	public String getNAME_EN() {
		return NAME_EN;
	}
	public void setNAME_EN(String nAME_EN) {
		NAME_EN = nAME_EN;
	}
	public String getBIANMA() {
		return BIANMA;
	}
	public void setBIANMA(String bIANMA) {
		BIANMA = bIANMA;
	}
	public String getPARENT_ID() {
		return PARENT_ID;
	}
	public void setPARENT_ID(String pARENT_ID) {
		PARENT_ID = pARENT_ID;
	}
	public String getHEADMAN() {
		return HEADMAN;
	}
	public void setHEADMAN(String hEADMAN) {
		HEADMAN = hEADMAN;
	}
	
	
	public String getBZ() {
		return BZ;
	}
	public void setBZ(String bZ) {
		BZ = bZ;
	}

	public String getVIDEO_ID() {
		return VIDEO_ID;
	}
	public void setVIDEO_ID(String vIDEO_ID) {
		VIDEO_ID = vIDEO_ID;
	}
	public String getTarget() {
		return target;
	}
	public void setTarget(String target) {
		this.target = target;
	}
	public VideoGroup getVideo() {
		return video;
	}
	public void setVideo(VideoGroup video) {
		this.video = video;
	}
	public List<VideoGroup> getSubVideo() {
		return subVideo;
	}
	public void setSubVideo(List<VideoGroup> subVideo) {
		this.subVideo = subVideo;
	}
	public boolean isHasVideo() {
		return hasVideo;
	}
	public void setHasVideo(boolean hasVideo) {
		this.hasVideo = hasVideo;
	}
	public String getTreeurl() {
		return treeurl;
	}
	public void setTreeurl(String treeurl) {
		this.treeurl = treeurl;
	}
	@Override
	public String toString() {
		return "Video [NAME=" + NAME + ", NAME_EN=" + NAME_EN + ", BIANMA="
				+ BIANMA + ", PARENT_ID=" + PARENT_ID + ", HEADMAN=" + HEADMAN
				+ ", BZ=" + BZ + ", VIDEO_ID=" + VIDEO_ID + ", target="
				+ target + ", video=" + video + ", subVideo=" + subVideo
				+ ", hasVideo=" + hasVideo + ", treeurl=" + treeurl + ", icon="
				+ icon + "]";
	}
	
}