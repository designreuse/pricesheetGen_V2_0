package com.sapling.modules.product.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.sapling.common.persistence.CrudDao;
import com.sapling.common.persistence.annotation.MyBatisDao;
import com.sapling.modules.product.entity.ProdClassfiy;
import com.sapling.modules.product.entity.Product;

/**
 * 注释DAO接口
 * @author llz
 * @version 2017-01-24
 */
@MyBatisDao
public interface ProdClassfiyDao extends CrudDao<ProdClassfiy> {
	public List<ProdClassfiy> findPageList(ProdClassfiy classfiy);
	
	public List<ProdClassfiy> getByBrandIds(List<String>  brandIds);

	public ProdClassfiy getByBrandIdsAndModel(@Param("list")List<String> list,@Param("productId")String productId);

	public String findMaxProdClassfiyId();

	public void insetClassfiyBrand(ProdClassfiy classfiy);

	public List<ProdClassfiy> findClassfiyByBrandId(@Param("brandId")String brandId);

	public List<ProdClassfiy> findListByProduct(@Param("productId")String productId);

	public void deleteProdClassfiy(ProdClassfiy prodClassfiy);

	public ProdClassfiy getClassfiyByName(@Param("classfiyName")String classfiyName);
}
