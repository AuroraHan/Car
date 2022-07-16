package com.ht.vo;

import java.io.Serializable;

public class SysSetVo implements Serializable {

	private int sysSetId;
	private int mianfeiTime;//免费时间（分钟)
	private int shoufeiTime;//收费时间基数(分钟)
	private float shoufeiMoney;//收费金额(收费时间基数)
	
	public int getSysSetId() {
		return sysSetId;
	}
	public void setSysSetId(int sysSetId) {
		this.sysSetId = sysSetId;
	}
	public int getMianfeiTime() {
		return mianfeiTime;
	}
	public void setMianfeiTime(int mianfeiTime) {
		this.mianfeiTime = mianfeiTime;
	}
	public int getShoufeiTime() {
		return shoufeiTime;
	}
	public void setShoufeiTime(int shoufeiTime) {
		this.shoufeiTime = shoufeiTime;
	}
	public float getShoufeiMoney() {
		return shoufeiMoney;
	}
	public void setShoufeiMoney(float shoufeiMoney) {
		this.shoufeiMoney = shoufeiMoney;
	}
}
