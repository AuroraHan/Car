package com.ht.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.ht.vo.FinanceVo;

public interface FinanceDAO {

	public void financeAdd(FinanceVo finance);
	public List<FinanceVo> findAll(@Param("carNo") String carNo);
	public List<FinanceVo> financeStat(@Param("curYear") int curYear);
	
	
}
