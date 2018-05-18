package com.sapling.modules.product.web;



import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.Logical;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.sapling.common.config.Global;
import com.sapling.common.json.AjaxJson;
import com.sapling.common.persistence.Page;
import com.sapling.common.web.BaseController;
import com.sapling.modules.product.entity.ProdBrand;
import com.sapling.modules.product.entity.ProdClassfiy;
import com.sapling.modules.product.entity.ProdModel;
import com.sapling.modules.product.entity.Product;
import com.sapling.modules.product.service.ProdBrandService;
import com.sapling.modules.product.service.ProdClassfiyService;
import com.sapling.modules.product.service.ProdModelService;
import com.sapling.modules.product.service.ProductService;
import com.sapling.modules.quotation.entity.QuotationOrder;
import com.sapling.modules.sys.utils.MsgInfoEntity;

/**
 * 注释Controller
 * @author llz
 * @version 2017-01-24
 */
@Controller
@RequestMapping(value = "${adminPath}/product/product")
public class ProductController extends BaseController {

	@Autowired
	private ProductService productService;

	@Autowired
	private ProdBrandService brandService ; 
	
	@Autowired
	private ProdModelService modelService ;
	
	@Autowired
	private ProdClassfiyService classfiyService ; 
	
	 private SimpleDateFormat sdfFolder = new SimpleDateFormat("yyyyMMdd");

	/**
	 * 商品列表页面
	 */
	@RequiresPermissions("product:product:list")
	@RequestMapping(value = {"list", ""})
	public String list(Product product, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<Product> page = productService.findPage(new Page<Product>(request, response), product); 
		model.addAttribute("page", page);
		return "modules/product/productList";
	}

	
	/**
	 * 查看，增加，编辑注释表单页面
	 */
	@RequiresPermissions(value={"product:product:view","product:product:add","product:product:edit"},logical=Logical.OR)
	@RequestMapping(value = "form")
	public String form(Product product, Model model) {
		//根据Id查询商品
		product=productService.get(product.getId());
		//根据商品ID查询该商品的所有品牌
		List<ProdBrand> prodBrands=brandService.findListByProduct(product.getProductId());
		product.setBrands(prodBrands.size()>0?prodBrands:new ArrayList<ProdBrand>());

		//根据商品ID查询该商品的所有商品类型
		List<ProdClassfiy> selectClassfiy=classfiyService.findListByProduct(product.getProductId());
		product.setClassfiys(selectClassfiy.size()>0?selectClassfiy:new ArrayList<ProdClassfiy>());
		
		List<ProdModel> models= modelService.findListByProduct(product.getProductId());
		product.setModels(models.size()>0?models:new ArrayList<ProdModel>());
		//查询所有的品牌
//		List<ProdBrand> brands= brandService.findAllList(new ProdBrand());
		
		//查询该商品下所有的型号
//		List<ProdModel> models= modelService.findModelByProductId(product.getProductId());
		
		model.addAttribute("product", product);
		model.addAttribute("brandList", prodBrands);
		model.addAttribute("classfiyList", selectClassfiy);
		model.addAttribute("modelList", models);

		return "modules/product/productForm";
	}
	
	/**
	 * 增加商品表单页面
	 */
	@RequiresPermissions(value={"product:product:add"},logical=Logical.OR)
	@RequestMapping(value = "addFrom")
	public String addFrom(Model model) {
		//查询所有的商品类型
		List<ProdClassfiy> classfiys =classfiyService.findList(null);
		List<ProdBrand> brands= brandService.findAllList(new ProdBrand());
		List<ProdModel> models= modelService.findAllList(new ProdModel());

		model.addAttribute("classfiyList", classfiys);
		model.addAttribute("brandList", brands);
		model.addAttribute("modelList", models);
		model.addAttribute("productId",creatProductId());
		return "modules/product/productAdd";
	}
	
	@RequiresPermissions(value={"product:product:add"},logical=Logical.OR)
	@RequestMapping(value = {"save"}, method = {RequestMethod.POST})
	public String save(Product product,String[] classfiyId,String[] brandId,String[] modelId, Model model, RedirectAttributes redirectAttributes) throws Exception{
		List<ProdClassfiy> classfiys=new ArrayList<ProdClassfiy>();
		if(classfiyId!=null){
			for (String  string : classfiyId) {
				ProdClassfiy classfiy=new ProdClassfiy();
				classfiy.setProdClassfiyId(string);
				classfiys.add(classfiy);
			}
		}
		product.setClassfiys(classfiys);
		
		List<ProdBrand> brands=new ArrayList<ProdBrand>();
		if(brandId!=null){
			for (String  string : brandId) {
				ProdBrand brand=new ProdBrand();
				brand.setBrandId(string);
				brands.add(brand);
			}
		}
		product.setBrands(brands);
		
		List<ProdModel> models=new ArrayList<ProdModel>();
		if(modelId!=null){
			for (String string : modelId) {
				ProdModel prodModel=new ProdModel();
				prodModel.setModelId(string);
				models.add(prodModel);
			}
		}
		product.setModels(models);
		
		productService.saveProduct(product);
		
		addMessage(redirectAttributes, "保存商品'" + product.getProductName() + "'成功");
		return "redirect:"+Global.getAdminPath()+"/product/product/addFrom";
	}
	
