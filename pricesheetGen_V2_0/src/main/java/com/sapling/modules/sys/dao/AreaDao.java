/**
 * Copyright &copy; 2015-2020 <a href="http://www.SapLing.org/">SapLing</a> All rights reserved.
 */
package com.sapling.modules.sys.dao;

import com.sapling.common.persistence.TreeDao;
import com.sapling.common.persistence.annotation.MyBatisDao;
import com.sapling.modules.sys.entity.Area;

/**
 * 区域DAO接口
 * @author SapLing
 * @version 2014-05-16
 */
@MyBatisDao
public interface AreaDao extends TreeDao<Area> {
	
}
