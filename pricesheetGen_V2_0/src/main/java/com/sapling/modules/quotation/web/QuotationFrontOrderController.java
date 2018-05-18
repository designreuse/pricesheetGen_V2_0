/**
 * Copyright &copy; 2015-2020 <a href="http://www.jeeplus.org/">JeePlus</a> All rights reserved.
 */
package com.sapling.modules.quotation.web;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
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

import org.apache.ibatis.annotations.Param;
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
import com.sapling.common.utils.FileUtils;
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
import com.sapling.modules.tools.utils.TwoDimensionCode;

import net.sf.json.JSONObject;
import sun.misc.BASE64Decoder;

import com.sapling.modules.sys.dao.OfficeDao;
import com.sapling.modules.sys.dao.UserDao;
import com.sapling.modules.sys.entity.Area;
import com.sapling.modules.sys.entity.Office;
import com.sapling.modules.sys.entity.Role;
import com.sapling.modules.sys.utils.HttpRequest;
import com.sapling.modules.sys.utils.MsgInfoEntity;

/**
 * 报价单Controller
 * 
 * @author cth
 * @version 2017-01-24
 */
@Controller
@RequestMapping(value = "/quotation/quotationOrder")
public class QuotationFrontOrderController {

	@Autowired
	private QuotationOrderService quotationOrderService;

	@Autowired
	private SystemService systemService;
	
	@Autowired
	private UserDao userDao;
	
	@Autowired
	private OfficeDao  officeDao;

	@Autowired
	private QuotationOrderDetailService quotationOrderDetailService;

	@RequestMapping(value = "inf/v1.0.1/findUsersByUserId", method = RequestMethod.GET)
	@ResponseBody
	public MsgInfoEntity findUserById(@RequestParam(value = "phone", required = false) String phone) {
		User iuser = new User();
		iuser.setPhone(phone);
		User user = userDao.getByPhone(iuser);
		MsgInfoEntity map = new MsgInfoEntity();
		Map<Object, Object> model = new HashMap<Object, Object>();
		List<User> list = userDao.findUserByCustomerId(user.getId());
		model.put("result", 1);
		model.put("data",list);
		model.put("msg", "");
		map.setData(model);
		return map;
	}

	/**
	 * 用户端登录
	 * 
	 * @param userName
	 * @param password
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/inf/v1.0.1/frontLogin", method = RequestMethod.POST)
	@ResponseBody
	public MsgInfoEntity findFrontLogin(@RequestParam(value = "phone", required = false) String phone,
			@RequestParam(value = "password", required = false) String password) {
		MsgInfoEntity map = new MsgInfoEntity();
		Map<Object, Object> model = new HashMap<Object, Object>();
		User iuser = new User();
		iuser.setPhone(phone);
		User user = userDao.getByPhone(iuser);
		UserUtil userUtil = new UserUtil();
		if(user!=null){
			if (SystemService.validatePassword(password, user.getPassword())) {
				userUtil.setName(user.getName());
				userUtil.setAddress(user.getCompany() == null ? "" : user.getCompany().getAddress());
				userUtil.setCompany(user.getCompany() == null ? "" : user.getCompany().getName());
				userUtil.setEmail(user.getEmail());
				userUtil.setCompanyEmail(user.getCompany() == null ? "" : user.getCompany().getEmail());
				userUtil.setCompanyPhone(user.getCompany() == null ? "" : user.getCompany().getPhone());
				userUtil.setFax(user.getCompany() == null ? "" : user.getCompany().getFax());
				userUtil.setPhone(user.getPhone());
				userUtil.setPhoto(user.getPhoto());
				model.put("result", 1);
				model.put("data",userUtil);
				model.put("msg", "");
			}else{
				model.put("result",0);
				model.put("data","");
				model.put("msg", "登录密码错误");
			}
		}else{
			model.put("result",0);
			model.put("data","");
			model.put("msg", "该用户不存在");
		}
		map.setData(model);
		return map;
	}

	/**
	 * 获取短信验证码
	 * 
	 * @param model
	 * @param phone
	 *            用户手机号码
	 * @return
	 */
	@RequestMapping(value = "/inf/v1.0.1/getReCode", method = RequestMethod.GET)
	@ResponseBody
	public MsgInfoEntity getReCode(@RequestParam(value = "phone", required = true) String phone) {
		MsgInfoEntity map = new MsgInfoEntity();
		Map<Object, Object> model = new HashMap<Object, Object>();
		try {
			if (!isMobileNO(phone)) {
				model.put("result", 0);
				model.put("data", "");
				model.put("msg", "手机号有误，发送验证码失败");
			} else {
				String code = "";
				// 产生验证码
				for (int i = 0; i < 6; i++) {
					code += (int) (Math.random() * 9);
				}
				int result = userDao.savePhoneCode(IdGen.uuid(), phone, code);
				if (result > 0) {
					result = HttpRequest.sendMsg(phone, code);
					if (result > 0) {
						model.put("result", 1);
						model.put("data", "");
						model.put("msg", "");
					} else {
						model.put("result", 0);
						model.put("data", "");
						model.put("msg", "短信验证码发送失败");
					}
				} else {
					model.put("result", 0);
					model.put("data", "");
					model.put("msg", "短信验证码发送失败");
				}
			}
			map.setData(model);
			return map;
		} catch (Exception e) {
			e.printStackTrace();
			model.put("result", 0);
			model.put("data", "");
			model.put("msg", "系统错误，短信验证码发送失败");
			map.setData(model);
			return map;
		}
	}

