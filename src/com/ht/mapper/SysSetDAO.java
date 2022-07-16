package com.ht.mapper;

import com.ht.vo.SysSetVo;

public interface SysSetDAO {

	//获取参数
	public SysSetVo getSet();
	//修改参数
	public void updateSet(SysSetVo sysSet);
		
}
