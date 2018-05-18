/**
 */
package com.sapling.modules.annotation.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sapling.common.persistence.Page;
import com.sapling.common.service.CrudService;
import com.sapling.modules.annotation.dao.AnnotationDao;
import com.sapling.modules.annotation.entity.Annotation;
import com.sapling.modules.annotation.entity.AnnotationsVo;
import com.sapling.modules.product.dao.ProdBrandDao;
import com.sapling.modules.product.dao.ProdClassfiyDao;
import com.sapling.modules.product.dao.ProdModelDao;
import com.sapling.modules.product.dao.ProductDao;
import com.sapling.modules.product.dao.ProductImpDao;
import com.sapling.modules.product.entity.ProdBrand;
import com.sapling.modules.product.entity.ProdClassfiy;
import com.sapling.modules.product.entity.ProdModel;
import com.sapling.modules.product.entity.Product;
import com.sapling.modules.product.entity.ProductImp;
import com.sapling.modules.quotation.dao.QuotationOrderDetailDao;
import com.sapling.modules.quotation.entity.QuotationOrder;
import com.sapling.modules.quotation.entity.QuotationOrderDetail;

import sun.java2d.pipe.AATextRenderer;

/**
 * 注释Service
 * @author llz
 * @version 2017-01-24
 */
@Service
@Transactional(readOnly = true)
public class AnnotationService extends CrudService<AnnotationDao, Annotation> {

	@Autowired
	private AnnotationDao annotationDao;
	
	@Autowired
	private ProductDao productDao;
	
	@Autowired
	private ProdBrandDao brandDao;
	
	@Autowired
	private ProdClassfiyDao classfiyDao;
	
	@Autowired
	private ProdModelDao modelDao;
	
	@Autowired
	private QuotationOrderDetailDao orderDetailDao;
	
	@Autowired
	private ProductImpDao productImpDao;
	
	public Annotation get(String id) {
		return super.get(id);
	}
	
	public List<Annotation> findList(Annotation anno) {
		return super.findList(anno);
	}
	
	public Page<Annotation> findPage(Page<Annotation> page, Annotation anno) {
		anno.setPage(page);
		page.setList(annotationDao.findPageList(anno));
		return page;
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
	public void saveList(AnnotationsVo annotationsVo) {
		 // 删除原有的商品注释
		dao.deleteByQuotationCode(annotationsVo.getQuotationCode());
		// 保存商品注释
		List<Annotation> annotationList=annotationsVo.getAnnotations();
		for (Annotation a : annotationList) {
			a.setQuotationCode(annotationsVo.getQuotationCode());
			a.preInsert();
			annotationDao.insert(a);
		}
		
		List<ProductImp> productImps=new ArrayList<ProductImp>();
		for (Annotation a : annotationList) {
			ProductImp imp=new ProductImp();
			QuotationOrderDetail detail= orderDetailDao.get(new QuotationOrderDetail(a.getDetailId()));
			Product product= productDao.getProductByName(detail.getProductName());
			if(product!=null && !product.getProductName().equals("")){
				if(a.getClassfiyName()==null || a.getClassfiyName().equals("")){
					product.setClassfiys(new ArrayList<ProdClassfiy>());
				}else{
					ProdClassfiy classfiy=classfiyDao.getClassfiyByName(a.getClassfiyName());
					if(classfiy!=null && !classfiy.getProdClassfiyName().equals("")){
						List<ProdClassfiy> classfiys=new ArrayList<ProdClassfiy>();
						classfiys.add(classfiy);
						product.setClassfiys(classfiys);
					}else{
						imp.setClassfiy(a.getClassfiyName());
					}
				}
				ProdBrand brand= brandDao.getBrandByName(a.getAnnoName());
				if(brand!=null && !brand.getBrandName().equals("")){
					List<ProdBrand> brands=new ArrayList<ProdBrand>();
					brands.add(brand);
					product.setBrands(brands);
				}else{
					imp.setBrand(a.getAnnoName());
				}
				
				ProdModel prodModel=modelDao.getModelByName(a.getAnnoType());
				if(prodModel!=null && !prodModel.getModelName().equals("")){
					List<ProdModel> models=new ArrayList<ProdModel>();
					models.add(prodModel);
					product.setModels(models);
				}else{
					imp.setModel(a.getAnnoType());
				}
				
				if(imp.getClassfiy()!=null || imp.getBrand()!=null || imp.getModel()!=null){
					imp.setpId(product.getProductId());
					imp.setpName(detail.getProductName());
					imp.setClassfiy(a.getClassfiyName());
					imp.setBrand(a.getAnnoName());
					imp.setModel(a.getAnnoType());
					productImps.add(imp);
				}else{
					product.preUpdate();
					productDao.update(product);
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
			}else{
				product= new Product();
				product.setProductName(detail.getProductName());
				product.setProductId(creatProductId());
				if(a.getClassfiyName()==null || a.getClassfiyName().equals("")){
					product.setClassfiys(new ArrayList<ProdClassfiy>());
				}else{
					ProdClassfiy classfiy=classfiyDao.getClassfiyByName(a.getClassfiyName());
					if(classfiy!=null && !classfiy.getProdClassfiyName().equals("")){
						List<ProdClassfiy> classfiys=new ArrayList<ProdClassfiy>();
						classfiys.add(classfiy);
						product.setClassfiys(classfiys);
					}else{
						imp.setClassfiy(a.getClassfiyName());
					}
				}
				ProdBrand brand= brandDao.getBrandByName(a.getAnnoName());
				if(brand!=null && !brand.getBrandName().equals("")){
					List<ProdBrand> brands=new ArrayList<ProdBrand>();
					brands.add(brand);
					product.setBrands(brands);
				}else{
					imp.setBrand(a.getAnnoName());
				}
				
				ProdModel prodModel=modelDao.getModelByName(a.getAnnoType());
				if(prodModel!=null && !prodModel.getModelName().equals("")){
					List<ProdModel> models=new ArrayList<ProdModel>();
					models.add(prodModel);
					product.setModels(models);
				}else{
					imp.setModel(a.getAnnoType());
				}
				
				if(imp.getClassfiy()!=null || imp.getBrand()!=null || imp.getModel()!=null){
					imp.setpId(product.getProductId());
					imp.setpName(detail.getProductName());
					imp.setClassfiy(a.getClassfiyName());
					imp.setBrand(a.getAnnoName());
					imp.setModel(a.getAnnoType());
					productImps.add(imp);
				}else{
					product.preInsert();
					productDao.insert(product);
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
			
		}
		for (ProductImp productImp : productImps) {
			productImpDao.delete(productImp);
			productImp.preInsert();
			productImp.setDelStatus("0");
			productImpDao.insert(productImp);
		}
	}
	private String creatProductId(){
		String maxProductId= productDao.findMaxProductId();
		if(maxProductId==null || maxProductId==""){
			return "PRO-0000000000001";
		}else{
		    String str = String.format("%013d", Integer.parseInt(maxProductId)+1);
		    return "PRO-"+str;
		}
	}
}
