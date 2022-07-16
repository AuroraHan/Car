package com.ht.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.base.PageObject;
import com.ht.service.DbService;
import com.ht.vo.CarInfoVo;
import com.ht.vo.CarVo;
import com.ht.vo.FinanceVo;
import com.ht.vo.SysSetVo;
import com.ht.vo.UserVo;
import com.lgr.car.CarApi;
import com.lgr.car.RootResp;
import com.lgr.car.utils.Base64Util;

@Controller
@RequestMapping("/car")
public class CarController {
	@Resource
	DbService dbService;
	//抓拍车牌
	@RequestMapping("/paizhao")
	@ResponseBody
	public Map<String, Object> paizhao(HttpServletRequest request,String imageData,String extName) throws Exception{
		UserVo user = (UserVo)request.getSession().getAttribute("userinfo");
		CarApi faceApi = new CarApi();
		RootResp resp = faceApi.carVerify(imageData);
		Map<String,Object> json = new HashMap<String, Object>();
		json.put("errorCode", 1);
		json.put("msg", "车牌识别失败");
		if(resp!=null){
			//ret=0表示识别成功
			if(resp.getRet()==0) {
				JSONObject object = JSONObject.parseObject(resp.getData().toString());
				//获取识别成功的车牌号码
	            String carNo = object.getString("Number");
				json.put("errorCode", 0);
				System.out.println("carNo="+carNo);
				String savePath = request.getSession().getServletContext().getRealPath("/attached/face/")+"/";
				String inPic = UUID.randomUUID()+"."+extName;
				savePath += inPic;
				System.out.println("savePath="+savePath);
				//保存拍照图片
				Base64Util.decoderBase64File(imageData, savePath);
				
				//车辆信息，如果没有车辆信息，返回null,表示临时车,非空就是包月车（会员）
				CarInfoVo carInfo = dbService.findCarbyCarId(carNo);

				CarVo car = new CarVo();
				car.setCardNo(carNo);
				car.setStatus(0);
				car.setUserName(user.getUserName());
				//查未缴费的停车信息
				CarVo c = dbService.findByStatus(car);
				String remark= "停车收费";
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				//2020-04-09
//				if(carInfo==null){
//					json.put("errorCode", 0);
//					json.put("msg", "该车辆信息不存在，请先注册车辆信息");
//					return json;
//				}
				//--------------------------
				if(carInfo == null){//临时停车
					car.setFinanceType(2);//2临时
					if(c==null){//入库
						car.setCarFee(0);
						car.setInPic(inPic);
						car.setInTime(sdf.format(new Date()));
						car.setRemark(remark);
						car.setStatus(0);//0未收费
						dbService.carIn(car);//增加停车信息
//						json.put("msg","临时车【"+carNo+"】：入场" );
						json.put("msg","车辆【"+carNo+"】：入场" );
					}else{//出库
						float carFee = 0;
						SysSetVo sysSet = (SysSetVo)request.getServletContext().getAttribute("sysSet");
						carFee = c.getMinutes()-sysSet.getMianfeiTime();//停车时长减去免费时长
						if(carFee<=0){
							car.setCarFee(0);
							carFee=0;
						}else{
							carFee = (float)Math.ceil(carFee/sysSet.getShoufeiTime())*sysSet.getShoufeiMoney();
							car.setCarFee(carFee);
						}
						car.setStatus(1);//1已收费
						car.setOutPic(inPic);//出场图片
						car.setOutTime(sdf.format(new Date()));//出场时间
						car.setRemark(remark);//备注
						car.setCarId(c.getCarId());
						dbService.carOut(car);
						if(carFee>0){
							//收费
							//出场收费=======
							FinanceVo finance = new FinanceVo();
							finance.setCarNo(carNo);
							finance.setFinanceType(2);//临时车收费
							finance.setOprTime(new Date());
							finance.setUserName(user.getUserName());
							finance.setRemark("【"+carNo+"】：出场，扣款:"+carFee+"元" );
							finance.setTotalMoney(carFee);
							dbService.financeAdd(finance);
							//------更新账户余额----------
							carInfo.setRemainMoney(-finance.getTotalMoney());
							dbService.updateMoney(carInfo);
						}
						json.put("msg","【"+carNo+"】：出场，扣款:"+carFee+"元" );
					}
				}else{//包月停车
					remark="包月停车";
					car.setFinanceType(1);//1包月
					if(c==null){//入库
						car.setCarFee(0);
						car.setInPic(inPic);
						car.setInTime(sdf.format(new Date()));
						car.setRemark(remark);
						car.setStatus(0);//0未收费
						dbService.carIn(car);
						json.put("msg","包月车【"+carNo+"】：入场" );
					}else{//出库
						car.setCarFee(0);
						car.setStatus(2);//2包月
						car.setOutPic(inPic);
						car.setOutTime(sdf.format(new Date()));
						car.setRemark(remark);
						car.setCarId(c.getCarId());
						dbService.carOut(car);
						if(carInfo.getDiffDate()>0){
							json.put("msg","包月车【"+carNo+"】：出场，还剩"+carInfo.getDiffDate()+"天" );
						}else{
							json.put("msg","包月车【"+carNo+"】：出场，请及时缴费" );
						}
					}
				}
				
			}else{
				json.put("errorCode", resp.getRet());
				json.put("msg", "车牌识别失败");
			}
		}
		return json;
	}
	//显示车辆列表界面
	@RequestMapping("/carInfo")
	public String carInfo(String carNo,ModelMap model) throws Exception{
		if(carNo==null){
			carNo="";
		}
		List<CarInfoVo> carInfoList = dbService.findCar(carNo);
		model.addAttribute("carInfoList", carInfoList);
		return "car";
	}
	//显示新增车辆界面
	@RequestMapping(value="/carAdd",method=RequestMethod.GET)
	public String carAdd(ModelMap model) throws Exception{
		CarInfoVo carInfo = new CarInfoVo();
		model.addAttribute("carInfo",carInfo);
		return "carInfo";
	}
	//保存车辆信息
	@RequestMapping(value="/carAdd",method=RequestMethod.POST)
	public String carAdd(CarInfoVo carInfo,ModelMap model) {
		try{
			if(carInfo.getCarInfoId()==0){
				carInfo.setRemainMoney(0);
				dbService.carAdd(carInfo);
			}else{
				dbService.carUpdate(carInfo);
			}
		}catch(Exception e){
			model.addAttribute("carInfo", carInfo);
			model.addAttribute("msg", "该车牌对应的车辆信息已经存在");
			return "carInfo";
		}
		//车辆信息
		List<CarInfoVo> carInfoList = dbService.findCar("");
		model.addAttribute("carInfoList", carInfoList);
		return "car";
	}
	//停车信息查询
	@RequestMapping("/stopCar")
	public String stopCar(HttpServletRequest request,CarVo carVo,ModelMap model,PageObject pager){

		//保存查询条件，供点击分页链接时使用
		if(request.getParameter("cardNo")==null){
			carVo = (CarVo)request.getSession().getAttribute("carVo");
		}else{
			request.getSession().setAttribute("carVo", carVo);
		}
		int cnt = dbService.count(carVo, pager);
		pager.setTotalRows(cnt);
		if(pager.getCur_page()>pager.getPageCount()){
			pager.setCur_page(pager.getPageCount());
		}
		if(pager.getCur_page()<1){
			pager.setCur_page(1);
		}
		
		//停车信息
		List<CarVo> carList = dbService.findByCarNo(carVo, pager);
		model.addAttribute("carList", carList);
		model.addAttribute("pager", pager);
		model.addAttribute("carVo", carVo);
		
		return "stop";
	}
	//停车信息查询
	@RequestMapping("/finance")
	public String finance(String carNo,ModelMap model){
		if(carNo==null){
			carNo="";
		}
		//收费信息
		List<FinanceVo> financeList = dbService.financeAll(carNo);
		model.addAttribute("financeList", financeList);
		return "finance";
	}
	//收费月度统计
	@RequestMapping("/financeStat")
	public String financeStat(int curYear,ModelMap model){
		//收费信息
		List<FinanceVo> financeList = dbService.financeStat(curYear);
		model.addAttribute("financeList", financeList);
		return "financeStat";
	}
	//通过id获取车辆信息
	@RequestMapping(value="/updateCar")
	public String carUpdate(int carInfoId,ModelMap model) throws Exception{
		CarInfoVo carInfo = dbService.getCarById(carInfoId);
		model.addAttribute("carInfo", carInfo);
		return "carInfo";
	}
	//通过id删除车辆信息
	@RequestMapping(value="/delCar")
	public String delCar(int carInfoId,ModelMap model) throws Exception{
		dbService.delCarById(carInfoId);
		//车辆信息
		List<CarInfoVo> carInfoList = dbService.findCar("");
		model.addAttribute("carInfoList", carInfoList);
		return "car";
	}
	//缴费
	@RequestMapping(value="/financeAdd",method=RequestMethod.GET)
	public String financeCar(int carInfoId,ModelMap model) {
		CarInfoVo carInfo = dbService.getCarById(carInfoId);
		model.addAttribute("carInfo", carInfo);
		return "financeAdd";
	}
	//缴费
	@RequestMapping(value="/financeAdd",method=RequestMethod.POST)
	public String financeCar(HttpServletRequest request, CarInfoVo carInfo,FinanceVo finance,ModelMap model) {
		
		
		CarInfoVo cInfo = dbService.getCarById(carInfo.getCarInfoId());
		cInfo.setExpireDate(carInfo.getExpireDate());
		dbService.carUpdate(cInfo);
		
		finance.setFinanceType(1);//1：包月收费
		finance.setOprTime(new Date());
		//从session中获取当前登录的用户信息(车辆管理员)
		UserVo user = (UserVo)request.getSession().getAttribute("userinfo");
		finance.setUserName(user.getUserName());
		finance.setRemark("缴费("+finance.getTotalMoney()+"元)");
		dbService.financeAdd(finance);
		//更新车辆账户余额
		cInfo.setRemainMoney(finance.getTotalMoney());
		dbService.updateMoney(cInfo);
		
		List<CarInfoVo> carInfoList = dbService.findCar("");
		model.addAttribute("carInfoList", carInfoList);
		return "car";
	}

}
