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

public class ProductImp extends DataEntity<ProductImp>{
	private static final long serialVersionUID = 1L;

	private String pId;
	
	private String pName;
	
	private String classfiy;
	
	private String brand;
	
	private String model;
	
	private String delStatus;
	
	public String getpId() {
		return pId;
	}

	public void setpId(String pId) {
		this.pId = pId;
	}

	public String getpName() {
		return pName;
	}

	public void setpName(String pName) {
		this.pName = pName;
	}

	public String getClassfiy() {
		return classfiy;
	}

	public void setClassfiy(String classfiy) {
		this.classfiy = classfiy;
	}


	public String getBrand() {
		return brand;
	}

	public void setBrand(String brand) {
		this.brand = brand;
	}

	public String getModel() {
		return model;
	}
 
	public void setModel(String model) {
		this.model = model;
	}

	public String getDelStatus() {
		return delStatus;
	}

	public void setDelStatus(String delStatus) {
		this.delStatus = delStatus;
	}
}