	@RequestMapping(value = "/inf/v1.0.1/confirmPhone", method = RequestMethod.GET)
	@ResponseBody
	public MsgInfoEntity confirmPhone(@RequestParam(value = "phone", required = true) String phone,
			@RequestParam(value = "code", required = true) String code) {
		MsgInfoEntity map = new MsgInfoEntity();
		Map<Object, Object> model = new HashMap<Object, Object>();
		long num = userDao.exitSMSCodeByCodePhone(phone, code, "0");
		userDao.updateSMSCodeByCodePhone(phone, code);
		if (num > 0) {
			model.put("result", 1);
			model.put("data", "true");
			model.put("msg", "");
		} else {
			model.put("result", 0);
			model.put("data", "");
			model.put("msg", "请输入正确的验证码");
		}
		map.setData(model);
		return map;
	}

	/**
	 * 用户注册
	 * 
	 * @param model
	 * @param phone
	 *            用户手机号码
	 * @return
	 */
	@RequestMapping(value = "/inf/v1.0.1/registerUser", method = RequestMethod.GET)
	@ResponseBody
	public MsgInfoEntity registerUser(@RequestParam(value = "phone", required = true) String phone,
			@RequestParam(value = "code", required = true) String code,
			@RequestParam(value = "password", required = true) String password) {
		MsgInfoEntity map = new MsgInfoEntity();
		Map<Object, Object> model = new HashMap<Object, Object>();
		User user2 = new User();
		user2.setPhone(phone);
		User users = userDao.findUserByPhone(user2);
		if (users != null) {
			model.put("result", 0);
			model.put("data", "");
			model.put("msg", "该手机号已注册！请换个手机号进行注册。");
		} else {
			long num = userDao.exitSMSCodeByCodePhone(phone, code, "0");
			userDao.updateSMSCodeByCodePhone(phone, code);
			if (num > 0) {
				User user = new User();
				user.setPassword(SystemService.entryptPassword(password));
				user.setCompany(new Office());
				user.setPhone(phone);
				user.setIsCustomer("1");
				user.setCreateDate(new Date());
				user.setUpdateDate(new Date());
				user.setOffice(new Office());
				user.setCreateBy(new User());
				user.setUpdateBy(new User());
				user.setDelFlag("0");
				user.setRole(new Role());
//				num = userDao.saveUser(user);
				systemService.saveFrontUser(user);
				//分配虚拟用户
				userDao.insertUserCustomer( "063707d44dcd49be9c0da42011404da3",user.getId());
//				if (num > 0) {
					model.put("result", 1);
					model.put("data", "");
					model.put("msg", "注册成功");
//				}
			} else {
				model.put("result", 0);
				model.put("data", "");
				model.put("msg", "验证码输入错误或已过期");
			}
		}
		map.setData(model);
		return map;
	}

