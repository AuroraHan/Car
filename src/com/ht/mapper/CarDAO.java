package com.ht.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.base.PageObject;
import com.ht.vo.CarVo;

public interface CarDAO {

	//入库
	public void carIn(CarVo car);
	//出库
	public void carOut(CarVo car);
	//查询列表
	public List<CarVo> findAll(CarVo car);

	public int count(@Param("car") CarVo car,@Param("pager") PageObject pager);
	
	public List<CarVo> findByCarNo(@Param("car") CarVo car,@Param("pager") PageObject pager);

	public CarVo findByStatus(CarVo car);
		
}
