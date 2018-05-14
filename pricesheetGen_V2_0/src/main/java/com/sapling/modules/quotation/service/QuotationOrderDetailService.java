/**
 * Copyright &copy; 2015-2020 <a href="http://www.sapling.org/">sapling</a> All rights reserved.
 */
package com.sapling.modules.quotation.service;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sapling.common.persistence.Page;
import com.sapling.common.service.CrudService;
import com.sapling.modules.quotation.entity.QuotationOrder;
import com.sapling.modules.quotation.entity.QuotationOrderDetail;
import com.sapling.modules.quotation.utils.QuotationComparator;
import com.sapling.modules.quotation.dao.QuotationOrderDetailDao;

/**
 * 报价单明细Service
 * @author cth
 * @version 2017-01-25
 */
@Service
@Transactional(readOnly = true)
public class QuotationOrderDetailService extends CrudService<QuotationOrderDetailDao, QuotationOrderDetail> {

	public QuotationOrderDetail get(String id) {
		return super.get(id);
	}
	
	public List<QuotationOrderDetail> findList(QuotationOrderDetail quotationOrderDetail) {
		return super.findList(quotationOrderDetail);
	}
	
	public Page<QuotationOrderDetail> findPage(Page<QuotationOrderDetail> page, QuotationOrderDetail quotationOrderDetail) {
		return super.findPage(page, quotationOrderDetail);
	}
	
	@Transactional(readOnly = false)
	public void save(QuotationOrderDetail quotationOrderDetail) {
		super.save(quotationOrderDetail);
	}
	
	@Transactional(readOnly = false)
	public void delete(QuotationOrderDetail quotationOrderDetail) {
		super.delete(quotationOrderDetail);
	}
	
	public Page<String> findPageByquotationCode(Page<String> page, String quotationCode) {
//		quotationCode.setPage(page);
		return page;
	}

	/**
	 * author  : liuzhangxue
	 * add date: 2017-02-06
	 * function: 使用报价单号查询报价单明细
	 */
	public List<QuotationOrderDetail> getQuotationOrderDetails(QuotationOrder quotationOrder) {

		// 查明细
		List<QuotationOrderDetail> detailList = dao.selectByQuotId(quotationOrder.getId());

		// 排序
		QuotationComparator qc = new QuotationComparator();
		Collections.sort(detailList, qc);

		return detailList;
	}
	
	
	/**
	 * author  : liuzhangxue
	 * add date: 2017-02-06
	 * function: 获取报价单明细对应的Id列表
	 */	
	public List<Long> getQuotationOrderDetailIds(List<QuotationOrderDetail> detailList) {

		// 获取明细的ID
		List<Long> idList = new ArrayList<Long>();
		for (QuotationOrderDetail d : detailList) {
			idList.add(d.getUid());
		}

		return idList;
	}	


	/**
	 * author  : liuzhangxue
	 * add date: 2017-02-04
	 * function: 使用报价单产品类型对报价单明细进行排序
	 */
	public void sortQuotationOrderDetails(QuotationOrder quotationOrder) {
		QuotationComparator qc = new QuotationComparator();
		List<QuotationOrderDetail> quotationOrderDetails = quotationOrder.getQuotationOrderDetails();
		Collections.sort(quotationOrderDetails, qc);
		quotationOrder.setQuotationOrderDetails(quotationOrderDetails);		
	}
}