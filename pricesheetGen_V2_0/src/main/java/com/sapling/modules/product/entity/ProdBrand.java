package com.sapling.modules.product.entity;

import java.util.Date;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.google.common.collect.Lists;
import com.sapling.common.persistence.DataEntity;

/**
 * 品牌信息表实体类
 * 
 * @author zhoujinlai
 *
 */

public class ProdBrand extends DataEntity<ProdBrand> {

	private static final long serialVersionUID = 1L;
	
	private Long uid;
	
	private List<Product> product;
	
	private String brandId;  //品牌
	
	private String brandName;
	
	public Long getUid() {
		return uid;
	}

	public void setUid(Long uid) {
		this.uid = uid;
	}

	public List<Product> getProduct() {
		return product;
	}

	public void setProduct(List<Product> product) {
		this.product = product;
	}

	public String getBrandId() {
		return brandId;
	}

	public void setBrandId(String brandId) {
		this.brandId = brandId;
	}

	public String getBrandName() {
		return brandName;
	}

	public void setBrandName(String brandName) {
		this.brandName = brandName;
	}

}
