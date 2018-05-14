/**
 * Copyright &copy; 2015-2020 <a href="http://www.sapling.org/">sapling</a> All rights reserved.
 */
package com.sapling.modules.quotation.dao;

import java.util.List;

import com.sapling.common.persistence.CrudDao;
import com.sapling.common.persistence.annotation.MyBatisDao;
import com.sapling.modules.quotation.entity.QuotationOrderDetail;

/**
 * 报价单明细DAO接口
 * @author cth
 * @version 2017-01-25
 */
@MyBatisDao
public interface QuotationOrderDetailDao extends CrudDao<QuotationOrderDetail> {

	/**
	 * 删除报价单明细
	 * @param quotationCode
	 * @return
	 */
	int deleteByQuotCode(String quotationCode);
	
	/**
	 * 主表id 查询字表详情信息
	 * @param orderId
	 * @return
	 */
	List<QuotationOrderDetail> selectByQuotId(String orderId);
}