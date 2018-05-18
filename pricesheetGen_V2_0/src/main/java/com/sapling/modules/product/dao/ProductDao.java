package com.sapling.modules.product.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.sapling.common.persistence.CrudDao;
import com.sapling.common.persistence.annotation.MyBatisDao;
import com.sapling.modules.product.entity.Product;

/**
 * 注释DAO接口
 * @author llz
 * @version 2017-01-24
 */
@MyBatisDao
public interface ProductDao extends CrudDao<Product> {
	public List<Product> findPageList(Product anno);

	public String findMaxProductId();

	public int insetProdBrand(Product product);

	public void insetProdClassfiy(Product product);

	public void insetProdModel(Product product);

	public void deleteProdClassfiy(Product product);

	public void deleteProdBrand(Product product);

	public void deleteProdModel(Product product);

	public Product getProductByName(@Param("productName")String productName);
}