	/**
	 * 修改手机号码
	 * 
	 * @param phone
	 * @param newPhone
	 * @param code
	 * @return
	 */
	@RequestMapping(value = "/inf/v1.0.1/updatePhone", method = RequestMethod.GET)
	@ResponseBody
	public MsgInfoEntity updatePhone(@RequestParam(value = "phone", required = true) String phone,
			@RequestParam(value = "newPhone", required = true) String newPhone,
			@RequestParam(value = "code", required = true) String code) {
		MsgInfoEntity map = new MsgInfoEntity();
		Map<Object, Object> model = new HashMap<Object, Object>();
		User user2 = new User();
		user2.setPhone(newPhone);
		User users = userDao.findUserByPhone(user2);
		if (users != null) {
			model.put("result", 0);
			model.put("data", "");
			model.put("msg", "该手机号已存在");
		} else {
			long num = userDao.exitSMSCodeByCodePhone(newPhone, code, "0");
			userDao.updateSMSCodeByCodePhone(newPhone, code);
			if (num > 0) {
				num = userDao.updateUserPhone(phone, newPhone);
				if (num > 0) {
					model.put("result", 1);
					model.put("data", newPhone);
					model.put("msg", "修改成功");
				}
			} else {
				model.put("result", 0);
				model.put("data", "");
				model.put("msg", "验证码输入错误或已过期");
			}
		}
		map.setData(model);
		return map;
	}

