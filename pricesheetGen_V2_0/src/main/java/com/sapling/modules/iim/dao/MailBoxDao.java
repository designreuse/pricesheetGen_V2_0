/**
 * Copyright &copy; 2015-2020 <a href="http://www.SapLing.org/">SapLing</a> All rights reserved.
 */
package com.sapling.modules.iim.dao;

import com.sapling.common.persistence.CrudDao;
import com.sapling.common.persistence.annotation.MyBatisDao;
import com.sapling.modules.iim.entity.MailBox;

/**
 * 发件箱DAO接口
 * @author SapLing
 * @version 2015-11-15
 */
@MyBatisDao
public interface MailBoxDao extends CrudDao<MailBox> {
	
	public int getCount(MailBox entity);
	
}