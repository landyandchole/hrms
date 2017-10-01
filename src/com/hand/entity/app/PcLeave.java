package com.hand.entity.app;

import java.util.Date;

import org.apache.james.mime4j.field.datetime.DateTime;

public class PcLeave {
	private String ID;
	private String USERNAME;
	private String NAME;
	private String RAM;
	private String HDISK;
	private String TYPE;
	private String ROOM;
	private String REMARK;
	private String PURPOSE;
	private Date EINLASS;
	private DateTime DATE;
	private String STATE;
	private String PCNUMBER;
	private String PROCESSINSTANCEID;
	private String TASKID;
	public String getTASKID() {
		return TASKID;
	}
	public void setTASKID(String tASKID) {
		TASKID = tASKID;
	}
	public String getID() {
		return ID;
	}
	public void setID(String iD) {
		ID = iD;
	}
	public String getUSERNAME() {
		return USERNAME;
	}
	public void setUSERNAME(String uSERNAME) {
		USERNAME = uSERNAME;
	}
	public String getNAME() {
		return NAME;
	}
	public void setNAME(String nAME) {
		NAME = nAME;
	}
	public String getRAM() {
		return RAM;
	}
	public void setRAM(String rAM) {
		RAM = rAM;
	}
	public String getHDISK() {
		return HDISK;
	}
	public void setHDISK(String hDISK) {
		HDISK = hDISK;
	}
	public String getTYPE() {
		return TYPE;
	}
	public void setTYPE(String tYPE) {
		TYPE = tYPE;
	}
	public String getROOM() {
		return ROOM;
	}
	public void setROOM(String rOOM) {
		ROOM = rOOM;
	}
	public String getREMARK() {
		return REMARK;
	}
	public void setREMARK(String rEMARK) {
		REMARK = rEMARK;
	}
	public String getPURPOSE() {
		return PURPOSE;
	}
	public void setPURPOSE(String pURPOSE) {
		PURPOSE = pURPOSE;
	}
	public Date getEINLASS() {
		return EINLASS;
	}
	public void setEINLASS(Date eINLASS) {
		EINLASS = eINLASS;
	}
	public DateTime getDATE() {
		return DATE;
	}
	public void setDATE(DateTime dATE) {
		DATE = dATE;
	}
	public String getSTATE() {
		return STATE;
	}
	public void setSTATE(String sTATE) {
		STATE = sTATE;
	}
	public String getPCNUMBER() {
		return PCNUMBER;
	}
	public void setPCNUMBER(String pCNUMBER) {
		PCNUMBER = pCNUMBER;
	}
	public String getPROCESSINSTANCEID() {
		return PROCESSINSTANCEID;
	}
	public void setPROCESSINSTANCEID(String pROCESSINSTANCEID) {
		PROCESSINSTANCEID = pROCESSINSTANCEID;
	}
	@Override
	public String toString() {
		return "PcLeave [ID=" + ID + ", USERNAME=" + USERNAME + ", NAME=" + NAME + ", RAM=" + RAM + ", HDISK=" + HDISK
				+ ", TYPE=" + TYPE + ", ROOM=" + ROOM + ", REMARK=" + REMARK + ", PURPOSE=" + PURPOSE + ", EINLASS="
				+ EINLASS + ", DATE=" + DATE + ", STATE=" + STATE + ", PCNUMBER=" + PCNUMBER + ", PROCESSINSTANCEID="
				+ PROCESSINSTANCEID + "]";
	}
	
}
