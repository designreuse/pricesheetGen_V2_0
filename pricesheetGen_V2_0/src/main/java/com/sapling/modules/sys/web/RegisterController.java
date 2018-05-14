package com.sapling.modules.sys.web;


import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.common.collect.Lists;
import com.sapling.common.config.Global;
import com.sapling.common.json.AjaxJson;
import com.sapling.common.utils.FileUtils;
import com.sapling.common.utils.StringUtils;
import com.sapling.common.web.BaseController;
import com.sapling.modules.sys.dao.UserDao;
import com.sapling.modules.sys.entity.Area;
import com.sapling.modules.sys.entity.Office;
import com.sapling.modules.sys.entity.Role;
import com.sapling.modules.sys.entity.SystemConfig;
import com.sapling.modules.sys.entity.User;
import com.sapling.modules.sys.service.OfficeService;
import com.sapling.modules.sys.service.SystemConfigService;
import com.sapling.modules.sys.service.SystemService;
import com.sapling.modules.sys.utils.UserUtils;
import com.sapling.modules.tools.utils.TwoDimensionCode;

/**
 * 用户Controller
 * @author SapLing
 * @version 2013-8-29
 */
@Controller
@RequestMapping(value = "${adminPath}/sys/register")
public class RegisterController extends BaseController {


	@Autowired
	private SystemConfigService systemConfigService;
	
	@Autowired
	private SystemService systemService;
	
	@Autowired
	private OfficeService officeService;
	
	@Autowired
	private UserDao userDao;
	
	@ModelAttribute
	public User get(@RequestParam(required=false) String id) {
		if (StringUtils.isNotBlank(id)){
			return systemService.getUser(id);
		}else{
			return new User();
		}
	}
	
	
	
	@RequestMapping(value = {"index",""})
	public String register(User user, Model model) {
		return "modules/sys/register";
	}


