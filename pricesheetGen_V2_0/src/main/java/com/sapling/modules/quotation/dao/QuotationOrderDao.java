/**
 * Copyright &copy; 2015-2020 <a href="http://www.jeeplus.org/">JeePlus</a> All rights reserved.
 */
package com.sapling.modules.quotation.dao;

import com.sapling.common.persistence.CrudDao;
import com.sapling.common.persistence.annotation.MyBatisDao;
import com.sapling.modules.quotation.entity.QuotationOrder;

/**
 * 报价单DAO接口
 * @author cth
 * @version 2017-01-24
 */
@MyBatisDao
public interface QuotationOrderDao extends CrudDao<QuotationOrder> {

	/**
	 * 获取当前销售当天的报价数量
	 * @param staffCode
	 * @return
	 */
	int selectStaffCurCount(String staffCode);
	
	/**
	 * 更新报价单号
	 * @param order
	 * @return
	 */
	int updateByQuotCodeWithId(QuotationOrder order);
	
}