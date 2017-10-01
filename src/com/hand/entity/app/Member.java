package com.hand.entity.app;

import java.util.Date;

public class Member {
 private String ID;
 private String MEMBER_ID;
 private String MEMBER_ROLE;
 private Date MEMBER_BTIME;
 private Date MEMBER_ETIME;
 private Double MEMBER_COST;
 private Double MEMBER_ACTUL;
 private String PROJECT_ID;
 private String FLAG;
 private String CREATIONUSER;
 private Date CREATIONDATE;
 private String UPDATEUSER;
 private Date UPDATEDATE;
public Member() {
	super();
}
public Member(String iD, String mEMBER_ID, String mEMBER_ROLE, Date mEMBER_BTIME, Date mEMBER_ETIME, Double mEMBER_COST,
		Double mEMBER_ACTUL, String pROJECT_ID, String fLAG, String cREATIONUSER, Date cREATIONDATE, String uPDATEUSER,
		Date uPDATEDATE) {
	super();
	ID = iD;
	MEMBER_ID = mEMBER_ID;
	MEMBER_ROLE = mEMBER_ROLE;
	MEMBER_BTIME = mEMBER_BTIME;
	MEMBER_ETIME = mEMBER_ETIME;
	MEMBER_COST = mEMBER_COST;
	MEMBER_ACTUL = mEMBER_ACTUL;
	PROJECT_ID = pROJECT_ID;
	FLAG = fLAG;
	CREATIONUSER = cREATIONUSER;
	CREATIONDATE = cREATIONDATE;
	UPDATEUSER = uPDATEUSER;
	UPDATEDATE = uPDATEDATE;
}
public String getID() {
	return ID;
}
public void setID(String iD) {
	ID = iD;
}
public String getMEMBER_ID() {
	return MEMBER_ID;
}
public void setMEMBER_ID(String mEMBER_ID) {
	MEMBER_ID = mEMBER_ID;
}
public String getMEMBER_ROLE() {
	return MEMBER_ROLE;
}
public void setMEMBER_ROLE(String mEMBER_ROLE) {
	MEMBER_ROLE = mEMBER_ROLE;
}
public Date getMEMBER_BTIME() {
	return MEMBER_BTIME;
}
public void setMEMBER_BTIME(Date mEMBER_BTIME) {
	MEMBER_BTIME = mEMBER_BTIME;
}
public Date getMEMBER_ETIME() {
	return MEMBER_ETIME;
}
public void setMEMBER_ETIME(Date mEMBER_ETIME) {
	MEMBER_ETIME = mEMBER_ETIME;
}
public Double getMEMBER_COST() {
	return MEMBER_COST;
}
public void setMEMBER_COST(Double mEMBER_COST) {
	MEMBER_COST = mEMBER_COST;
}
public Double getMEMBER_ACTUL() {
	return MEMBER_ACTUL;
}
public void setMEMBER_ACTUL(Double mEMBER_ACTUL) {
	MEMBER_ACTUL = mEMBER_ACTUL;
}
public String getPROJECT_ID() {
	return PROJECT_ID;
}
public void setPROJECT_ID(String pROJECT_ID) {
	PROJECT_ID = pROJECT_ID;
}
public String getFLAG() {
	return FLAG;
}
public void setFLAG(String fLAG) {
	FLAG = fLAG;
}
public String getCREATIONUSER() {
	return CREATIONUSER;
}
public void setCREATIONUSER(String cREATIONUSER) {
	CREATIONUSER = cREATIONUSER;
}
public Date getCREATIONDATE() {
	return CREATIONDATE;
}
public void setCREATIONDATE(Date cREATIONDATE) {
	CREATIONDATE = cREATIONDATE;
}
public String getUPDATEUSER() {
	return UPDATEUSER;
}
public void setUPDATEUSER(String uPDATEUSER) {
	UPDATEUSER = uPDATEUSER;
}
public Date getUPDATEDATE() {
	return UPDATEDATE;
}
public void setUPDATEDATE(Date uPDATEDATE) {
	UPDATEDATE = uPDATEDATE;
}




}
