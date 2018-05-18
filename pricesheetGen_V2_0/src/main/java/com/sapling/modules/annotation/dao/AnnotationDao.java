package com.sapling.modules.annotation.dao;

import java.util.List;
import java.util.Map;

import com.sapling.common.persistence.CrudDao;
import com.sapling.common.persistence.annotation.MyBatisDao;
import com.sapling.modules.annotation.entity.Annotation;

/**
 * 注释DAO接口
 * @author llz
 * @version 2017-01-24
 */
@MyBatisDao
public interface AnnotationDao extends CrudDao<Annotation> {

	/**
	 * 功能: 通过报价单明细Id, 查询对应的商品注释
	 * 作者: 刘张学
	 * @param detailIds
	 * @return
	 */
	public List<Annotation> getListByDetailIds(Map<String, Object> map);

	/**
	 * 功能: 通过报价单号, 删除商品注释
	 * 作者: 刘张学
	 * @param quotationCode
	 * @return
	 */
	int deleteByQuotationCode(String quotationCode);

	/**
	 * 分页查询商品注释
	 * @param anno
	 * @return
	 */
	public List<Annotation> findPageList(Annotation anno);
}
