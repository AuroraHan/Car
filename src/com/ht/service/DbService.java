package com.ht.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.base.PageObject;
import com.ht.mapper.CarDAO;
import com.ht.mapper.CarInfoDAO;
import com.ht.mapper.FinanceDAO;
import com.ht.mapper.SysSetDAO;
import com.ht.mapper.UserDAO;
import com.ht.vo.CarInfoVo;
import com.ht.vo.CarVo;
import com.ht.vo.FinanceVo;
import com.ht.vo.SysSetVo;
import com.ht.vo.UserVo;

//加入服务注解，表示这个类是一个服务层，操作数据库的类
@Service
public class DbService {
	//注入MyBatis的数据库操作类
	@Resource 
	UserDAO userDAO;
	@Resource
	CarDAO carDAO;
	@Resource
	SysSetDAO sysDAO;
	@Resource
	CarInfoDAO carInfoDAO;
	@Resource
	FinanceDAO financeDAO;
	//入库
	@Transactional
	public void carIn(CarVo car){
		carDAO.carIn(car);
	}
	//出库
	@Transactional
	public void carOut(CarVo car){
		carDAO.carOut(car);
	}
	//列表
	@Transactional
	public List<CarVo> findAll(CarVo car){
		return carDAO.findAll(car);
	}
	@Transactional
	public int count(CarVo carVo,PageObject pager){
		return carDAO.count(carVo, pager);
	}
	@Transactional
	public List<CarVo> findByCarNo(CarVo carVo,PageObject pager){
		return carDAO.findByCarNo(carVo,pager);
	}
	//按状态查找
	public CarVo findByStatus(CarVo car){
		return carDAO.findByStatus(car);
	}
	//注册
	@Transactional
	public void reg(UserVo user){
		userDAO.reg(user);
	}
	//修改密码
	@Transactional
	public void pwd(UserVo user){
		userDAO.pwd(user);
	}
	//用户列表
	@Transactional
	public List<UserVo> userList(){
		return userDAO.userList();
	}
	//修改用户状态
	@Transactional
	public void updStatus(UserVo user){
		userDAO.updStatus(user);
	}
	//登录
	@Transactional
	public UserVo login(UserVo user){
		return userDAO.login(user);
		
	}
	//按用户id查找
	@Transactional
	public boolean findById(UserVo user){
		UserVo u = userDAO.findById(user);
		if(u==null){
			return true;
		}else{
			return false;
		}
		
	}
	//获取参数
	@Transactional
	public SysSetVo getSet(){
		return sysDAO.getSet();
	}
	//修改参数
	@Transactional
	public void updateSet(SysSetVo sysSet){
		sysDAO.updateSet(sysSet);
	}
	
	//新增车辆信息
	@Transactional
	public void carAdd(CarInfoVo carInfo){
		carInfoDAO.carAdd(carInfo);
	}
	//查找车辆信息
	@Transactional
	public List<CarInfoVo> findCar(String carNo){
		return carInfoDAO.findAll(carNo);
	}
	//修改车辆信息
	@Transactional
	public void carUpdate(CarInfoVo carInfo){
		carInfoDAO.updateCarInfo(carInfo);
	}
	//修改账户余额
	@Transactional
	public void updateMoney(CarInfoVo carInfo){
		carInfoDAO.updateMoney(carInfo);
	}
	//通过id获取车辆信息
	@Transactional
	public CarInfoVo getCarById(int carInfoId){
		return carInfoDAO.get(carInfoId);
	}
	public CarInfoVo findCarbyCarId(String carNo){
		return carInfoDAO.findCarbyCarId(carNo);
	}
	//通过id删除车辆信息
	@Transactional
	public void delCarById(int carInfoId){
		carInfoDAO.del(carInfoId);
	}
	//收费管理
	@Transactional
	public void financeAdd(FinanceVo finance){
		financeDAO.financeAdd(finance);
	}
	//收费查询
	@Transactional
	public List<FinanceVo> financeAll(String carNo){
		return financeDAO.findAll(carNo);
	}
	//收费月度统计
	@Transactional
	public List<FinanceVo> financeStat(int curYear){
		return financeDAO.financeStat(curYear);
	}
}
