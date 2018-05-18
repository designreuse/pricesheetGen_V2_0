/**
 */
package com.sapling.modules.product.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sapling.common.persistence.Page;
import com.sapling.common.service.CrudService;
import com.sapling.modules.product.dao.ProdModelDao;
import com.sapling.modules.product.entity.ProdModel;

/**
 * 注释Service
 * @author llz
 * @version 2017-01-24
 */
@Service
@Transactional(readOnly = true)
public class ProdModelService extends CrudService<ProdModelDao, ProdModel> {

	@Autowired
	private ProdModelDao modelDao;
	
	public ProdModel get(String id) {
		return super.get(id);
	}
	
	public List<ProdModel> findList(ProdModel anno) {
		return super.findList(anno);
	}
	
	public Page<ProdModel> findPage(Page<ProdModel> page, ProdModel anno) {
		anno.setPage(page);
		page.setList(modelDao.findPageList(anno));
		return page;
	}
	
	@Transactional(readOnly = false)
	public void save(ProdModel anno) {
		super.save(anno);
	}
	
	@Transactional(readOnly = false)
	public void delete(ProdModel anno) {
		super.delete(anno);
	}

	public List<ProdModel> listByBrandId(String brandId) {
		return modelDao.listByBrandId(brandId);
	}

	public List<ProdModel> findModelByProductId(String productId) {
		return modelDao.findModelByProductId(productId);
	}

	public List<ProdModel> findProdModelByClassfiyId(String brandId, String classfiyId) {
		return modelDao.findProdModelByClassfiyId(brandId,classfiyId);
	}

	public ProdModel findModelByModelId(String modelId) {
		return modelDao.findModelByModelId(modelId);
	}

	@Transactional(readOnly = false)
	public void updateModel(ProdModel models) {
		modelDao.updateModel(models);
	}

	public List<ProdModel> findModelByBIdAndCIdAndPId(String brandId, String classfiyId, String productId) {
		return modelDao.findModelByBIdAndCIdAndPId(brandId,classfiyId,productId);
	}

	public List<ProdModel> findModelByBrandId(String brandId) {
		return modelDao.findModelByBrandId(brandId);
	}

	public List<ProdModel> findAllList(ProdModel prodModel) {
		return modelDao.findAllList(prodModel);
	}

	public List<ProdModel> findListByProduct(String productId) {
		return modelDao.findListByProduct(productId);
	}

	public String findMaxProdModelId() {
		return modelDao.findMaxProdModelId();
	}
	
	@Transactional(readOnly = false)
	public void saveProdModel(ProdModel prodModel) {
		prodModel.preInsert();
		modelDao.insert(prodModel);
	}
	
	@Transactional(readOnly = false)
	public void updateProdModel(ProdModel prodModel) {
		prodModel.preUpdate();
		modelDao.update(prodModel);
	}

	@Transactional(readOnly = false)
	public void deleteModel(ProdModel prodModel) {
		modelDao.delete(prodModel);
		modelDao.deleteProdModel(prodModel);
	}
	public ProdModel getModelByName(String modelName){
		return modelDao.getModelByName(modelName);
	}

}