	/**
	 * 修改用户密码
	 * 
	 * @param phone
	 * @param newPhone
	 * @param code
	 * @return
	 */
	@RequestMapping(value = "/inf/v1.0.1/updatePassword", method = RequestMethod.GET)
	@ResponseBody
	public MsgInfoEntity updatePassword(@RequestParam(value = "phone", required = true) String phone,
			@RequestParam(value = "password", required = false) String password,
			@RequestParam(value = "newPassword", required = true) String newPassword) {
		MsgInfoEntity map = new MsgInfoEntity();
		Map<Object, Object> model = new HashMap<Object, Object>();
		User user2 = new User();
		user2.setPhone(phone);
		User users = userDao.findUserByPhone(user2);
		if (users == null) {
			model.put("result", 0);
			model.put("data", "");
			model.put("msg", "该用户不存在");
		} else {
			if(password==null){
				long num = userDao.updateUserPassword(phone, SystemService.entryptPassword(newPassword));
				if (num > 0) {
					model.put("result", 1);
					model.put("data", "");
					model.put("msg", "修改成功");
				}
			}else{
				if (SystemService.validatePassword(password, users.getPassword())) {
					long num = userDao.updateUserPassword(phone, SystemService.entryptPassword(newPassword));
					if (num > 0) {
						model.put("result", 1);
						model.put("data", "");
						model.put("msg", "修改成功");
					}
				} else {
					model.put("result", 0);
					model.put("data", "");
					model.put("msg", "原密码错误");
				}
			}
		}
		map.setData(model);
		return map;
	}
 
	
	/**
	 * 用户端登录
	 * 
	 * @param userName
	 * @param password
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/inf/v1.0.1/updateUserInfo", method = RequestMethod.POST)
	@ResponseBody
	public MsgInfoEntity updateUserInfo(@RequestParam(value = "phone", required = false) String phone,
			@RequestParam(value = "name", required = false) String name,
			@RequestParam(value = "companyName", required = false) String companyName,
			@RequestParam(value = "fox", required = false) String fox,
			@RequestParam(value = "companyEmail", required = false) String email,
			@RequestParam(value = "emailPassword", required = false) String emailPassword,
			@RequestParam(value = "companyPhone", required = false) String companyPhone,
			@RequestParam(value = "ismodify", required = true) boolean ismodify,
			@RequestParam(value = "photo", required = false) String photo, HttpServletRequest request) {
		MsgInfoEntity infoEntity = new MsgInfoEntity();
		Map<Object, Object> map = new HashMap<Object, Object>();
		if(ismodify){
			if (photo.indexOf(",") != -1) {
				photo = photo.substring(photo.indexOf(",") + 1);
			}
			photo = photo.replace(" ", "+");
			System.err.println(photo);
			// byte dataByte[] = Base64.decode(imgPreUrl).getBytes();
			BASE64Decoder decoder = new BASE64Decoder();
			byte dataByte[] = null;
			try {
				dataByte = decoder.decodeBuffer(photo);
			} catch (IOException e1) {
				e1.printStackTrace();
			}
			for (int i = 0; i < dataByte.length; ++i) {
				if (dataByte[i] < 0) {// 调整异常数据
					dataByte[i] += 256;
				}
			}
			User user2 = new User();
			user2.setPhone(phone);
			User user = userDao.findUserByPhone(user2);

			// 生成用户二维码，使用登录名
			String realPath = Global.getUserfilesBaseDir() + Global.USERFILES_BASE_URL + user.getId() + "/qrcode/";
			FileUtils.createDirectory(realPath);
			String names = user.getId() + ".png"; // encoderImgId此处二维码的图片名
			String filePath = realPath + names; // 存放路径
			TwoDimensionCode.encoderQRCode(user.getPhone(), filePath, "png");// 执行生成二维码
			user.setQrCode(request.getContextPath() + Global.USERFILES_BASE_URL + user.getId() + "/qrcode/" + names);

			
			Office office = new Office();
			office.setName(companyName);
			office.setType("1");
			office=officeDao.getEntity(office);
			
			if(office==null || office.getId()==null || office.getId().equals("")){
				office=new Office(IdGen.uuid());
				office.setName(companyName);
				office.setEmail("");
				office.setFax(fox);
				office.setPhone(companyPhone);
				office.setParent(new Office("0"));
				office.setParentIds("0,");
				office.setGrade("1");
				office.setType("1");
				office.setCreateDate(new Date());
				office.setUpdateDate(new Date());
				office.setArea(new Area());
				office.setMaster("");
				office.setUpdateBy(user);
				office.setCreateBy(user);
				office.setDelFlag("0");
				office.setUseable("1");
				if(office.getId()=="1"){
					user.setIsCustomer("0");
				}
				officeDao.insert(office);
			}else{
				office.setName(companyName);
				office.setEmail("");
				office.setFax(fox);
				office.setPhone(companyPhone);
				office.setParent(new Office("0"));
				office.setParentIds("0,");
				office.setGrade("1");
				office.setType("1");
				office.setCreateDate(new Date());
				office.setUpdateDate(new Date());
				office.setArea(new Area());
				office.setMaster("");
				office.setUpdateBy(user);
				office.setCreateBy(user);
				office.setDelFlag("0");
				office.setUseable("1");
				officeDao.update(office);
			}
			user.setPhone(phone);
			user.setName(name);
			user.setEmail(email);	
			user.setEmailUserName(email);	
			user.setEmailPassword(emailPassword);			
			user.setUpdateDate(new Date());
			user.setCompany(office);
			user.setOffice(new Office());
			
			// 获取系统当前时间
			SimpleDateFormat df = new SimpleDateFormat("yyMMddHHmmss");// 设置日期格式
			String nowdate = df.format(new Date());
			String filename = nowdate + ".jpg";
			// 获得项目的绝对路径
			String savePath = request.getSession().getServletContext().getRealPath("/") + "resources" + File.separator
					+ "userPhoto" + File.separator + nowdate + File.separator;
			File file = new File(savePath);
			if (!file.isDirectory()) {
				file.mkdirs();
			}
			System.err.println(savePath + filename);
			// 字节流写入文件
			OutputStream outstream = null;
			try {
				outstream = new FileOutputStream(savePath + filename);
				outstream.write(dataByte);
				outstream.flush();
				outstream.close();
				user.setPhoto("/pricesheetGen/resources/userPhoto/" + nowdate + "/" + filename);
				// 保存用户信息
				systemService.saveFrontUser(user);
//				long num = userDao.updateFrontUser(user);
//				if (num > 0) {
					map.put("result", 1);
					map.put("data", "");
					map.put("msg", "修改成功");
//				} else {
//					map.put("result", 0);
//					map.put("data", "");
//					map.put("msg", "修改失败");
//				}
			} catch (FileNotFoundException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}else{
			User user2 = new User();
			user2.setPhone(phone);
			User user = userDao.findUserByPhone(user2);

			// 生成用户二维码，使用登录名
			String realPath = Global.getUserfilesBaseDir() + Global.USERFILES_BASE_URL + user.getId() + "/qrcode/";
			FileUtils.createDirectory(realPath);
			String names = user.getId() + ".png"; // encoderImgId此处二维码的图片名
			String filePath = realPath + names; // 存放路径
			TwoDimensionCode.encoderQRCode(user.getPhone(), filePath, "png");// 执行生成二维码
			user.setQrCode(request.getContextPath() + Global.USERFILES_BASE_URL + user.getId() + "/qrcode/" + names);

			
			Office office = new Office();
			office.setName(companyName);
			office.setType("1");
			office=officeDao.getEntity(office);
			
			if(office==null || office.getId()==null || office.getId().equals("")){
				office=new Office(IdGen.uuid());
				office.setName(companyName);
				office.setEmail("");
				office.setFax(fox);
				office.setPhone(companyPhone);
				office.setParent(new Office("0"));
				office.setParentIds("0,");
				office.setGrade("1");
				office.setType("1");
				office.setCreateDate(new Date());
				office.setUpdateDate(new Date());
				office.setArea(new Area());
				office.setMaster("");
				office.setUpdateBy(user);
				office.setCreateBy(user);
				office.setDelFlag("0");
				office.setUseable("1");
				if(office.getId()=="1"){
					user.setIsCustomer("0");
				}
				officeDao.insert(office);
			}else{
				office.setName(companyName);
				office.setEmail("");
				office.setFax(fox);
				office.setPhone(companyPhone);
				office.setParent(new Office("0"));
				office.setParentIds("0,");
				office.setGrade("1");
				office.setType("1");
				office.setCreateDate(new Date());
				office.setUpdateDate(new Date());
				office.setArea(new Area());
				office.setMaster("");
				office.setUpdateBy(user);
				office.setCreateBy(user);
				office.setDelFlag("0");
				office.setUseable("1");
				officeDao.update(office);
			}
			
			user.setPhone(phone);
			user.setName(name);
			user.setEmail(email);
			user.setEmailUserName(email);	
			user.setEmailPassword(emailPassword);
			user.setUpdateDate(new Date());
			user.setCompany(office);
			user.setOffice(new Office());
			user.setPhoto("");
			// 保存用户信息
			systemService.saveFrontUser(user);
			map.put("result", 1);
			map.put("data", "");
			map.put("msg", "修改成功");
		}
		
		
		infoEntity.setData(map);
		return infoEntity;
	}

	/**
	 * 根据手机号码查询用户
	 * 
	 * @param userName
	 * @param password
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/inf/v1.0.1/findUserByPhone", method = RequestMethod.GET)
	@ResponseBody
	public MsgInfoEntity findUserByPhone(@RequestParam(value = "phone", required = false) String phone) {
		MsgInfoEntity entity = new MsgInfoEntity();
		Map<Object, Object> map = new HashMap<Object, Object>();
		User user2 = new User();
		user2.setPhone(phone);
		User users = userDao.findUserByPhone(user2);
		if (users != null) {
			UserUtil userUtil = new UserUtil();
			userUtil.setAddress(users.getCompany() == null ? "" : users.getCompany().getAddress());
			userUtil.setCompany(users.getCompany() == null ? "" : users.getCompany().getName());
			userUtil.setCompanyEmail(users.getCompany() == null ? "" : users.getCompany().getEmail());
			userUtil.setCompanyPhone(users.getCompany() == null ? "" : users.getCompany().getPhone());
			userUtil.setEmail(users.getEmail() == null ? "" : users.getEmail());
			userUtil.setEmailUserName(users.getEmailUserName() == null ? "" : users.getEmailUserName());
			userUtil.setEmailPassword(users.getEmailPassword() == null ? "" : users.getEmailPassword());
			userUtil.setFax(users.getCompany() == null ? "" : users.getCompany().getFax());
			userUtil.setName(users.getName() == null ? "" : users.getName());
			userUtil.setPhone(users.getPhone() == null ? "" : users.getPhone());
			userUtil.setPhoto(users.getPhoto() == null ? "" : users.getPhoto());
			map.put("result", 1);
			map.put("data", userUtil);
			map.put("msg", "");
		} else {
			map.put("result", 0);
			map.put("data", "");
			map.put("msg", "该用户不存在");
		}
		entity.setData(map);
		return entity;
	}
	
	@RequestMapping(value = "/inf/v1.0.1/findCompanyByName", method = RequestMethod.POST)
	@ResponseBody
	public MsgInfoEntity findCompanyByName(@RequestParam(value = "companyName", required = false) String companyName) {
		MsgInfoEntity entity = new MsgInfoEntity();
		Map<Object, Object> map = new HashMap<Object, Object>();
		Office office = new Office();
		office.setName(companyName);
		office.setType("1");
		office=officeDao.getEntity(office);
		if (office == null) {
			office = new Office();
		} 
		map.put("result", 1);
		map.put("data", office);
		map.put("msg", "");
		entity.setData(map);
		return entity;
	}
	
	/**
	 *获取 销售人员信息
	 * @param phone
	 * @return
	 */
	@RequestMapping(value = "/inf/v1.0.1/selectStaff", method = RequestMethod.GET)
	@ResponseBody
	public MsgInfoEntity selectStaff(@RequestParam(value = "id", required = false) String id) {
		MsgInfoEntity entity = new MsgInfoEntity();
		Map<Object, Object> map = new HashMap<Object, Object>();
		User user = new User();
		user.setId(id);
		User user1 = userDao.get(user);
		map.put("result", 1);
		map.put("data", user1);
		map.put("msg", ""); 
		entity.setData(map);
		return entity;
	}
	