	@RequiresPermissions(value={"product:product:edit"},logical=Logical.OR)
	@RequestMapping(value = {"update"}, method = {RequestMethod.POST})
	public String update(Product product,String[] classfiyId,String[] brandId,String[] modelId, Model model, RedirectAttributes redirectAttributes) throws Exception{
		Product product2=productService.get(product.getId());
		product2.setProductName(product.getProductName());

		List<ProdClassfiy> classfiys=new ArrayList<ProdClassfiy>();
		if(classfiyId!=null){
			for (String  string : classfiyId) {
				ProdClassfiy classfiy=new ProdClassfiy();
				classfiy.setProdClassfiyId(string);
				classfiys.add(classfiy);
			}
		} 
		product2.setClassfiys(classfiys);
		
		List<ProdBrand> brands=new ArrayList<ProdBrand>();
		if(brandId!=null){
			for (String  string : brandId) {
				ProdBrand brand=new ProdBrand();
				brand.setBrandId(string);
				brands.add(brand);
			}
		} 
		product2.setBrands(brands);
		
		List<ProdModel> models=new ArrayList<ProdModel>();
		if(modelId!=null){
			for (String string : modelId) {
				ProdModel prodModel=new ProdModel();
				prodModel.setModelId(string);
				models.add(prodModel);
			}
		}
		product2.setModels(models);
		
		productService.updateProduct(product2);
		
		addMessage(redirectAttributes, "保存商品'" + product.getProductName() + "'成功");
		return "redirect:"+Global.getAdminPath()+"/product/product/editFrom?id="+product.getId();
	}
	
	@RequestMapping(value = "findBrandByClassfiyId", method = RequestMethod.GET)
	@ResponseBody
	public MsgInfoEntity findBrandByClassfiyId(
			@RequestParam(value="classfiyId", required=false) String classfiyId,
			ModelMap model) {
		//查询所有的商品类型
		MsgInfoEntity entity=new MsgInfoEntity();
		Map<Object, Object> data=new HashMap<Object, Object>();
		
		List<ProdBrand> brands= brandService.findProdBrandByClassfiyId(classfiyId);
		List<ProdModel> models=modelService.findProdModelByClassfiyId(null,classfiyId);
		data.put("brands", brands);
		data.put("models", models);
		entity.setData(data);
		entity.setStatus("1");
		entity.setMsgInf("");
		return entity;
	}
	
	
	@RequestMapping(value = "findModelByBrandIdAndClassfiyId", method = RequestMethod.GET)
	@ResponseBody
	public MsgInfoEntity findModelByBrandIdAndClassfiyId(
			@RequestParam(value="brandIds", required=false) String[] brandIds,
			@RequestParam(value="classfiyId", required=false) String classfiyId,
			ModelMap model) {
		//查询所有的商品类型
		MsgInfoEntity entity=new MsgInfoEntity();
		Map<Object, Object> data=new HashMap<Object, Object>();
		
		List<Map<Object, Object>> maps=new ArrayList<Map<Object, Object>>();
		for (String brandId : brandIds) {
			ProdBrand brand=brandService.findProdBrandByBrandId(brandId);
			List<ProdModel> modelList=modelService.findProdModelByClassfiyId(brandId,classfiyId);
			Map<Object,Object> map=new HashMap<Object, Object>();
			map.put("brandId",brandId );
			map.put("brandName",brand.getBrandName() );
			map.put("modelList", modelList);
			maps.add(map);
		}
		data.put("models", maps);
		entity.setData(data);
		entity.setStatus("1");
		entity.setMsgInf("");
		return entity;
	}
	
	

