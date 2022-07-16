package com.ht.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ht.service.DbService;
import com.ht.vo.CarInfoVo;
import com.ht.vo.CarVo;
import com.ht.vo.FinanceVo;
import com.ht.vo.SysSetVo;
import com.ht.vo.UserVo;

@Controller
@RequestMapping("/user")
public class UserController {
	@Resource
	DbService dbService;
	//首页
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String login() {
		return "login";
	}
	//登录
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String login(HttpServletRequest request, Model model) {
		String msg = "";
		HttpSession session = request.getSession();
		if (session.getAttribute("rand") == null) {
			return "login";
		}
		String loginName = request.getParameter("loginName");
		String password = request.getParameter("password");
		String randCode = request.getParameter("randCode");

		String rand = session.getAttribute("rand").toString();
		rand = rand.toUpperCase();
		randCode = randCode.toUpperCase();
		if (!rand.equals(randCode)) {
			msg = "验证码错误";
			model.addAttribute("msg", msg);
			return "login";
		}
		UserVo user = new UserVo();
		user.setUserId(loginName);
		user.setPassword(password);
		user = dbService.login(user);
		if (user == null) {
			msg = "用户名或密码错误";
			model.addAttribute("msg", msg);
			return "login";
		}
		if(user.getStatus()==0){
			msg = "该用户已被禁止登陆";
			model.addAttribute("msg", msg);
			return "login";
		}
		session.setAttribute("userinfo", user);
		//从application中读取sysSet变量，这个变量保存的就是SysSet对象
		if(request.getServletContext().getAttribute("sysSet")==null){
			SysSetVo sysSet = dbService.getSet();
			//定义application变量，保存sysSet对象的值
			request.getServletContext().setAttribute("sysSet", sysSet);
		}
		return "faceCheck";
	}
	//返回车牌识别界面
	@RequestMapping("/faceCheck")
	public String faceCheck() throws Exception{
		
		return "faceCheck";
	}
	//注册
	@RequestMapping(value="/reg",method=RequestMethod.GET)
	public String reg() throws Exception{
		return "regUser";
	}
	//注册
	@RequestMapping(value="/reg",method=RequestMethod.POST)
	@ResponseBody
	public Map reg(UserVo user) throws Exception{
		user.setStatus(1);
		Map<String,String> map = new HashMap<String,String>();
		if(dbService.findById(user)){
			dbService.reg(user);
			map.put("code","0");
			map.put("msg", "恭喜您注册成功，登录名:"+user.getUserId()+",密码："+user.getPassword()+",请重新登录");
		}else{
			map.put("code","1");
			map.put("msg", "登录名称已经存在");
		}
		return map;
	}
	//安全退出
	@RequestMapping("/exit")
	public String exit(HttpServletRequest request){
		
		request.getSession().invalidate();
		return "login";
	}
	//修改密码
	@RequestMapping("/updPwd")
	@ResponseBody
	public Map updPwd(UserVo user){
		dbService.pwd(user);
		Map map = new HashMap();
		map.put("msg", "修改密码成功，请重新登录！");
		return map;
	}
	//修改状态
	@RequestMapping("/updStatus")
	public String updStatus(UserVo user,ModelMap model){
		dbService.updStatus(user);
		//用户信息
		List<UserVo> userList = dbService.userList();
		model.addAttribute("userList", userList);
		return "user";
	}
	//系统设置
	@RequestMapping("/updSet")
	@ResponseBody
	public Map updSet(HttpServletRequest request, SysSetVo sysSet){
		dbService.updateSet(sysSet);
		//修改application变量sysSet的值
		request.getServletContext().setAttribute("sysSet", sysSet);
		Map map = new HashMap();
		map.put("msg", "系统设置修改成功！");
		return map;
	}
	//用户资料列表
	@RequestMapping("/user")
	public String user(ModelMap model) throws Exception{
		//用户信息
		List<UserVo> userList = dbService.userList();
		model.addAttribute("userList", userList);
		return "user";
	}
	//修改密码
	@RequestMapping("/pwd")
	public String pwd() throws Exception{
		
		return "pwd";
	}
	//系统设置
	@RequestMapping("/sysSet")
	public String sysSet() throws Exception{
		
		return "sysSet";
	}
}
