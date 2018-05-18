package com.sapling.modules.product.dao;

import java.util.List;

import com.sapling.common.persistence.CrudDao;
import com.sapling.common.persistence.annotation.MyBatisDao;
import com.sapling.modules.product.entity.Product;
import com.sapling.modules.product.entity.ProductImp;

/**
 * 注释DAO接口
 * @author llz
 * @version 2017-01-24
 */
@MyBatisDao
public interface ProductImpDao extends CrudDao<ProductImp> {
	public List<ProductImp> findPageList(ProductImp anno);

}
