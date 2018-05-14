/**
 * Copyright &copy; 2015-2020 <a href="http://www.jeeplus.org/">JeePlus</a> All rights reserved.
 */
package com.sapling.modules.quotation.entity;

import java.util.Date;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonFormat;
import java.math.BigDecimal;

import com.sapling.common.persistence.DataEntity;
import com.sapling.common.utils.DateUtils;
import com.sapling.common.utils.excel.annotation.ExcelField;

/**
 * 报价单Entity
 * @author cth
 * @version 2017-01-24
 */
public class QuotationOrder extends DataEntity<QuotationOrder> {
	
	private static final long serialVersionUID = 1L;
	private Long uid;
	private String quotationCode;		// 报价单号
	private Date quotationDate;		// 报价日期
	private String quotationDateStr;		// 报价日期
	private String settlementType;		// 结算方式
	private String payType;				//付款方式
	private BigDecimal withTaxAmt;		// 含税总价
	private BigDecimal privilegeAmt;		// 优惠金额
	private BigDecimal dealAmt;		// 最终成交价
	private Integer arrivalDays;		// 到货天数
	private String custId;		// 客户ID
	private String custName;		// 客户名称
	private String status;		// 状态
	private String sndFlag;		// 发送状态
	private String remark;		// 备注信息
	private String staffId;		// 员工ID
	private String staffName;		// 销售人员
	private String deliveryMode;		// 付款期限
	private String otherAdd;		// 付款期限备注
	private String company;		// 公司名称
	private String companyCode;		// 公司编号
	private String companyPhone;		// 公司电话
	private String companyFax;		// 公司传真
	private String companyMail;		//公司邮箱
	private String quotationAbout;		// 报价关于
	private Date beginQuotationDate;		// 开始 报价日期
	private Date endQuotationDate;		// 结束 报价日期
	private String productName;
	
	public Long getUid() {
		return uid;
	}

	public void setUid(Long uid) {
		this.uid = uid;
	}

	private String transType; // send flag
	
	private List<QuotationOrderDetail> quotationOrderDetails;
	
	public QuotationOrder() {
		super();
	}

	public QuotationOrder(String id){
		super(id);
	}

	@ExcelField(title="报价单号", align=2, sort=1)
	public String getQuotationCode() {
		return quotationCode;
	}

	public void setQuotationCode(String quotationCode) {
		this.quotationCode = quotationCode;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@ExcelField(title="报价日期", align=2, sort=2)
	public Date getQuotationDate() {
		return quotationDate;
	}

	public void setQuotationDate(Date quotationDate) {
		this.quotationDate = quotationDate;
	}
	
	public String getQuotationDateStr() {
		return quotationDateStr;
	}

	public void setQuotationDateStr(String quotationDateStr) {
		if(quotationDateStr!=null){
			this.quotationDate =DateUtils.parseDate(quotationDateStr);
		}
		this.quotationDateStr = quotationDateStr;
	}

	@ExcelField(title="结算方式", align=2, sort=3)
	public String getSettlementType() {
		return settlementType;
	}

	public void setSettlementType(String settlementType) {
		this.settlementType = settlementType;
	}
	
	@ExcelField(title="含税总价", align=2, sort=4)
	public BigDecimal getWithTaxAmt() {
		return withTaxAmt;
	}
	
	public String getPayType() {
		return payType;
	}

	public void setPayType(String payType) {
		this.payType = payType;
	}

	public void setWithTaxAmt(BigDecimal withTaxAmt) {
		this.withTaxAmt = withTaxAmt;
	}
	
	@ExcelField(title="优惠金额", align=2, sort=5)
	public BigDecimal getPrivilegeAmt() {
		return privilegeAmt;
	}

	public void setPrivilegeAmt(BigDecimal privilegeAmt) {
		this.privilegeAmt = privilegeAmt;
	}
	
	@ExcelField(title="最终成交价", align=2, sort=6)
	public BigDecimal getDealAmt() {
		return dealAmt;
	}

	public void setDealAmt(BigDecimal dealAmt) {
		this.dealAmt = dealAmt;
	}
	
	@ExcelField(title="到货天数", align=2, sort=7)
	public Integer getArrivalDays() {
		return arrivalDays;
	}

	public void setArrivalDays(Integer arrivalDays) {
		this.arrivalDays = arrivalDays;
	}
	
	@ExcelField(title="客户ID", align=2, sort=8)
	public String getCustId() {
		return custId;
	}

	public void setCustId(String custId) {
		this.custId = custId;
	}
	
	@ExcelField(title="客户名称", align=2, sort=9)
	public String getCustName() {
		return custName;
	}

	public void setCustName(String custName) {
		this.custName = custName;
	}
	
	@ExcelField(title="状态", align=2, sort=10)
	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	
	@ExcelField(title="发送状态", align=2, sort=11)
	public String getSndFlag() {
		return sndFlag;
	}

	public void setSndFlag(String sndFlag) {
		this.sndFlag = sndFlag;
	}
	
	@ExcelField(title="备注信息", align=2, sort=12)
	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}
	
