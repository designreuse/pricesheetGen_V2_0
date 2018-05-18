/**
 */
package com.sapling.modules.product.service;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sapling.common.persistence.Page;
import com.sapling.common.service.CrudService;
import com.sapling.modules.product.dao.ProductImpDao;
import com.sapling.modules.product.entity.Product;
import com.sapling.modules.product.entity.ProductImp;

/**
 * 注释Service
 * @author llz
 * @version 2017-01-24
 */
@Service
@Transactional(readOnly = true)
public class ProductImpService extends CrudService<ProductImpDao, ProductImp> {

	@Autowired
	private ProductImpDao productImpDao;

	public Page<ProductImp> findPage(Page<ProductImp> page, ProductImp anno) {
		anno.setPage(page);
		page.setList(productImpDao.findPageList(anno));
		return page;
	}
	
	
}
