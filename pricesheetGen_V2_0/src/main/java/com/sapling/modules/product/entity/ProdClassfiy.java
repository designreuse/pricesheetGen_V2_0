package com.sapling.modules.product.entity;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.google.common.collect.Lists;
import com.sapling.common.persistence.DataEntity;
import com.sapling.common.utils.excel.annotation.ExcelField;
import com.sapling.common.utils.excel.fieldtype.RoleListType;
import com.sapling.modules.sys.entity.Role;

public class ProdClassfiy extends DataEntity<ProdClassfiy>{
	private static final long serialVersionUID = 1L;
	/**
	 * 主键id
	 */
	private Long uid;

	private String prodClassfiyId;
	
	private String prodClassfiyName;
	
	public Long getUid() {
		return uid;
	}

	public void setUid(Long uid) {
		this.uid = uid;
	}

	public String getProdClassfiyId() {
		return prodClassfiyId;
	}

	public void setProdClassfiyId(String prodClassfiyId) {
		this.prodClassfiyId = prodClassfiyId;
	}

	public String getProdClassfiyName() {
		return prodClassfiyName;
	}

	public void setProdClassfiyName(String prodClassfiyName) {
		this.prodClassfiyName = prodClassfiyName;
	}

}
