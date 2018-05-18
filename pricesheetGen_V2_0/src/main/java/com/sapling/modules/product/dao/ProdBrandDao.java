package com.sapling.modules.product.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.sapling.common.persistence.CrudDao;
import com.sapling.common.persistence.annotation.MyBatisDao;
import com.sapling.modules.product.entity.ProdBrand;

/**
 * 注释DAO接口
 * @author llz
 * @version 2017-01-24
 */
@MyBatisDao
public interface ProdBrandDao extends CrudDao<ProdBrand> {

	/**
	 * 分页查询商品注释
	 * @param anno
	 * @return
	 */
	public List<ProdBrand> findPageList(ProdBrand anno);

	public List<ProdBrand> findListByProduct(String productId);

	public List<ProdBrand> findProdBrandByClassfiyId(String classfiyId);

	public ProdBrand findProdBrandByBrandId(String brandId);

	public String findMaxProdBrandId();

	public void deleteProdBrand(ProdBrand prodBrand);

	public ProdBrand getBrandByName(@Param("brandName")String annoName);
}
