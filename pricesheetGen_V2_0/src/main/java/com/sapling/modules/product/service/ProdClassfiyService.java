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
import com.sapling.modules.product.dao.ProdClassfiyDao;
import com.sapling.modules.product.dao.ProdModelDao;
import com.sapling.modules.product.dao.ProductDao;
import com.sapling.modules.product.entity.ProdClassfiy;
import com.sapling.modules.product.entity.ProdModel;
import com.sapling.modules.product.entity.Product;

/**
 * 注释Service
 * @author llz
 * @version 2017-01-24
 */
@Service
@Transactional(readOnly = true)
public class ProdClassfiyService extends CrudService<ProdClassfiyDao, ProdClassfiy> {

	@Autowired
	private ProdClassfiyDao productDao;

	@Autowired
	private ProdModelDao modelDao;
	
	
	public ProdClassfiy get(String id) {
		return super.get(id);
	}
	
	public  List<ProdClassfiy> getByBrandIds(List<String>  brandIds) {
		return productDao.getByBrandIds(brandIds);
	}
	
	public List<ProdClassfiy> findList(ProdClassfiy product) {
		return super.findList(product);
	}
	
	public Page<ProdClassfiy> findPage(Page<ProdClassfiy> page, ProdClassfiy classfiy) {
		classfiy.setPage(page);
		page.setList(productDao.findPageList(classfiy));
		return page;
	}
	
	@Transactional(readOnly = false)
	public void save(ProdClassfiy anno) {
		super.save(anno);
	}
	
	@Transactional(readOnly = false)
	public void delete(ProdClassfiy anno) {
		super.delete(anno);
	}

	public ProdClassfiy getByBrandIdsAndModel(List<String> list,String productId) {
		return productDao.getByBrandIdsAndModel(list,productId);
	}

	public String findMaxProdClassfiyId() {
		return productDao.findMaxProdClassfiyId();
	}

	@Transactional(readOnly = false)
	public void saveProdClassfiy(ProdClassfiy classfiy) {
		classfiy.preInsert();
		productDao.insert(classfiy);
	}

	public List<ProdClassfiy> findClassfiyByBrandId(String brandId) {
		return productDao.findClassfiyByBrandId(brandId);
	}

	public List<ProdClassfiy> findListByProduct(String productId) {
		return productDao.findListByProduct(productId);
	}
	
	@Transactional(readOnly = false)
	public void updateProdClassfiy(ProdClassfiy classfiy) {
		classfiy.preUpdate();
		productDao.update(classfiy);
	}

	@Transactional(readOnly = false)
	public void deleteProdClassfiy(ProdClassfiy prodClassfiy) {
		productDao.delete(prodClassfiy);
		productDao.deleteProdClassfiy(prodClassfiy);
	}
	
	public ProdClassfiy getClassfiyByName(String classfiyName){
		return productDao.getClassfiyByName(classfiyName);
	}

}
