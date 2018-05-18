package com.sapling.modules.product.web;



import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.Logical;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.sapling.common.config.Global;
import com.sapling.common.persistence.Page;
import com.sapling.common.web.BaseController;
import com.sapling.modules.product.entity.ProdBrand;
import com.sapling.modules.product.entity.ProdClassfiy;
import com.sapling.modules.product.entity.ProdModel;
import com.sapling.modules.product.entity.Product;
import com.sapling.modules.product.entity.ProductImp;
import com.sapling.modules.product.service.ProdBrandService;
import com.sapling.modules.product.service.ProdClassfiyService;
import com.sapling.modules.product.service.ProdModelService;
import com.sapling.modules.product.service.ProductImpService;
import com.sapling.modules.product.service.ProductService;

/**
 * 注释Controller
 * @author llz
 * @version 2017-01-24
 */
@Controller
@RequestMapping(value = "${adminPath}/product/productImp")
public class ProductImpController extends BaseController {
 
	@Autowired
	private ProductImpService productImpService ; 
	
	@Autowired
	private ProdBrandService  brandService;
	@Autowired
	private ProdClassfiyService classfiyService;
	@Autowired
	private ProdModelService modelService;
	
	@Autowired
	private ProductService productService;
	
	private SimpleDateFormat sdfFolder = new SimpleDateFormat("yyyyMMdd");
	
	/**
	 * 商品列表页面
	 */
	@RequiresPermissions("product:productImp:list")
	@RequestMapping(value = {"list", ""})
	public String list(ProductImp product, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<ProductImp> page = productImpService.findPage(new Page<ProductImp>(request, response), product); 
		model.addAttribute("page", page);
		return "modules/product/productImpList";
	}
	
	@RequiresPermissions(value={"product:productImp:add"},logical=Logical.OR)
	@RequestMapping(value = "addFrom")
	public String addFrom(ProductImp product,Model model) {
		//查询所有的商品类型
		ProductImp productImp=productImpService.get(product.getId());
		model.addAttribute("productImp", productImp);
		return "modules/product/productImpAdd";
	}
	
	/**
	 * 删除临时商品
	 */
	@RequiresPermissions("product:productImp:del")
	@RequestMapping(value = "delete")
	public String delete(ProductImp product, RedirectAttributes redirectAttributes) {
		productImpService.delete(productImpService.get(product.getId()));
		addMessage(redirectAttributes, "删除临时商品成功");
		return "redirect:"+Global.getAdminPath()+"/product/productImp/?repage";
	}
	
	/**
	 * 批量删除临时商品
	 */
	@RequiresPermissions("product:productImp:del")
	@RequestMapping(value = "deleteAll")
	public String deleteAll(String ids, RedirectAttributes redirectAttributes) {
		String idArray[] =ids.split(",");
		for(String id : idArray){
			productImpService.delete(productImpService.get(id));
		}
		addMessage(redirectAttributes, "删除临时商品成功");
		return "redirect:"+Global.getAdminPath()+"/product/productImp/list?repage";
	}
	
	

