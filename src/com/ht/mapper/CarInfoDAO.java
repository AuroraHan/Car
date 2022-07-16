package com.ht.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.ht.vo.CarInfoVo;

public interface CarInfoDAO {

	public void carAdd(CarInfoVo carInfo);
	public List<CarInfoVo> findAll(@Param("carNo") String carNo);
	public void updateCarInfo(CarInfoVo carInfo);
	public CarInfoVo get(int carInfoId);
	public void del(int carInfoId);
	public CarInfoVo findCarbyCarId(@Param("carNo") String carNo);
	public void updateMoney(CarInfoVo carInfo);
	
	
}
