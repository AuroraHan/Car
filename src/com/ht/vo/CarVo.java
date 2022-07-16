package com.ht.vo;

import java.io.Serializable;
import java.util.Date;

public class CarVo implements Serializable{

	private long carId;
	private String cardNo;//车牌
	private String inTime;//入场时间
	private String outTime;//入场时间
	private String inPic;//入场图片
	private String outPic;//出场图片
	private float carFee;//停车费
	private int status;//状态0：未收费，1已收费，2：免费
	private String userName;//收费员
	private String remark;//备注
	private int financeType;//1:包月，2：临时停车
	private int minutes;//停车时长（分钟）
	public int getMinutes() {
		return minutes;
	}
	public void setMinutes(int minutes) {
		this.minutes = minutes;
	}
	public int getFinanceType() {
		return financeType;
	}
	public void setFinanceType(int financeType) {
		this.financeType = financeType;
	}
	public long getCarId() {
		return carId;
	}
	public void setCarId(long carId) {
		this.carId = carId;
	}
	public String getCardNo() {
		return cardNo;
	}
	public void setCardNo(String cardNo) {
		this.cardNo = cardNo;
	}
	public String getInTime() {
		return inTime;
	}
	public void setInTime(String inTime) {
		this.inTime = inTime;
	}
	public String getOutTime() {
		return outTime;
	}
	public void setOutTime(String outTime) {
		this.outTime = outTime;
	}
	public String getInPic() {
		return inPic;
	}
	public void setInPic(String inPic) {
		this.inPic = inPic;
	}
	public String getOutPic() {
		return outPic;
	}
	public void setOutPic(String outPic) {
		this.outPic = outPic;
	}
	public float getCarFee() {
		return carFee;
	}
	public void setCarFee(float carFee) {
		this.carFee = carFee;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
}
