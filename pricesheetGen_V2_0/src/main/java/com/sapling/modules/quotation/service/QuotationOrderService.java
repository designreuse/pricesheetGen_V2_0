/**
 * Copyright &copy; 2015-2020 <a href="http://www.jeeplus.org/">JeePlus</a> All rights reserved.
 */
package com.sapling.modules.quotation.service;

import java.io.File;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sapling.common.config.Global;
import com.sapling.common.json.AjaxJson;
import com.sapling.common.persistence.Page;
import com.sapling.common.service.CrudService;
import com.sapling.common.utils.DateUtils;
import com.sapling.common.utils.ExchangeMail;
import com.sapling.common.utils.HttpURLConnectionUtil;
import com.sapling.common.utils.Pinyin4jUtil;
import com.sapling.common.utils.StringUtils;
import com.sapling.common.utils.bus.Constant;
import com.sapling.modules.quotation.dao.QuotationOrderDao;
import com.sapling.modules.quotation.dao.QuotationOrderDetailDao;
import com.sapling.modules.quotation.entity.QuotationOrder;
import com.sapling.modules.quotation.entity.QuotationOrderDetail;
import com.sapling.modules.sys.entity.Office;
import com.sapling.modules.sys.entity.User;
import com.sapling.modules.sys.utils.UserUtils;

/**
 * 报价单Service
 * @author cth
 * @version 2017-01-24
 */
@Service
@Transactional(readOnly = true)
public class QuotationOrderService extends CrudService<QuotationOrderDao, QuotationOrder> {
	
	/**
	 * 
	 */
	@Autowired
	private QuotationOrderDetailDao orderDetailDao;
	
	private UserUtils userUtils;

	public QuotationOrder get(String id) {
		return super.get(id);
	}
	
	public List<QuotationOrder> findList(QuotationOrder quotationOrder) {
		return super.findList(quotationOrder);
	}
	
	public Page<QuotationOrder> findPage(Page<QuotationOrder> page, QuotationOrder quotationOrder) {
		return super.findPage(page, quotationOrder);
	}
	
	/**
	 * 查询单笔报价单详情
	 * @param id
	 * @return
	 */
	public QuotationOrder queryQuotationOrderDtl(String id) {
		QuotationOrder _po = dao.get(id);
		List<QuotationOrderDetail> _dlt = orderDetailDao.selectByQuotId(id);
		_po.setQuotationOrderDetails(_dlt);
		return _po;
	}
	
