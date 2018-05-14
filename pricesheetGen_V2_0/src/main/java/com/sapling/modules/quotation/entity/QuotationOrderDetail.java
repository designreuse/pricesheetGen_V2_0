/**
 * Copyright &copy; 2015-2020 <a href="http://www.sapling.org/">sapling</a> All rights reserved.
 */
package com.sapling.modules.quotation.entity;

import java.math.BigDecimal;
import java.util.List;

import com.sapling.common.persistence.DataEntity;
import com.sapling.common.utils.excel.annotation.ExcelField;
import com.sapling.modules.annotation.entity.Annotation;

/**
 * 报价单明细Entity
 * @author cth
 * @version 2017-01-25
 */
public class QuotationOrderDetail extends DataEntity<QuotationOrderDetail> {
	
	private static final long serialVersionUID = 1L;
	private Long uid; 
	private String quotationCode;	// 报价单号
	private String productType;		// 产品类型
	private String orderNo;		    // 序号
	private String productName;		// 产品名称
	private String productDesc;		// 产品描述
	private String unin;		    // 单位
	private BigDecimal amount;		// 数量
	private BigDecimal unitPrice;	// 单价
	private BigDecimal totalAmt;	// 总金额
	private String status;		    // 状态
	private List<Annotation> annotation;  // 产品注释
	
	private List<QuotationOrderDetail> list;

	public Long getUid() {
		return uid;
	}

	public void setUid(Long uid) {
		this.uid = uid;
	}
	
	public QuotationOrderDetail() {
		super();
	}

	public QuotationOrderDetail(String id){
		super(id);
	}

	@ExcelField(title="报价单号", align=2, sort=1)
	public String getQuotationCode() {
		return quotationCode;
	}

	public void setQuotationCode(String quotationCode) {
		this.quotationCode = quotationCode;
	}
	
	@ExcelField(title="产品类型", align=2, sort=2)
	public String getProductType() {
		return productType;
	}

	public void setProductType(String productType) {
		this.productType = productType;
	}
	
	@ExcelField(title="序号", align=2, sort=3)
	public String getOrderNo() {
		return orderNo;
	}

	public void setOrderNo(String orderNo) {
		this.orderNo = orderNo;
	}
	
	@ExcelField(title="产品名称", align=2, sort=4)
	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}
	
	@ExcelField(title="产品描述", align=2, sort=5)
	public String getProductDesc() {
		return productDesc;
	}

	public void setProductDesc(String productDesc) {
		this.productDesc = productDesc;
	}
	
	@ExcelField(title="单位", align=2, sort=6)
	public String getUnin() {
		return unin;
	}

	public void setUnin(String unin) {
		this.unin = unin;
	}
	
	@ExcelField(title="数量", align=2, sort=7)
	public BigDecimal getAmount() {
		return amount;
	}

	public void setAmount(BigDecimal amount) {
		this.amount = amount;
	}
	
	@ExcelField(title="单价", align=2, sort=8)
	public BigDecimal getUnitPrice() {
		return unitPrice;
	}

	public void setUnitPrice(BigDecimal unitPrice) {
		this.unitPrice = unitPrice;
	}
	
	@ExcelField(title="总金额", align=2, sort=9)
	public BigDecimal getTotalAmt() {
		return totalAmt;
	}

	public void setTotalAmt(BigDecimal totalAmt) {
		this.totalAmt = totalAmt;
	}
	
	@ExcelField(title="状态", align=2, sort=14)
	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	// 获取产品注释
	public List<Annotation> getAnnotation() {
		return annotation;
	}

	// 涉资产品注释
	public void setAnnotation(List<Annotation> annotation) {
		this.annotation = annotation;
	}

	public List<QuotationOrderDetail> getList() {
		return list;
	}

	public void setList(List<QuotationOrderDetail> list) {
		this.list = list;
	}	
	
}