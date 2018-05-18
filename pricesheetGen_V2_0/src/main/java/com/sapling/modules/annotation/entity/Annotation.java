
package com.sapling.modules.annotation.entity;

import java.math.BigDecimal;

import com.sapling.common.persistence.DataEntity;

/**
 * 注释Entity
 * @author llz
 * @version 2017-01-24
 */
public class Annotation extends DataEntity<Annotation> {
	
	private static final long serialVersionUID = 1L;
	/**
	 * 主键id
	 */
	private Long uid;
	/**
	 * 报价单Id
	 */
	private String  orderId;
	/**
	 * 报价单明细id
	 */
	private Long detailId;
	/**
	 * 
	 */
	private String classfiyName;

	/**
	 * 品牌
	 */
	private String annoName;
	
	/**
	 * 型号
	 */
	private String annoType;
	/**
	 * 价格
	 */
	private BigDecimal annoPrice;
	/**
	 * 是否主注释
	 */
	private String isMaster;
	/**
	 * 报价单号
	 */
	private String quotationCode;

	/**
	 * 数量
	 */
	private int amount;
	/**
	 * 单价
	 */
	private BigDecimal unitPrice;
	/**
	 * 金额
	 */
	private BigDecimal totalAmt;
	
	/**
	 * 状态
	 */
	private String state;
	
	/**
	 * 备注
	 */
	private String remark;	
	
	
	private String  pId; //商品ID

	public Long getUid() {
		return uid;
	}

	public void setUid(Long uid) {
		this.uid = uid;
	}	
	
	public String getOrderId() {
		return orderId;
	}

	public void setOrderId(String orderId) {
		this.orderId = orderId;
	}

	public Annotation() {
		super();
	}

	public Annotation(String id){
		super(id);
	}

	public Long getDetailId() {
		return detailId;
	}

	public void setDetailId(Long detailId) {
		this.detailId = detailId;
	}

	public String getClassfiyName() {
		return classfiyName;
	}

	public void setClassfiyName(String classfiyName) {
		this.classfiyName = classfiyName;
	}

	public String getAnnoName() {
		return annoName;
	}

	public void setAnnoName(String annoName) {
		this.annoName = annoName;
	}

	public String getAnnoType() {
		return annoType;
	}

	public void setAnnoType(String annoType) {
		this.annoType = annoType;
	}

	public BigDecimal getAnnoPrice() {
		return annoPrice;
	}

	public void setAnnoPrice(BigDecimal annoPrice) {
		this.annoPrice = annoPrice;
	}

	public String getIsMaster() {
		return isMaster;
	}

	public void setIsMaster(String isMaster) {
		this.isMaster = isMaster;
	}

	public String getQuotationCode() {
		return quotationCode;
	}

	public void setQuotationCode(String quotationCode) {
		this.quotationCode = quotationCode;
	}

	public int getAmount() {
		return amount;
	}

	public void setAmount(int amount) {
		this.amount = amount;
	}

	public BigDecimal getUnitPrice() {
		return unitPrice;
	}

	public void setUnitPrice(BigDecimal unitPrice) {
		this.unitPrice = unitPrice;
	}

	public BigDecimal getTotalAmt() {
		return totalAmt;
	}

	public void setTotalAmt(BigDecimal totalAmt) {
		this.totalAmt = totalAmt;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}		
	
	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public String getpId() {
		return pId;
	}

	public void setpId(String pId) {
		this.pId = pId;
	}	
	
	
}