	@RequiresPermissions(value={"product:productImp:add"},logical=Logical.OR)
	@RequestMapping(value = {"AddProduct"}, method = {RequestMethod.POST})
	public String save(ProductImp productImp,Model model, RedirectAttributes redirectAttributes) throws Exception{
		Product product=new Product();
		product.setProductName(productImp.getpName());
		if(productImp.getpId()!=null && !productImp.getpId().equals("")){
			product.setProductId(productImp.getpId());
		}else{
			product.setProductId(creatProductId());
		}
		
		List<ProdClassfiy> classfiys=new ArrayList<ProdClassfiy>();
		if(productImp.getClassfiy()!=null && !productImp.getClassfiy().equals("")){
			ProdClassfiy classfiy= classfiyService.getClassfiyByName(productImp.getClassfiy());
			if(classfiy!=null && !classfiy.getProdClassfiyName().equals("")){
				classfiys.add(classfiy);
				product.setClassfiys(classfiys);
			}else{
				ProdClassfiy classfiy2=new ProdClassfiy();
				classfiy2.setProdClassfiyId(creatProdClassfiyId());
				classfiy2.setProdClassfiyName(productImp.getClassfiy());
				classfiyService.saveProdClassfiy(classfiy2);
				classfiys.add(classfiyService.getClassfiyByName(productImp.getClassfiy()));
				product.setClassfiys(classfiys);
			}
		}else{
			classfiys.add(new ProdClassfiy());
			product.setClassfiys(classfiys);
		}
		
		List<ProdBrand> brands=new ArrayList<ProdBrand>();
		if(productImp.getBrand()!=null && !productImp.getBrand().equals("")){
			ProdBrand brand= brandService.getBrandByName(productImp.getBrand());
			if(brand!=null && !brand.getBrandName().equals("")){
				brands.add(brand);
				product.setBrands(brands);
			}else{
				ProdBrand brand2=new ProdBrand();
				brand2.setBrandId(creatProdBrandId());
				brand2.setBrandName(productImp.getBrand());
				brandService.saveProdBrand(brand2);
				brands.add(brandService.getBrandByName(productImp.getBrand()));
				product.setBrands(brands);
			}
		}else{
			brands.add(new ProdBrand());
			product.setBrands(brands);
		}
		
		List<ProdModel> models=new ArrayList<ProdModel>();
		if(productImp.getModel()!=null && !productImp.getModel().equals("")){
			ProdModel prodModel=modelService.getModelByName(productImp.getModel());
			if(prodModel!=null && !prodModel.getModelName().equals("")){
				models.add(prodModel);
				product.setModels(models);
			}else{
				ProdModel prodModel2=new ProdModel();
				prodModel2.setModelId(creatProdModelId());
				prodModel2.setModelName(productImp.getModel());
				modelService.saveProdModel(prodModel2);
				models.add(modelService.getModelByName(productImp.getModel()));
				product.setModels(models);
			}
		}else{
			models.add(new ProdModel());
			product.setModels(models);
		}
		
		if(productImp.getpId()!=null && !productImp.getpId().equals("")){
			productService.updateProduct(product);
		}else{
			productService.saveProduct(product);
		}
		productImpService.delete(productImp);
		addMessage(redirectAttributes, "录入商品'" + product.getProductName() + "'成功");
		return "redirect:"+Global.getAdminPath()+"/product/productImp/list/?repage";
	}
	
	private String creatProductId(){
		String maxProductId= productService.findMaxProductId();
		if(maxProductId==null||maxProductId==""){
			return "PRO-0000000000001";
		}else{
		    String str = String.format("%013d", Integer.parseInt(maxProductId)+1);
		    return "PRO-"+str;
		}
	}
	private String creatProdModelId(){
		String maxProdModelId= modelService.findMaxProdModelId();
		if(maxProdModelId==null||maxProdModelId==""){
			return "PRM-0000000000001";
		}else{
		    String str = String.format("%013d", Integer.parseInt(maxProdModelId)+1);
		    return "PRM-"+str;
		}
	}
	
	private String creatProdClassfiyId(){
		String maxProdClassfiyId= classfiyService.findMaxProdClassfiyId();
		if(maxProdClassfiyId==null||maxProdClassfiyId==""){
			return "PRC-0000000000001";
		}else{
		    String str = String.format("%013d", Integer.parseInt(maxProdClassfiyId)+1);
		    return "PRC-"+str;
		}
	}
	private String creatProdBrandId(){
		String maxProdBrandId= brandService.findMaxProdBrandId();
		if(maxProdBrandId==null||maxProdBrandId==""){
			return "PRB-0000000000001";
		}else{
		    String str = String.format("%013d", Integer.parseInt(maxProdBrandId)+1);
		    return "PRB-"+str;
		}
	}
}