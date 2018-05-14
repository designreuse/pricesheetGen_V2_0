/**
 * Copyright &copy; 2015-2020 <a href="http://www.jeeplus.org/">JeePlus</a> All rights reserved.
 */
package com.sapling.modules.quotation.web;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.ConstraintViolationException;

import org.apache.shiro.authz.annotation.Logical;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.common.collect.Lists;
import com.sapling.common.config.Global;
import com.sapling.common.json.AjaxJson;
import com.sapling.common.mapper.JsonMapper;
import com.sapling.common.persistence.Page;
import com.sapling.common.utils.DateUtils;
import com.sapling.common.utils.ExchangeMail;
import com.sapling.common.utils.IdGen;
import com.sapling.common.utils.StringUtils;
import com.sapling.common.utils.bus.Constant;
import com.sapling.common.utils.excel.ExportExcel;
import com.sapling.common.utils.excel.ImportExcel;
import com.sapling.common.web.BaseController;
import com.sapling.modules.quotation.entity.QuotationOrder;
import com.sapling.modules.quotation.entity.QuotationOrderDetail;
import com.sapling.modules.quotation.service.QuotationOrderDetailService;
import com.sapling.modules.quotation.service.QuotationOrderService;
import com.sapling.modules.sys.entity.User;
import com.sapling.modules.sys.service.SystemService;
import com.sapling.modules.sys.utils.AesEncryptUtil;
import com.sapling.modules.sys.utils.UserUtil;
import com.sapling.modules.sys.utils.UserUtils;
import net.sf.json.JSONObject;

import com.sapling.modules.sys.dao.UserDao;
import com.sapling.modules.sys.entity.Office;
import com.sapling.modules.sys.entity.Role;
import com.sapling.modules.sys.utils.HttpRequest;
import com.sapling.modules.sys.utils.MsgInfoEntity;

/**
 * 报价单Controller
 * @author cth
 * @version 2017-01-24
 */
@Controller
@RequestMapping(value="/quotation/quotationOrder")
public class QuotationFrontOrderController{

	@Autowired
	private QuotationOrderService quotationOrderService;

	@Autowired
	private UserDao userDao;
	
	@Autowired
	private QuotationOrderDetailService quotationOrderDetailService;	

	@RequestMapping(value = "findUsersByUserId", method = RequestMethod.POST)
	@ResponseBody
	public Object findUserById(ModelMap model){
		UserUtils userUtil=new UserUtils();
		List<User> list=userUtil.findUserRuleCodeOrId("02", "");
		model.addAttribute("list",list);
		return "modules/frontPage/index_content";
	}
	
