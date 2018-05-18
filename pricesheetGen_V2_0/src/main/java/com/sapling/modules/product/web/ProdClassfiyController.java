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
@RequestMapping(value = "${adminPath}/product/prodClassfiy")
public class ProdClassfiyController extends BaseController {

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
	@RequiresPermissions("product:prodClassfiy:list")
	@RequestMapping(value = {"list", ""})
	public String list(ProdClassfiy classfiy, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<ProdClassfiy> page = classfiyService.findPage(new Page<ProdClassfiy>(request, response), classfiy); 
		model.addAttribute("page", page);
		return "modules/product/prodClassfiyList";
	}

	
	/**
	 * 查看，增加，编辑注释表单页面
	 */
	@RequiresPermissions(value={"product:prodClassfiy:view"},logical=Logical.OR)
	@RequestMapping(value = "form")
	public String form(ProdClassfiy classfiy, Model model) {
		//根据Id查询商品
		classfiy=classfiyService.get(classfiy.getId());

//		List<ProdBrand> brands= brandService.findProdBrandByClassfiyId(classfiy.getProdClassfiyId());
		
		model.addAttribute("prodClassfiy", classfiy);
//		model.addAttribute("brands", brands);
		return "modules/product/prodClassfiyForm";
	}
	
	/**
	 * 增加商品表单页面
	 */
	@RequiresPermissions(value={"product:prodClassfiy:add"},logical=Logical.OR)
	@RequestMapping(value = "addFrom")
	public String addFrom(Model model) {
		//查询所有的商品类型
		model.addAttribute("classfiyId",creatProdClassfiyId());
		return "modules/product/prodClassfiyAdd";
	}
	
	@RequiresPermissions(value={"product:prodClassfiy:add"},logical=Logical.OR)
	@RequestMapping(value = "addPFrom")
	public String addPFrom(String addOrEdit,String pId,Model model) {
		//查询所有的商品类型
		model.addAttribute("classfiyId",creatProdClassfiyId());
		model.addAttribute("addOrEdit",addOrEdit);
		model.addAttribute("pId",pId);
		return "modules/product/prodClassfiyPAdd";
	}
	
	
	@RequiresPermissions(value={"product:prodClassfiy:add"},logical=Logical.OR)
	@RequestMapping(value = {"save"}, method = {RequestMethod.POST})
	public String save(ProdClassfiy classfiy, Model model, RedirectAttributes redirectAttributes) throws Exception{
		classfiyService.saveProdClassfiy(classfiy);
		
		addMessage(redirectAttributes, "保存商品类型'" + classfiy.getProdClassfiyName()+ "'成功");
		return "redirect:"+Global.getAdminPath()+"/product/prodClassfiy/?repage";
	}
	

	@RequiresPermissions(value={"product:prodClassfiy:add"},logical=Logical.OR)
	@RequestMapping(value = {"pSave"}, method = {RequestMethod.POST})
	public String pSave(ProdClassfiy classfiy,String addOrEdit,String pId, Model model, RedirectAttributes redirectAttributes) throws Exception{
		classfiyService.saveProdClassfiy(classfiy);
		if(addOrEdit.equals("add")){
			return "redirect:"+Global.getAdminPath()+"/product/product/addFrom";
		}else{
			return "redirect:"+Global.getAdminPath()+"/product/product/editFrom?id="+pId;
		}
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
	


	/**
	 * 编辑商品表单页面
	 */
	@RequiresPermissions(value={"product:prodClassfiy:edit"},logical=Logical.OR)
	@RequestMapping(value = "editFrom")
	public String editFrom(ProdClassfiy classfiy, Model model) {
		//根据Id查询商品
		classfiy=classfiyService.get(classfiy.getId());

//		List<ProdBrand> brands= brandService.findProdBrandByClassfiyId(classfiy.getProdClassfiyId());
		
		model.addAttribute("prodClassfiy", classfiy);

		return "modules/product/prodClassfiyModify";
	}
	
	@RequiresPermissions(value={"product:prodClassfiy:edit"},logical=Logical.OR)
	@RequestMapping(value = {"update"}, method = {RequestMethod.POST})
	public String update(ProdClassfiy classfiy, Model model, RedirectAttributes redirectAttributes) throws Exception{
		
//		List<ProdBrand> brands=new ArrayList<ProdBrand>();
//		for (String  string : brandId) {
//			ProdBrand brand=new ProdBrand();
//			brand.setBrandId(string);
//			brands.add(brand);
//		}
//		List<ProdModel> models=new ArrayList<ProdModel>();
//		for (String string : modelId) {
//			ProdModel prodModel=modelService.findModelByModelId(string);
//			models.add(prodModel);
//		}
		classfiyService.updateProdClassfiy(classfiy);
		
		addMessage(redirectAttributes, "保存商品类型'" + classfiy.getProdClassfiyName()+ "'成功");
		return "redirect:"+Global.getAdminPath()+"/product/prodClassfiy/?repage";
	}
	
	/**
	 * 删除商品
	 */
	@RequiresPermissions("product:prodClassfiy:del")
	@RequestMapping(value = "delete")
	public String delete(Product product, RedirectAttributes redirectAttributes) {
		classfiyService.deleteProdClassfiy(classfiyService.get(product.getId()));
		addMessage(redirectAttributes, "删除商品类型成功");
		return "redirect:"+Global.getAdminPath()+"/product/prodClassfiy/?repage";
	}
	
	/**
	 * 批量删除商品
	 */
	@RequiresPermissions("product:prodClassfiy:del")
	@RequestMapping(value = "deleteAll")
	public String deleteAll(String ids, RedirectAttributes redirectAttributes) {
		String idArray[] =ids.split(",");
		for(String id : idArray){
			classfiyService.deleteProdClassfiy(classfiyService.get(id));
		}
		addMessage(redirectAttributes, "删除商品类型成功");
		return "redirect:"+Global.getAdminPath()+"/product/prodClassfiy/list?repage";
	}
	
	
	@RequestMapping(value = "findAllClassfiy", method = RequestMethod.GET)
	@ResponseBody
	public MsgInfoEntity findAllClassfiy() {
		MsgInfoEntity entity=new MsgInfoEntity();
		Map<Object, Object> data=new HashMap<Object, Object>();
		
		List<ProdClassfiy> classfiys =classfiyService.findList(null);
		data.put("classfiys", classfiys);
		entity.setData(data);
		entity.setStatus("1");
		entity.setMsgInf("");
		return entity;
	}

	
	
	private String creatProdClassfiyId(){
		String maxProdClassfiyId= classfiyService.findMaxProdClassfiyId();
		if(maxProdClassfiyId==null || maxProdClassfiyId==""){
			return "PRC-0000000000001";
		}else{
		    String str = String.format("%013d", Integer.parseInt(maxProdClassfiyId)+1);
		    return "PRC-"+str;
		}
	}
	
}