	@RequestMapping(value = "registerUser")
	public String registerUser(  HttpServletRequest request,HttpServletResponse response, boolean mobileLogin, String randomCode, String roleName, User user, Model model, RedirectAttributes redirectAttributes) {
		
		roleName = "customer";
		//验证手机号是否已经注册
		
		if(userDao.findUniqueByProperty("mobile", user.getMobile()) != null){
			// 如果是手机登录，则返回JSON字符串
			if (mobileLogin){
				AjaxJson j = new AjaxJson();
				j.setSuccess(false);
				j.setErrorCode("1");
				j.setMsg("手机号已经被使用！");
		        return renderString(response, j.getJsonStr());
			}else{
				addMessage(model, "手机号已经被使用!");
				return register(user, model);
			}
		}
		
		//验证用户是否已经注册
		
		if(userDao.findUniqueByProperty("login_name", user.getLoginName()) != null){
			// 如果是手机登录，则返回JSON字符串
			if (mobileLogin){
				AjaxJson j = new AjaxJson();
				j.setSuccess(false);
				j.setErrorCode("2");
				j.setMsg("用户名已经被注册！");
		        return renderString(response, j.getJsonStr());
			}else{
				addMessage(model, "用户名已经被注册!");
				return register(user, model);
			}
		}
		
		//验证短信内容
		if(!randomCode.equals(request.getSession().getServletContext().getAttribute(user.getMobile()))){
			// 如果是手机登录，则返回JSON字符串
			if (mobileLogin){
				AjaxJson j = new AjaxJson();
				j.setSuccess(false);
				j.setErrorCode("3");
				j.setMsg("手机验证码不正确!");
		        return renderString(response, j.getJsonStr());
			}else{
				addMessage(model, "手机验证码不正确!");
				return register(user, model);
			}
		}
		

		
		
		//验证公司机构不能为空
		if(user.getCompany()==null){
			if (mobileLogin){
				AjaxJson j = new AjaxJson();
				j.setSuccess(false);
				j.setErrorCode("X");
				j.setMsg("公司信息不能为空!");
		        return renderString(response, j.getJsonStr());
			}else{
				addMessage(model, "公司信息不能为空!");
				return register(user, model);
			}
		}else{
			if(user.getCompany().getEmail()==null || user.getCompany().getFax()==null){
				if (mobileLogin){
					AjaxJson j = new AjaxJson();
					j.setSuccess(false);
					j.setErrorCode("X");
					j.setMsg("公司邮箱或传真均不能为空!");
			        return renderString(response, j.getJsonStr());
				}else{
					addMessage(model, "公司邮箱或传真均不能为空!");
					return register(user, model);
				}
			}
		}
		
		// 密码MD5加密
		user.setPassword(SystemService.entryptPassword(user.getPassword()));
		if (systemService.getUserByLoginName(user.getLoginName()) != null){
			addMessage(model, "注册用户'" + user.getLoginName() + "'失败，用户名已存在");
			return register(user, model);
		}
		
		// 修正引用赋值问题，不知道为何，Company和Office引用的一个实例地址，修改了一个，另外一个跟着修改。
		Role role = systemService.getRoleByEnname(roleName);
		String officeCode = "100000201";
		if(roleName.equals("patient")){
			officeCode = "1001";
		}
		Office office = officeService.getByCode(officeCode);
		Office _paraOf = new Office();
		_paraOf.setParentIds(office.getId());
		_paraOf.setGrade("4");
		_paraOf.setType("5");//5：部门下客户机构
		_paraOf.setUseable(Global.YES);
		_paraOf.setName(user.getCompany().getName());
		
		_paraOf = officeService.getEntity(_paraOf);
		//保存机构
//		user.setCompany(user.getCompany());
		user.setOffice(office);
		// 保存用户信息
		if(_paraOf!=null){
			//这里主要是根据公司名字去判断是否
			
			user.setCompany(_paraOf);
		}else{
			User _user = new User(); 
			_user.setId("1");
			user.getCompany().setCreateBy(_user);
			user.getCompany().setUpdateBy(_user);
			user.getCompany().setParent(office);
			user.getCompany().setParentIds(office.getParentIds()+office.getId()+",");
			Area _area = new Area();
			_area.setId("90ecd439eb3845db97a627d9242145e8");
			user.getCompany().setArea(_area);
			user.getCompany().setGrade("4");
			user.getCompany().setType("1");//1:公司
			user.getCompany().setUseable(Global.YES);
			officeService.save(user.getCompany());
		}
		
		// 角色数据有效性验证，过滤不在授权内的角色
		List<Role> roleList = Lists.newArrayList();
		roleList.add(role);
		user.setRoleList(roleList);
		systemService.saveUserInf4Customer(user);

		
		//生成用户二维码，使用登录名
		String realPath = Global.getUserfilesBaseDir() + Global.USERFILES_BASE_URL
		+ user.getId() + "/qrcode/";
		FileUtils.createDirectory(realPath);
		String name= user.getId()+".png"; //encoderImgId此处二维码的图片名
		String filePath = realPath + name;  //存放路径
		TwoDimensionCode.encoderQRCode(user.getLoginName(), filePath, "png");//执行生成二维码
		user.setQrCode(request.getContextPath()+Global.USERFILES_BASE_URL
			+  user.getId()  + "/qrcode/"+name);
		
		// 清除当前用户缓存
		if (user.getLoginName().equals(UserUtils.getUser().getLoginName())){
			UserUtils.clearCache();
			//UserUtils.getCacheMap().clear();
		}
		request.getSession().getServletContext().removeAttribute(user.getMobile());//清除验证码
		
		// 如果是手机登录，则返回JSON字符串
		if (mobileLogin){
			AjaxJson j = new AjaxJson();
			j.setSuccess(true);
			j.setMsg("注册用户'" + user.getLoginName() + "'成功");
	        return renderString(response, j);
		}
		
		
		addMessage(redirectAttributes, "注册用户'" + user.getLoginName() + "'成功");
		return "redirect:" + adminPath + "/login";
	}
	
	
	/**
	 * 获取验证码
	 * @param request
	 * @param response
	 * @param mobile
	 * @param model
	 * @param redirectAttributes
	 * @return
	 */
	@RequestMapping(value = "getRegisterCode")
	@ResponseBody
	public AjaxJson getRegisterCode(HttpServletRequest request,HttpServletResponse response, String mobile,
			Model model, RedirectAttributes redirectAttributes) {
		
		SystemConfig config = systemConfigService.get("1");
		
		AjaxJson j = new AjaxJson();
		
		//验证手机号是否已经注册
		if(userDao.findUniqueByProperty("mobile", mobile) != null){
			
				j.setSuccess(false);
				j.setErrorCode("1");
				j.setMsg("手机号已经被使用！");
		        return j;
		}
		
		String randomCode = String.valueOf((int) (Math.random() * 9000 + 1000));
		try {
			String result = "100";//UserUtils.sendRandomCode(config.getSmsName(),config.getSmsPassword(), mobile, randomCode);
			if (!result.equals("100")) {
				j.setSuccess(false);
				j.setErrorCode("2");
				j.setMsg("短信发送失败，错误代码："+result+"，请联系管理员。");
			}else{
				j.setSuccess(true);
				j.setErrorCode("-1");
				j.setMsg("短信发送成功!");
				System.out.println("\n\n\n"+randomCode);
				request.getSession().getServletContext().setAttribute(mobile, randomCode);
			}
		} catch (Exception e) {
			j.setSuccess(false);
			j.setErrorCode("3");
			j.setMsg("因未知原因导致短信发送失败，请联系管理员。");
		}
		return j;
	}
	
	
	/**
	 * web端ajax验证手机验证码是否正确
	 */
	@ResponseBody
	@RequestMapping(value = "validateMobileCode")
	public boolean validateMobileCode(HttpServletRequest request,
			String mobile, String randomCode) {
		if (randomCode.equals(request.getSession().getServletContext().getAttribute(mobile))) {
			return true;
		} else {
			return false;
		}
	}


}