	/**
	 * 用户端登录
	 * @param userName
	 * @param password
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/inf/v1.0.1/frontLogin", method = RequestMethod.POST)
	@ResponseBody
	public UserUtil findFrontLogin(
			@RequestParam(value="phone", required=false) String userName,
			@RequestParam(value="password", required=false) String password,
			ModelMap model){
		User iuser=new User();
		iuser.setLoginName(userName);
	    User user =  userDao.getByLoginName(iuser);
		UserUtil userUtil=new UserUtil();
	    if(SystemService.validatePassword(password,user.getPassword())){
			userUtil.setLoginName(user.getLoginName());
			userUtil.setName(user.getName());
			userUtil.setAddress(user.getCompany().getAddress());
			userUtil.setCompany(user.getCompany().getName());
			userUtil.setEmail(user.getEmail());
			userUtil.setCompanyEmail(user.getCompany().getEmail());
			userUtil.setCompanyPhone(user.getCompany().getPhone());
			userUtil.setFax(user.getCompany().getFax());
			userUtil.setPhone(user.getPhone());
			userUtil.setPhoto(user.getPhoto());
			model.addAttribute("user",userUtil);
	    }
		return userUtil;
	}
	
	/**
	 * 获取短信验证码
	 * @param model
	 * @param phone 用户手机号码
	 * @return
	 */
	@RequestMapping(value = "/inf/v1.0.1/getReCode", method = RequestMethod.GET)
	@ResponseBody
	public MsgInfoEntity getReCode(@RequestParam(value="phone", required=true) String phone){
		MsgInfoEntity map=new MsgInfoEntity();
		Map< Object, Object> model=new HashMap< Object, Object>();
		try {
			if(!isMobileNO(phone)){
				model.put("result",0);
				model.put("data", "");
				model.put("msg", "手机号有误，发送验证码失败");
			}else{
				String code = "";
				// 产生验证码  
	            for ( int i = 0; i < 6; i++) {  
	                code += (int)(Math.random() * 9);  
	            }  
				int result = userDao.savePhoneCode(IdGen.uuid(),phone, code);
				if(result>0){
					result = HttpRequest.sendMsg(phone, code);
					if(result>0){
						model.put("result",1);
						model.put("data", "");
						model.put("msg", "");
					}else{
						model.put("result",0);
						model.put("data", "");
						model.put("msg", "短信验证码发送失败");
					}
				}else{
					model.put("result",0);
					model.put("data", "");
					model.put("msg", "短信验证码发送失败");
				}
			}
			map.setData(model);
			return map;
		} catch (Exception e) {
			e.printStackTrace();
			model.put("result",0);
			model.put("data", "");
			model.put("msg", "系统错误，短信验证码发送失败");
			map.setData(model);
			return map;
		}
	}
	
	
	/**
	 * 获取短信验证码
	 * @param model
	 * @param phone 用户手机号码
	 * @return
	 */
	@RequestMapping(value = "/inf/v1.0.1/registerUser", method = RequestMethod.GET)
	@ResponseBody
	public MsgInfoEntity registerUser(
				@RequestParam(value="phone", required=true) String phone,
				@RequestParam(value="code", required=true) String code,
				@RequestParam(value="password", required=true) String password
			){
		MsgInfoEntity map=new MsgInfoEntity();
		Map< Object, Object> model=new HashMap< Object, Object>();
		User user2=new User();
		user2.setPhone(phone);
		User users=  userDao.findUserByPhone(user2);
		if(users!=null){
			model.put("result",0);
			model.put("data", "");
			model.put("msg", "该手机号已注册！请换个手机号进行注册。");
		}else{
			long num= userDao.exitSMSCodeByCodePhone(phone,code,"0");
			userDao.updateSMSCodeByCodePhone(phone,code);
			if(num>0){
				User user=new User(IdGen.uuid());
				user.setPassword(SystemService.entryptPassword(password));
				user.setCompany(new Office());
				user.setPhone(phone);
				user.setCreateDate(new Date());
				user.setUpdateDate(new Date());
				user.setOffice(new Office());
				user.setCreateBy(new User());
				user.setUpdateBy(new User());
				user.setDelFlag("0");
				user.setRole(new Role());
				num= userDao.saveUser(user);
				if(num>0){
					model.put("result",1);
					model.put("data", "");
					model.put("msg", "注册成功");
				}
			}else{
				model.put("result",0);
				model.put("data", "");
				model.put("msg", "验证码输入错误或已过期");
			}
		}
		map.setData(model);
		 return map;
	}

	/**
	 * 根据手机号码查询用户
	 * @param userName
	 * @param password
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/inf/v1.0.1/findUserByPhone", method = RequestMethod.GET)
	@ResponseBody
	public MsgInfoEntity findUserByPhone(
			@RequestParam(value="phone", required=false) String phone){
		MsgInfoEntity entity=new MsgInfoEntity();
		Map< Object, Object> map=new HashMap< Object, Object>();
		User user2=new User();
		user2.setPhone(phone);
		User users=  userDao.findUserByPhone(user2);
		if(users!=null){
			map.put("result",1);
			map.put("data", users);
			map.put("msg", "");
		}else{
			map.put("result",0);
			map.put("data", "");
			map.put("msg", "该用户不存在");
		}
		entity.setData(map);
		return entity;
	}
	
	
	public static boolean isMobileNO(String mobiles){
		String regExp = "^(0|86|17951)?(13[0-9]|15[0-9]|17[678]|18[0-9]|14[57])[0-9]{8}$";  
		  
		Pattern p = Pattern.compile(regExp);  
		  
		Matcher m = p.matcher(mobiles);
		return m.find();
//		Pattern p = Pattern.compile("^((13[0-9])|(15[^4,\\D])|(18[0,5-9]))\\d{8}$");  
//		Matcher m = p.matcher(mobiles);  
//		System.out.println(m.matches()+"---");  
//		boolean falg = m.matches();
//		return falg;
	} 
}