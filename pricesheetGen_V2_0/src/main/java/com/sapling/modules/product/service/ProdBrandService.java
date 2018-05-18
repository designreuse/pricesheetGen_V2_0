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
import com.sapling.modules.product.dao.ProdBrandDao;
import com.sapling.modules.product.entity.ProdBrand;
import com.sapling.modules.product.entity.Product;

/**
 * 注释Service
 * @author llz
 * @version 2017-01-24
 */
@Service
@Transactional(readOnly = true)
public class ProdBrandService extends CrudService<ProdBrandDao, ProdBrand> {

	@Autowired
	private ProdBrandDao brandDao;
	
	public ProdBrand get(String id) {
		return super.get(id);
	}
	
	public List<ProdBrand> findList(ProdBrand anno) {
		return super.findList(anno);
	}
	
	public List<ProdBrand> findListByProduct(String productId) {
		return brandDao.findListByProduct(productId);
	}
	
	
	public Page<ProdBrand> findPage(Page<ProdBrand> page, ProdBrand anno) {
		anno.setPage(page);
		page.setList(brandDao.findPageList(anno));
		return page;
	}
	
	@Transactional(readOnly = false)
	public void save(ProdBrand anno) {
		super.save(anno);
	}
	
	@Transactional(readOnly = false)
	public void delete(ProdBrand anno) {
		super.delete(anno);
	}

	public List<ProdBrand> findAllList(ProdBrand prodBrand) {
		return brandDao.findAllList(prodBrand);
	}

	public List<ProdBrand> findProdBrandByClassfiyId(String classfiyId) {
		return brandDao.findProdBrandByClassfiyId(classfiyId);
	}

	public ProdBrand findProdBrandByBrandId(String brandId) {
		return brandDao.findProdBrandByBrandId(brandId);
	}

	public String findMaxProdBrandId() {
		return brandDao.findMaxProdBrandId();
	}
	@Transactional(readOnly = false)
	public void saveProdBrand(ProdBrand brand) {
		brand.preInsert();
		brandDao.insert(brand);
	}
	
	@Transactional(readOnly = false)
	public void updateProdBrand(ProdBrand brand) {
		brand.preUpdate();
		brandDao.update(brand);
	}

	@Transactional(readOnly = false)
	public void deleteBrand(ProdBrand prodBrand) {
		brandDao.delete(prodBrand);
		brandDao.deleteProdBrand(prodBrand);
	}
	public ProdBrand getBrandByName(String modelName){
		return brandDao.getBrandByName(modelName);
	}

}
