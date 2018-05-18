package com.sapling.modules.product.entity;

import java.util.Date;

import com.sapling.common.persistence.DataEntity;


/**
 * 品牌信息表实体类
 * 
 * @author zhoujinlai
 *
 */

public class ProdModel extends DataEntity<ProdModel>{
	
	private static final long serialVersionUID = 1L;
	/**
	 * 主键id
	 */
	private Long uid;

	private String modelId;

	private String modelName;
	
	public Long getUid() {
		return uid;
	}

	public void setUid(Long uid) {
		this.uid = uid;
	}

	public String getModelId() {
		return modelId;
	}

	public void setModelId(String modelId) {
		this.modelId = modelId;
	}

	public String getModelName() {
		return modelName;
	}

	public void setModelName(String modelName) {
		this.modelName = modelName;
	}

}
