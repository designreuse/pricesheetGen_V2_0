package com.sapling.modules.product.web;



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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.sapling.common.config.Global;
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
import com.sapling.modules.sys.utils.MsgInfoEntity;

/**
 * 注释Controller
 * @author llz
 * @version 2017-01-24
 */
@Controller
@RequestMapping(value = "${adminPath}/product/prodBrand")
public class ProdBrandController extends BaseController {

	@Autowired
	private ProdBrandService brandService ;

	@Autowired
	private ProdClassfiyService classfiyService ; 
	/**
	 *商品品牌列表页面
	 */
	@RequiresPermissions("product:prodBrand:list")
	@RequestMapping(value = {"list", ""})
	public String list(ProdBrand brand, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<ProdBrand> page = brandService.findPage(new Page<ProdBrand>(request, response), brand); 
		model.addAttribute("page", page);
		return "modules/product/prodBrandList";
	}

	
	/**
	 * 查看，增加，编辑商品品牌表单页面
	 */
	@RequiresPermissions(value={"product:prodBrand:view","product:prodBrand:add"},logical=Logical.OR)
	@RequestMapping(value = "form")
	public String form(ProdBrand brand, Model model) {
		brand=brandService.get(brand.getId());
//		List<ProdClassfiy> classfiys= classfiyService.findClassfiyByBrandId(brand.getBrandId());
		model.addAttribute("prodBrand", brand);
//		model.addAttribute("classfiys", classfiys);
		return "modules/product/prodBrandForm";
	}
	
	
	
	@RequiresPermissions(value={"product:prodBrand:edit"},logical=Logical.OR)
	@RequestMapping(value = "editFrom")
	public String editFrom(ProdBrand brand, Model model) {
		//根据Id查询商品
		brand=brandService.get(brand.getId());
		model.addAttribute("prodBrand", brand);
		return "modules/product/prodBrandModify";
	}
	
	@RequiresPermissions(value={"product:prodBrand:edit"},logical=Logical.OR)
	@RequestMapping(value = {"update"}, method = {RequestMethod.POST})
	public String update(ProdBrand brand, Model model, RedirectAttributes redirectAttributes) throws Exception{
		
		brandService.updateProdBrand(brand);
		
		addMessage(redirectAttributes, "保存商品品牌'" + brand.getBrandName()+ "'成功");
		return "redirect:"+Global.getAdminPath()+"/product/prodBrand/?repage";
	}
	/**
	 * 增加商品品牌表单页面
	 */
	@RequiresPermissions(value={"product:prodBrand:add"},logical=Logical.OR)
	@RequestMapping(value = "addFrom")
	public String addFrom(Model model) {
		//查询所有的商品类型
		model.addAttribute("brandId",creatProdBrandId());
		return "modules/product/prodBrandAdd";
	}
	
	
	@RequiresPermissions(value={"product:prodBrand:add"},logical=Logical.OR)
	@RequestMapping(value = "addPFrom")
	public String addPFrom(String addOrEdit,String pId,Model model) {
		//查询所有的商品类型
		model.addAttribute("brandId",creatProdBrandId());
		model.addAttribute("addOrEdit",addOrEdit);
		model.addAttribute("pId",pId);
		return "modules/product/prodBrandPAdd";
	}
	
	@RequiresPermissions(value={"product:prodBrand:add"},logical=Logical.OR)
	@RequestMapping(value = {"pSave"}, method = {RequestMethod.POST})
	public String pSave(ProdBrand brand,String addOrEdit,String pId, Model model, RedirectAttributes redirectAttributes) throws Exception{
		brandService.saveProdBrand(brand);
		if(addOrEdit.equals("add")){
			return "redirect:"+Global.getAdminPath()+"/product/product/addFrom";
		}else{
			return "redirect:"+Global.getAdminPath()+"/product/product/editFrom?id="+pId;
		}
	}

	@RequiresPermissions(value={"product:prodBrand:add"},logical=Logical.OR)
	@RequestMapping(value = {"save"}, method = {RequestMethod.POST})
	public String save(ProdBrand brand, Model model, RedirectAttributes redirectAttributes) throws Exception{
		
		brandService.saveProdBrand(brand);
		
		addMessage(redirectAttributes, "保存商品品牌'" + brand.getBrandName()+ "'成功");
		return "redirect:"+Global.getAdminPath()+"/product/prodBrand/?repage";
	}
	
	/**
	 * 删除商品品牌
	 */
	@RequiresPermissions("product:prodBrand:del")
	@RequestMapping(value = "delete")
	public String delete(ProdBrand product, RedirectAttributes redirectAttributes) {
		brandService.deleteBrand(brandService.get(product.getId()));
		addMessage(redirectAttributes, "删除商品品牌成功");
		return "redirect:"+Global.getAdminPath()+"/product/prodBrand/?repage";
	}
	
	/**
	 * 批量删除商品品牌
	 */
	@RequiresPermissions("product:prodBrand:del")
	@RequestMapping(value = "deleteAll")
	public String deleteAll(String ids, RedirectAttributes redirectAttributes) {
		String idArray[] =ids.split(",");
		for(String id : idArray){
			brandService.deleteBrand(brandService.get(id));
		}
		addMessage(redirectAttributes, "删除商品品牌成功");
		return "redirect:"+Global.getAdminPath()+"/product/prodBrand/list?repage";
	}
	
	
	@RequestMapping(value = "findAllBrands", method = RequestMethod.GET)
	@ResponseBody
	public MsgInfoEntity findAllBrands(
			ModelMap model) {
		//查询所有的商品类型
		MsgInfoEntity entity=new MsgInfoEntity();
		Map<Object, Object> data=new HashMap<Object, Object>();
		
		List<ProdBrand> brands= brandService.findAllList(new ProdBrand());

		data.put("brands", brands);
		entity.setData(data);
		entity.setStatus("1");
		entity.setMsgInf("");
		return entity;
	}
	
	
	private String creatProdBrandId(){
		String maxProdBrandId= brandService.findMaxProdBrandId();
		if(maxProdBrandId==null || maxProdBrandId==""){
			return "PRB-0000000000001";
		}else{
		    String str = String.format("%013d", Integer.parseInt(maxProdBrandId)+1);
		    return "PRB-"+str;
		}
	}
}