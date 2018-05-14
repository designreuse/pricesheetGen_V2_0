/**
 * Copyright &copy; 2015-2020 <a href="http://www.SapLing.org/">SapLing</a> All rights reserved.
 */
package com.sapling.modules.iim.dao;

import com.sapling.common.persistence.CrudDao;
import com.sapling.common.persistence.annotation.MyBatisDao;
import com.sapling.modules.iim.entity.LayGroup;

/**
 * 群组DAO接口
 * @author lgf
 * @version 2016-08-07
 */
@MyBatisDao
public interface LayGroupDao extends CrudDao<LayGroup> {

	
}