package com.sapling.modules.quotation.web;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.sapling.common.utils.IPUtils;
import com.sapling.modules.quotation.entity.QuotationOrder;
import com.sapling.modules.quotation.service.QuotationOrderDetailService;
import com.sapling.modules.quotation.service.QuotationOrderService;
import com.sapling.modules.sys.dao.UserDao;
import com.sapling.modules.sys.entity.User;

/**
 * 报价单Controller
 * @author cth
 * @version 2017-01-24
 */
@Controller
@RequestMapping(value = "/static/quotation/quotationOrder")
public class QuotationOrderUnnomalController {

	Logger logger = LoggerFactory.getLogger(getClass());

	@Autowired
	private QuotationOrderService quotationOrderService;

	@Autowired
	private UserDao userDao;
	@Autowired
	private QuotationOrderDetailService quotationOrderDetailService;	
	
	/**
	 * 功能: 报价单明细查看页面导航入口
	 * 作者: 刘张学
	 * 
	 */	
	@RequestMapping(value = {"show"})
	public String show(HttpServletRequest request,QuotationOrder quotationQry, Model model) {
//		if(!interceptorsIP(request,quotationQry.getId())){
//			return "modules/sys/sysLogin";
//		} 
		QuotationOrder quotationRlt = quotationOrderService.queryQuotationOrderDtl(quotationQry.getId());
		quotationOrderDetailService.sortQuotationOrderDetails(quotationRlt);
		User user = new User();
		user.setId(quotationRlt.getStaffId());
		User user1 = userDao.get(user);
		model.addAttribute("quotationQry", quotationQry);
		model.addAttribute("quotationRlt",  quotationRlt);
		model.addAttribute("user",  user1);
		return "modules/quotation/pdfPrintPage";
	}
	
	private boolean interceptorsIP(HttpServletRequest request,String quotationCode){
		String ip = IPUtils.getIpAddress(request);
		logger.info("当前IP："+ip+"获取报价单明星，报价单号ID:"+quotationCode);
		String[] _ips = IPUtils.getSysTrustInteriorIps();
		if(_ips!=null){
			for (String _ip : _ips) {
				if(_ip.trim().equals(ip));
				return true;
			}
		}
		return false;
	}
	
}
