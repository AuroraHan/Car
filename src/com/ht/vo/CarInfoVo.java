package com.ht.vo;

import java.io.Serializable;
import java.util.Date;

public class CarInfoVo implements Serializable {

	private int carInfoId;
	private String carNo;
	private String userName;
	private String mobile;
	private String startDate;
	private String expireDate;
	private String remark;
	private float remainMoney;
	public float getRemainMoney() {
		return remainMoney;
	}
	public void setRemainMoney(float remainMoney) {
		this.remainMoney = remainMoney;
	}
	private int diffDate;
	public int getDiffDate() {
		return diffDate;
	}
	public void setDiffDate(int diffDate) {
		this.diffDate = diffDate;
	}
	public int getCarInfoId() {
		return carInfoId;
	}
	public void setCarInfoId(int carInfoId) {
		this.carInfoId = carInfoId;
	}
	public String getCarNo() {
		return carNo;
	}
	public void setCarNo(String carNo) {
		this.carNo = carNo;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getMobile() {
		return mobile;
	}
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	public String getStartDate() {
		return startDate;
	}
	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}
	public String getExpireDate() {
		return expireDate;
	}
	public void setExpireDate(String expireDate) {
		this.expireDate = expireDate;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	
}
