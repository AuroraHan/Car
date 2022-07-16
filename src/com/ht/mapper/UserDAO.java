package com.ht.mapper;

import java.util.List;

import com.ht.vo.UserVo;

public interface UserDAO {

	//注册
	public void reg(UserVo user);
	//修改密码
	public void pwd(UserVo user);
	//登录
	public UserVo login(UserVo user);
	//按用户id查找
	public UserVo findById(UserVo user);
	//用户列表
	public List<UserVo> userList();
	//修改用户状态
	public void updStatus(UserVo user);
}