	@RequestMapping(value = "findModelByBIdAndCIdAndPId", method = RequestMethod.GET)
	@ResponseBody
	public MsgInfoEntity findModelByBIdAndCIdAndPId(
			@RequestParam(value="brandIds", required=false) String[] brandIds,
			@RequestParam(value="classfiyId", required=false) String classfiyId,
			@RequestParam(value="productId", required=false) String productId,
			ModelMap model) {
		//查询所有的商品类型
		MsgInfoEntity entity=new MsgInfoEntity();
		Map<Object, Object> data=new HashMap<Object, Object>();
		
		List<Map<Object, Object>> maps=new ArrayList<Map<Object, Object>>();
		for (String brandId : brandIds) {
			ProdBrand brand=brandService.findProdBrandByBrandId(brandId);
			List<ProdModel> modelList=modelService.findModelByBIdAndCIdAndPId(brandId,classfiyId,productId);
			Map<Object,Object> map=new HashMap<Object, Object>();
			map.put("brandId",brandId );
			map.put("brandName",brand.getBrandName() );
			map.put("modelList", modelList);
			maps.add(map);
		}
		data.put("models", maps);
		entity.setData(data);
		entity.setStatus("1");
		entity.setMsgInf("");
		return entity;
	}

	/**
	 * 编辑商品表单页面
	 */
	@RequiresPermissions(value={"product:product:edit"},logical=Logical.OR)
	@RequestMapping(value = "editFrom")
	public String editFrom(Product product, Model model) {
//		//根据Id查询商品
//		product=productService.get(product.getId());
//		//根据商品ID查询该商品的所有品牌
//		List<ProdBrand> prodBrands=brandService.findListByProduct(product.getProductId());
//		product.setBrands(prodBrands);
//		//查询所有的商品类型
//		List<ProdClassfiy> classfiys =classfiyService.findList(null);
//		
//		//储存该商品所有的品牌
//		List<String> list=new ArrayList<String>();
//		for (ProdBrand brand : prodBrands) {
//			String brandId=brand.getBrandId();
//			list.add(brandId);
//		}
//		//查询该商品下品牌所对应的商品类型
//		ProdClassfiy selectClassfiy=classfiyService.getByBrandIdsAndModel(list,product.getProductId());
//		product.setClassfiyId(selectClassfiy==null?"":selectClassfiy.getProdClassfiyId());
//		
//		//查询所有的品牌
//		List<ProdBrand> brands= brandService.findAllList(new ProdBrand());
//		
//		//查询该商品下所有的型号
//		List<ProdModel> models= modelService.findModelByProductId(product.getProductId());
//		
//		model.addAttribute("product", product);
//		model.addAttribute("brandList", brands);
//		model.addAttribute("classfiyList", classfiys);
//		model.addAttribute("modelList", models);
		
		product=productService.get(product.getId());
		//根据商品ID查询该商品的所有品牌
		List<ProdBrand> prodBrands=brandService.findListByProduct(product.getProductId());
		product.setBrands(prodBrands.size()>0?prodBrands:new ArrayList<ProdBrand>());

		//根据商品ID查询该商品的所有商品类型
		List<ProdClassfiy> selectClassfiy=classfiyService.findListByProduct(product.getProductId());
		product.setClassfiys(selectClassfiy.size()>0?selectClassfiy:new ArrayList<ProdClassfiy>());
		
		List<ProdModel> selectModels= modelService.findModelByProductId(product.getProductId());
		product.setModels(selectModels.size()>0?selectModels:new ArrayList<ProdModel>());
		
		List<ProdBrand> brands= brandService.findAllList(new ProdBrand());
		
		List<ProdClassfiy> classfiys =classfiyService.findList(null);

		List<ProdModel> models= modelService.findAllList(new ProdModel());
		
		model.addAttribute("product", product);
		model.addAttribute("brandList", brands);
		model.addAttribute("classfiyList", classfiys);
		model.addAttribute("modelList", models);
		return "modules/product/productModify";
	}
	
	
	/**
	 * 删除商品
	 */
	@RequiresPermissions("product:product:del")
	@RequestMapping(value = "delete")
	public String delete(Product product, RedirectAttributes redirectAttributes) {
		productService.deleteProduct(productService.get(product.getId()));
		addMessage(redirectAttributes, "删除商品成功");
		return "redirect:"+Global.getAdminPath()+"/product/product/?repage";
	}
	
	/**
	 * 批量删除商品
	 */
	@RequiresPermissions("product:product:del")
	@RequestMapping(value = "deleteAll")
	public String deleteAll(String ids, RedirectAttributes redirectAttributes) {
		String idArray[] =ids.split(",");
		for(String id : idArray){
			productService.deleteProduct(productService.get(id));
		}
		addMessage(redirectAttributes, "删除商品成功");
		return "redirect:"+Global.getAdminPath()+"/product/product/list?repage";
	}
	
	
	private String creatProductId(){
		String maxProductId= productService.findMaxProductId();
		if(maxProductId==null || maxProductId==""){
			return "PRO-0000000000001";
		}else{
		    String str = String.format("%013d", Integer.parseInt(maxProductId)+1);
		    return "PRO-"+str;
		}
	}
	
}