	/**
	 * 保存报价单
	 * @param order
	 * @param jo
	 * @return
	 */
	@Transactional(readOnly = false)
	public AjaxJson save(QuotationOrder order,AjaxJson jo) {
		if(jo==null){
			jo = new AjaxJson();
		}
		if(order==null|| StringUtils.isBlank(order.getStaffId())){
			jo.put("state", "0");
			jo.put("msg", "销售人员不存在!");
			return jo;
		}
		User staff = UserUtils.get(order.getStaffId());
		if(staff==null || StringUtils.isBlank(staff.getNo())){
			//告诉前台  销售人员不存在
			jo.put("state", "0");
			jo.put("msg", "销售人员不存在!");
			return jo;
		}
		order.setStaffName(staff.getName());
		//当前系统登录人 即客户
		User user = UserUtils.getUser();
		//公司简称
		String companyJc ="GSJC";//user.getCompanyJc();
		
		if(user.getRoleList()!=null && user.getRoleList().size()==1
				&& Constant.USER_ROLE_CLIENT.equals(user.getRoleList().get(0).getRoleCode())){
			//05 代表的是客户
			Office co = user.getCompany();
			order.setCompany(co.getName());
			order.setCompanyFax(co.getFax());
			order.setCustName(user.getName());
			order.setCompanyPhone(co.getPhone());
			order.setCompanyMail(co.getEmail());
			order.setStaffName(user.getName());
		}else{
			//获取公司前四个字首字母
			companyJc = Pinyin4jUtil.rtnCo4length(order.getCompany());
		}
			
		
		List<QuotationOrderDetail> _dtlis = order.getQuotationOrderDetails();
		if(_dtlis==null || _dtlis.isEmpty()){
			//告诉前台  销售人员不存在
			jo.put("state", "0");
			jo.put("msg", "请完善产品明细信息!");
			return jo;
		}
		String _quotationCode = order.getQuotationCode();
		String _id = null;
		//有编号 即是修改数据
		if(StringUtils.isNotBlank(_quotationCode) && _quotationCode.length()==23){
			order.setUpdateBy(user);
			int _count = dao.updateByQuotCodeWithId(order);
			if(_count==0){
				//更新的最基本条件一定是系统用户
//				jo.put("state", "0");
//				jo.put("msg", "获取当前更新人异常!");
//				return jo;
			}
			//删除明细
			orderDetailDao.deleteByQuotCode(_quotationCode);
		}else{
			//新增数据
			_id = UUID.randomUUID().toString().replace("-", "");
			_quotationCode = quotationCode(companyJc,staff);
			order.setQuotationDate(new Date());
			order.setQuotationCode(_quotationCode);
			order.setCreateBy(user);
			order.setId(_id);
			dao.insert(order);
		}
		for (QuotationOrderDetail _dt : _dtlis) {
			_dt.setQuotationCode(_quotationCode);
			orderDetailDao.insert(_dt);
		}
		jo.put("state", "1");
		jo.put("msg", _quotationCode+"该报价单保存成功！");
		jo.put("quotationCode", _quotationCode);
		jo.put("id", _id);
		
		return jo;
	}
	
	@Transactional(readOnly = false)
	public void delete(QuotationOrder quotationOrder) {
		super.delete(quotationOrder);
	}
	
	/**
	 * 
	 * @param companyJc
	 * @param staffId
	 * @param no 
	 * @return
	 */
	private String quotationCode(String companyJc, User staff) {
		String _rtn = "01" + companyJc.substring(0, 4) + "BJ" + DateUtils.getDate("yyyyMMdd").substring(2)+"02" + staff.getNo();
		int curentCount = dao.selectStaffCurCount(staff.getId());
		// 0 代表前面补充0
		// 4 代表长度为4
		// d 代表参数为正数型
		_rtn+= String.format("%03d", curentCount+1);
		return _rtn;
	}
	
	private boolean pdfBuilt(String id){
		Map<String, String> paramers = new HashMap<String, String>();
		paramers.put("propertiesKeyTarger", "url.quotation.server.detail");
		paramers.put("propertiesKeyReceive", "url.quotation.server.receive");
		paramers.put("fileExtends", "PDF");
		paramers.put("id", id);
		/** 
		 */
		try {
			HttpURLConnectionUtil.targerNetUrl("wkhtmltopdf.service.url", paramers);
			//留个服务器一个相应时间且
			Thread.sleep(2000);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
	public void sanderPdf(QuotationOrder order) throws Exception{
		if(StringUtils.isNotBlank(order.getCustId())){
			User user = userUtils.get(order.getCustId());
			String mail =user.getEmail();
			if(mail!=null){
				if(StringUtils.isNotBlank(order.getTransType())&&order.getTransType().equals("001")){
					pdfBuilt(order.getId());
					String subject="上海小数信息技术有限公司报价单";
					
					List<String> to = new ArrayList<String>();
					to.add(mail);
					String bodyText="本邮件由上海小数信息技术有限公司商务指定邮件发出；";
					String fileName = Global.USERFILES_BASE_TEMP_URL + order.getId() + ".pdf";
					File nf = new File(fileName);
					if (!nf.exists()) {
						sanderPdf(order);
					}
					ExchangeMail.doSend(subject,to,null,bodyText,fileName);
				}
			}
		}
	}
}