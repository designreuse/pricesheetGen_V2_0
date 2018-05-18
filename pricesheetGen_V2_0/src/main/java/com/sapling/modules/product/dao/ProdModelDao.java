package com.sapling.modules.product.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.sapling.common.persistence.CrudDao;
import com.sapling.common.persistence.annotation.MyBatisDao;
import com.sapling.modules.product.entity.ProdModel;

/**
 * 注释DAO接口
 * @author llz
 * @version 2017-01-24
 */
@MyBatisDao
public interface ProdModelDao extends CrudDao<ProdModel> {

	public List<ProdModel> findPageList(ProdModel anno);

	public List<ProdModel> listByBrandId(String brandId);

	public List<ProdModel> findModelByProductId(String productId);

	public List<ProdModel> findProdModelByClassfiyId(@Param("brandId")String brandId, @Param("classfiyId")String classfiyId);

	public ProdModel findModelByModelId(String modelId);

	public void updateModel(ProdModel models);

	public List<ProdModel> findModelByBIdAndCIdAndPId(@Param("brandId")String brandId, @Param("classfiyId")String classfiyId, @Param("productId")String productId);

	public List<ProdModel> findModelByBrandId(@Param("brandId")String brandId);

	public List<ProdModel> findListByProduct(@Param("productId")String productId);

	public String findMaxProdModelId();

	public void deleteProdModel(ProdModel prodModel);

	public ProdModel getModelByName(@Param("modelName")String annoType);

}