	@ExcelField(title="员工ID", align=2, sort=13)
	public String getStaffId() {
		return staffId;
	}

	public void setStaffId(String staffId) {
		this.staffId = staffId;
	}
	
	@ExcelField(title="销售人员", align=2, sort=14)
	public String getStaffName() {
		return staffName;
	}

	public void setStaffName(String staffName) {
		this.staffName = staffName;
	}
	
	@ExcelField(title="付款期限", align=2, sort=15)
	public String getDeliveryMode() {
		return deliveryMode;
	}

	public void setDeliveryMode(String deliveryMode) {
		this.deliveryMode = deliveryMode;
	}
	
	@ExcelField(title="付款期限备注", align=2, sort=16)
	public String getOtherAdd() {
		return otherAdd;
	}

	public void setOtherAdd(String otherAdd) {
		this.otherAdd = otherAdd;
	}
	
	@ExcelField(title="公司名称", align=2, sort=17)
	public String getCompany() {
		return company;
	}

	public void setCompany(String company) {
		this.company = company;
	}
	
	@ExcelField(title="公司编号", align=2, sort=18)
	public String getCompanyCode() {
		return companyCode;
	}

	public void setCompanyCode(String companyCode) {
		this.companyCode = companyCode;
	}
	
	@ExcelField(title="公司电话", align=2, sort=19)
	public String getCompanyPhone() {
		return companyPhone;
	}

	public void setCompanyPhone(String companyPhone) {
		this.companyPhone = companyPhone;
	}
	
	@ExcelField(title="公司传真", align=2, sort=20)
	public String getCompanyFax() {
		return companyFax;
	}

	public void setCompanyFax(String companyFax) {
		this.companyFax = companyFax;
	}
	
	@ExcelField(title="报价关于", align=2, sort=21)
	public String getQuotationAbout() {
		return quotationAbout;
	}

	public void setQuotationAbout(String quotationAbout) {
		this.quotationAbout = quotationAbout;
	}
	
	public Date getBeginQuotationDate() {
		return beginQuotationDate;
	}

	public void setBeginQuotationDate(Date beginQuotationDate) {
		this.beginQuotationDate = beginQuotationDate;
	}
	
	public Date getEndQuotationDate() {
		return endQuotationDate;
	}

	public void setEndQuotationDate(Date endQuotationDate) {
		this.endQuotationDate = endQuotationDate;
	}

	public List<QuotationOrderDetail> getQuotationOrderDetails() {
		return quotationOrderDetails;
	}

	public void setQuotationOrderDetails(List<QuotationOrderDetail> quotationOrderDetails) {
		this.quotationOrderDetails = quotationOrderDetails;
	}

	public String getTransType() {
		return transType;
	}

	public void setTransType(String transType) {
		this.transType = transType;
	}

	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}

	public String getCompanyMail() {
		return companyMail;
	}

	public void setCompanyMail(String companyMail) {
		this.companyMail = companyMail;
	}
	
}