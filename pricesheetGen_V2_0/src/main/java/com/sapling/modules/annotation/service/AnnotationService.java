/**
 */
package com.sapling.modules.annotation.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sapling.common.persistence.Page;
import com.sapling.common.service.CrudService;
import com.sapling.modules.annotation.dao.AnnotationDao;
import com.sapling.modules.annotation.entity.Annotation;
import com.sapling.modules.quotation.entity.QuotationOrder;
import com.sapling.modules.quotation.entity.QuotationOrderDetail;

/**
 * 注释Service
 * @author llz
 * @version 2017-01-24
 */
@Service
@Transactional(readOnly = true)
public class AnnotationService extends CrudService<AnnotationDao, Annotation> {

	public Annotation get(String id) {
		return super.get(id);
	}
	
	public List<Annotation> findList(Annotation anno) {
		return super.findList(anno);
	}
	
	public Page<Annotation> findPage(Page<Annotation> page, Annotation anno) {
		return super.findPage(page, anno);
	}
	
	@Transactional(readOnly = false)
	public void save(Annotation anno) {
		super.save(anno);
	}
	
	@Transactional(readOnly = false)
	public void delete(Annotation anno) {
		super.delete(anno);
	}

	/**
	 * 功能: 使用报价单明细Id, 查询注释
	 * 作者: 刘张学
	 * 
	 */
	public List<Annotation> getListByDetailIds(QuotationOrder quotationCode, List<Long> detailIds) {

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", detailIds);
		map.put("quotationCode", quotationCode.getQuotationCode());

		List<Annotation> detailList = dao.getListByDetailIds(map);
		return detailList;		
	}
	
	/**
	 * 功能: 按照报价单明细的uid, 为报价单明细绑定注释
	 * 作者: 刘张学
	 * 
	 */
	public void bindAnnotation2OrderDetail(List<QuotationOrderDetail> detailList,  List<Annotation> annotationList) {
		
		for (QuotationOrderDetail d : detailList) {  // 将注释按照uid分类
		 
			for (Annotation a : annotationList) { // 产品注释

				if (a.getDetailId().equals((d.getUid()))) { // 产品注释归属绑定
					List<Annotation> aList = d.getAnnotation();
					if (null == aList) {
						aList = new ArrayList<Annotation>();
						d.setAnnotation(aList);
					}
					
					// 绑定
					aList.add(a);
				}				
			}
		}
	}
	
	
	/**
	 * 功能: 保存同一报价单号的商品注释列表
	 * 作者: 刘张学
	 * 
	 */	
	@Transactional(readOnly = false)
	public void saveList(List<Annotation> annotationList) {

		 // 删除原有的商品注释
		Annotation aDel = annotationList.get(0);
		dao.deleteByQuotationCode(aDel.getQuotationCode());

		// 保存商品注释
		for (Annotation a : annotationList) {
			super.save(a);
		}
	}
}
