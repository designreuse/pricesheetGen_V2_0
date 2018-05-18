package com.sapling.modules.product.web;



import java.util.ArrayList;
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
import com.sapling.modules.product.entity.ProdModel;
import com.sapling.modules.product.entity.Product;
import com.sapling.modules.product.service.ProdBrandService;
import com.sapling.modules.product.service.ProdModelService;
import com.sapling.modules.product.service.ProductService;
import com.sapling.modules.sys.utils.MsgInfoEntity;

/**
 * 注释Controller
 * @author llz
 * @version 2017-01-24
 */
@Controller
@RequestMapping(value = "${adminPath}/product/prodModel")
public class ProdModelController extends BaseController {

	@Autowired
	private ProdModelService modelService ;

	@Autowired
	private ProdBrandService brandService ; 
	
	/**
	 *商品品牌列表页面
	 */
	@RequiresPermissions("product:prodModel:list")
	@RequestMapping(value = {"list", ""})
	public String list(ProdModel prodModel, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<ProdModel> page = modelService.findPage(new Page<ProdModel>(request, response), prodModel); 
		model.addAttribute("page", page);
		return "modules/product/prodModelList";
	}

	/**
	 * 查看，增加，编辑商品型号表单页面
	 */
	@RequiresPermissions(value={"product:prodModel:view"},logical=Logical.OR)
	@RequestMapping(value = "form")
	public String form(ProdModel prodModel, Model model) {
		prodModel=modelService.get(prodModel.getId());
		model.addAttribute("prodModel", prodModel);

		return "modules/product/prodModelForm";
	}
	
	@RequiresPermissions(value={"product:prodModel:edit"},logical=Logical.OR)
	@RequestMapping(value = "editFrom")
	public String editFrom(ProdModel prodModel, Model model) {
		prodModel=modelService.get(prodModel.getId());
		model.addAttribute("prodModel", prodModel);
		return "modules/product/prodModelModify";
	}
	
	@RequiresPermissions(value={"product:prodModel:edit"},logical=Logical.OR)
	@RequestMapping(value = {"update"}, method = {RequestMethod.POST})
	public String update(ProdModel prodModel, Model model, RedirectAttributes redirectAttributes) throws Exception{
		
		modelService.updateProdModel(prodModel);
		
		addMessage(redirectAttributes, "保存商品型号'" + prodModel.getModelName()+ "'成功");
		return "redirect:"+Global.getAdminPath()+"/product/prodModel/?repage";
	}
	
	/**
	 * 增加商品型号表单页面
	 */
	@RequiresPermissions(value={"product:prodModel:add"},logical=Logical.OR)
	@RequestMapping(value = "addFrom")
	public String addFrom(Model model) {
		//查询所有的商品类型
		model.addAttribute("modelId",creatProdModelId());
		return "modules/product/prodModelAdd";
	}
	
	@RequiresPermissions(value={"product:prodBrand:add"},logical=Logical.OR)
	@RequestMapping(value = "addPFrom")
	public String addPFrom(String addOrEdit,String pId,Model model) {
		//查询所有的商品类型
		model.addAttribute("modelId",creatProdModelId());
		model.addAttribute("addOrEdit",addOrEdit);
		model.addAttribute("pId",pId);
		return "modules/product/prodModelPAdd";
	}
	
	@RequiresPermissions(value={"product:prodBrand:add"},logical=Logical.OR)
	@RequestMapping(value = {"pSave"}, method = {RequestMethod.POST})
	public String pSave(ProdModel prodModel,String addOrEdit,String pId, Model model, RedirectAttributes redirectAttributes) throws Exception{
		modelService.saveProdModel(prodModel);
		if(addOrEdit.equals("add")){
			return "redirect:"+Global.getAdminPath()+"/product/product/addFrom";
		}else{
			return "redirect:"+Global.getAdminPath()+"/product/product/editFrom?id="+pId;
		}
	}
	
	@RequiresPermissions(value={"product:prodModel:add"},logical=Logical.OR)
	@RequestMapping(value = {"save"}, method = {RequestMethod.POST})
	public String save(ProdModel prodModel, Model model, RedirectAttributes redirectAttributes) throws Exception{
		
		modelService.saveProdModel(prodModel);
		
		addMessage(redirectAttributes, "保存商品型号'" + prodModel.getModelName()+ "'成功");
		return "redirect:"+Global.getAdminPath()+"/product/prodModel/?repage";
	}
	
	/**
	 * 删除商品品牌
	 */
	@RequiresPermissions("product:prodModel:del")
	@RequestMapping(value = "delete")
	public String delete(ProdModel product, RedirectAttributes redirectAttributes) {
		modelService.deleteModel(modelService.get(product.getId()));
		addMessage(redirectAttributes, "删除商品品牌成功");
		return "redirect:"+Global.getAdminPath()+"/product/prodModel/?repage";
	}
	
	/**
	 * 批量删除商品品牌
	 */
	@RequiresPermissions("product:prodModel:del")
	@RequestMapping(value = "deleteAll")
	public String deleteAll(String ids, RedirectAttributes redirectAttributes) {
		String idArray[] =ids.split(",");
		for(String id : idArray){
			modelService.deleteModel(modelService.get(id));
		}
		addMessage(redirectAttributes, "删除商品品牌成功");
		return "redirect:"+Global.getAdminPath()+"/product/prodModel/list?repage";
	}
	

	@RequestMapping(value = "findModelByBrandId", method = RequestMethod.GET)
	@ResponseBody
	public MsgInfoEntity findModelByBrandId(
			@RequestParam(value="brandIds", required=false) String[] brandIds,
			ModelMap model) {
		//查询所有的商品类型
		MsgInfoEntity entity=new MsgInfoEntity();
		Map<Object, Object> data=new HashMap<Object, Object>();
		
		List<Map<Object, Object>> maps=new ArrayList<Map<Object, Object>>();
		for (String brandId : brandIds) {
			ProdBrand brand=brandService.findProdBrandByBrandId(brandId);
			List<ProdModel> modelList=modelService.findModelByBrandId(brandId);
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
	
	
	@RequestMapping(value = "findAllModels", method = RequestMethod.GET)
	@ResponseBody
	public MsgInfoEntity findAllModels(
			ModelMap model) {
		//查询所有的商品类型
		MsgInfoEntity entity=new MsgInfoEntity();
		Map<Object, Object> data=new HashMap<Object, Object>();
		
		List<ProdModel> models= modelService.findAllList(new ProdModel());

		data.put("models", models);
		entity.setData(data);
		entity.setStatus("1");
		entity.setMsgInf("");
		return entity;
	}
	

	private String creatProdModelId(){
		String maxProdModelId= modelService.findMaxProdModelId();
		if(maxProdModelId == null || maxProdModelId==""){
			return "PRM-0000000000001";
		}else{
		    String str = String.format("%013d", Integer.parseInt(maxProdModelId)+1);
		    return "PRM-"+str;
		}
	}
	
}