	@RequestMapping(value = "/inf/v1.0.1/saveOrder", method = RequestMethod.POST)
	@ResponseBody
	public AjaxJson saveOrder(@RequestBody QuotationOrder quotationOrder) throws Exception {
//		MsgInfoEntity entity = new MsgInfoEntity();
//		Map<Object, Object> map = new HashMap<Object, Object>();
		AjaxJson json = new AjaxJson();

		json = quotationOrderService.frontSave(quotationOrder,json);
		//发送pdf
		quotationOrderService.sendOrderPdf(quotationOrder);
		return json;
//		entity.setData(map);
//		return entity;
	}
	
	
	@RequestMapping(value = "/inf/v1.0.1/saveCheckOrder", method = RequestMethod.POST)
	@ResponseBody
	public AjaxJson saveCheckOrder(@RequestBody QuotationOrder quotationOrder) throws Exception {
//		MsgInfoEntity entity = new MsgInfoEntity();
//		Map<Object, Object> map = new HashMap<Object, Object>();
		AjaxJson json = new AjaxJson();

		json = quotationOrderService.frontSave(quotationOrder,json);
		//发送pdf
		quotationOrderService.createPdf(quotationOrder);
		
		quotationOrderService.sendEmailToManager(quotationOrder);
		return json;
//		entity.setData(map);
//		return entity;
	}
	
	public static boolean isMobileNO(String mobiles) {
		String regExp = "^(0|86|17951)?(13[0-9]|15[0-9]|17[678]|18[0-9]|14[57])[0-9]{8}$";

		Pattern p = Pattern.compile(regExp);

		Matcher m = p.matcher(mobiles);
		return m.find();
		// Pattern p =
		// Pattern.compile("^((13[0-9])|(15[^4,\\D])|(18[0,5-9]))\\d{8}$");
		// Matcher m = p.matcher(mobiles);
		// System.out.println(m.matches()+"---");
		// boolean falg = m.matches();
		// return falg;
	}
}