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

public class Product extends DataEntity<Product>{
	private static final long serialVersionUID = 1L;
	/**
	 * 主键id
	 */
	private Long uid;

	private String productId;
	
	private String productName;
	
	private String byNameOne;
	
	private String byNameTwo;
	
	private List<ProdBrand> brands= Lists.newArrayList();
	
	private List<ProdClassfiy> classfiys= Lists.newArrayList();

	private List<ProdModel> models= Lists.newArrayList();
	
	public Long getUid() {
		return uid;
	}

	public void setUid(Long uid) {
		this.uid = uid;
	}

	public String getProductId() {
		return productId;
	}

	public void setProductId(String productId) {
		this.productId = productId;
	}

	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}

	public String getByNameOne() {
		return byNameOne;
	}

	public void setByNameOne(String byNameOne) {
		this.byNameOne = byNameOne;
	}

	public String getByNameTwo() {
		return byNameTwo;
	}

	public void setByNameTwo(String byNameTwo) {
		this.byNameTwo = byNameTwo;
	}
	 
	public List<ProdBrand> getBrands() {
		return brands;
	}

	public void setBrands(List<ProdBrand> brands) {
		this.brands = brands;
	}
	
	@JsonIgnore
	public List<String> getBrandIdList() {
		List<String> brandIdList = Lists.newArrayList();
		for (ProdBrand brand : brands) {
			brandIdList.add(brand.getBrandId());
		}
		return brandIdList;
	}

	public void setBrandIdList(List<String> brandIdList) {
		brands = Lists.newArrayList();
		for (String brandId : brandIdList) {
			ProdBrand brand = new ProdBrand();
			brand.setBrandId(brandId);
			brands.add(brand);
		}
	}

	public List<ProdClassfiy> getClassfiys() {
		return classfiys;
	}

	public void setClassfiys(List<ProdClassfiy> classfiys) {
		this.classfiys = classfiys;
	}

	@JsonIgnore
	public List<String> getClassfiyIdList() {
		List<String> classfiyIdList = Lists.newArrayList();
		for (ProdClassfiy classfiy : classfiys) {
			classfiyIdList.add(classfiy.getProdClassfiyId());
		}
		return classfiyIdList;
	}

	public void setClassfiyIdList(List<String> classfiyIdList) {
		classfiys = Lists.newArrayList();
		for (String prodClassfiyId : classfiyIdList) {
			ProdClassfiy classfiy = new ProdClassfiy();
			classfiy.setProdClassfiyId(prodClassfiyId);
			classfiys.add(classfiy);
		}
	}

	public List<ProdModel> getModels() {
		return models;
	}

	public void setModels(List<ProdModel> models) {
		this.models = models;
	}
	
	
	@JsonIgnore
	public List<String> getModelIdList() {
		List<String> modelIdList = Lists.newArrayList();
		for (ProdModel model : models) {
			modelIdList.add(model.getModelId());
		}
		return modelIdList;
	}

	public void setModelIdList(List<String> modelIdList) {
		models = Lists.newArrayList();
		for (String modelId : modelIdList) {
			ProdModel model = new ProdModel();
			model.setModelId(modelId);
			models.add(model);
		}
	}
}
