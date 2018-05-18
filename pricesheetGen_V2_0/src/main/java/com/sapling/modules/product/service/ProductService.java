/**
 */
package com.sapling.modules.product.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sapling.common.persistence.Page;
import com.sapling.common.service.CrudService;
import com.sapling.common.utils.StringUtils;
import com.sapling.modules.product.dao.ProdModelDao;
import com.sapling.modules.product.dao.ProductDao;
import com.sapling.modules.product.dao.ProductImpDao;
import com.sapling.modules.product.entity.ProdModel;
import com.sapling.modules.product.entity.Product;
import com.sapling.modules.sys.entity.Role;
import com.sapling.modules.sys.utils.UserUtils;

/**
 * 注释Service
 * @author llz
 * @version 2017-01-24
 */
@Service
@Transactional(readOnly = true)
public class ProductService extends CrudService<ProductDao, Product> {

	@Autowired
	private ProductDao productDao;

	@Autowired
	private ProductImpDao productImpDao;
	
	public Product get(String id) {
		return super.get(id);
	}
	
	public List<Product> findList(Product product) {
		return super.findList(product);
	}
	
	public Page<Product> findPage(Page<Product> page, Product anno) {
		anno.setPage(page);
		page.setList(productDao.findPageList(anno));
		return page;
	}
	
	@Transactional(readOnly = false)
	public void save(Product product) {
		super.save(product);
		productDao.insetProdBrand(product);
	}
	
	@Transactional(readOnly = false)
	public void delete(Product anno) {
		super.delete(anno);
	}

	public String findMaxProductId() {
		return productDao.findMaxProductId();
	}
	
	@Transactional(readOnly = false)
	public void saveProduct(Product product) {
		product.preInsert();
		int a=productDao.insert(product);
		
		if(a>0){
			if(product.getBrands().size()>0){
				productDao.insetProdBrand(product);
			}
			if(product.getClassfiys().size()>0){
				productDao.insetProdClassfiy(product);
			}
			if(product.getModels().size()>0){
				productDao.insetProdModel(product);
			}
		}
		
	}
	
	@Transactional(readOnly = false)
	public void updateProduct(Product product) {
		product.preUpdate();
		int a=productDao.update(product);
		if(a>0){
			productDao.deleteProdClassfiy(product);
			productDao.deleteProdBrand(product);
			productDao.deleteProdModel(product);
			if(product.getBrands().size()>0){
				productDao.insetProdBrand(product);
			}
			if(product.getClassfiys().size()>0){
				productDao.insetProdClassfiy(product);
			}
			if(product.getModels().size()>0){
				productDao.insetProdModel(product);
			}
		}
	}

	@Transactional(readOnly = false)
	public void deleteProduct(Product product) {
		productDao.delete(product);
		productDao.deleteProdClassfiy(product);
		productDao.deleteProdBrand(product);
		productDao.deleteProdModel(product);
	}
}
