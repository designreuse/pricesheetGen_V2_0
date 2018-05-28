/**
 * Copyright &copy; 2015-2020 <a href="http://www.jeeplus.org/">JeePlus</a> All rights reserved.
 */
package com.sapling.modules.quotation.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.ConstraintViolationException;

import org.apache.shiro.authz.annotation.Logical;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.common.collect.Lists;
import com.sapling.common.config.Global;
import com.sapling.common.json.AjaxJson;
import com.sapling.common.persistence.Page;
import com.sapling.common.utils.DateUtils;
import com.sapling.common.utils.ExchangeMail;
import com.sapling.common.utils.StringUtils;
import com.sapling.common.utils.bus.Constant;
import com.sapling.common.utils.excel.ExportExcel;
import com.sapling.common.utils.excel.ImportExcel;
import com.sapling.common.web.BaseController;
import com.sapling.modules.quotation.entity.QuotationOrder;
import com.sapling.modules.quotation.entity.QuotationOrderDetail;
import com.sapling.modules.quotation.service.QuotationOrderDetailService;
import com.sapling.modules.quotation.service.QuotationOrderService;
import com.sapling.modules.sys.entity.User;
import com.sapling.modules.sys.utils.UserUtil;
import com.sapling.modules.sys.utils.UserUtils;

import net.sf.json.JSONObject;

import com.sapling.modules.sys.entity.Role;

/**
 * 报价单Controller
 * @author cth
 * @version 2017-01-24
 */
@Controller
@RequestMapping(value = "${adminPath}/quotation/quotationOrder")
public class QuotationOrderController extends BaseController {

	@Autowired
	private QuotationOrderService quotationOrderService;

	@Autowired
	private QuotationOrderDetailService quotationOrderDetailService;	

	@ModelAttribute
	public QuotationOrder get(@RequestParam(required=false) String id) {
		QuotationOrder entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = quotationOrderService.get(id);
		}
		if (entity == null){
			entity = new QuotationOrder();
		}
		return entity;
	}
	
	/**
	 * 报价单列表页面
	 */
	@RequiresPermissions("quotation:quotationOrder:list")
	@RequestMapping(value = {"list"})
	public String list(QuotationOrder quotationOrder, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<QuotationOrder> page = quotationOrderService.findPage(new Page<QuotationOrder>(request, response), quotationOrder); 
		model.addAttribute("page", page);
		return "modules/quotation/quotationOrderList";
	}


	/**
	 * 功能: 报价单新增页面导航入口
	 * 作者: 刘张学
	 * 
	 */
	@RequiresPermissions("quotation:quotationOrder:add")
	@RequestMapping(value = {"add"})
	public String add(QuotationOrder quotationOrder, HttpServletRequest request, HttpServletResponse response, Model model) {

		// 当前登陆用户为用户角色, 上送用户响应信息
		List<Role> rlis = UserUtils.getRoleList();
		if (null != rlis && 1 == rlis.size()) { // 商务:02, 客户角色: 05

			if(Constant.USER_ROLE_CLIENT.equals(rlis.get(0).getRoleCode())){

				User user = UserUtils.getUser();
				// 至  custName
				model.addAttribute("custName",  user.getName());
				// 客户公司  company
				model.addAttribute("company",  user.getCompany().getName());
				// 联系电话  companyPhone
				model.addAttribute("companyPhone",  user.getMobile());
				// 联系传真  companyFax
				model.addAttribute("companyFax",  user.getCompany().getFax());
			}
		}
		String path="modules/quotation/quotationOrderAddShow";
		System.out.println(path);
		
		return path;
	}

	/**
	 * 功能: 报价单明细查看页面导航入口
	 * 作者: 刘张学
	 * 
	 */	
	@RequiresPermissions("quotation:quotationOrder:show")
	@RequestMapping(value = {"show"})
	public String show(QuotationOrder quotationQry, Model model) {
		QuotationOrder quotationRlt = quotationOrderService.queryQuotationOrderDtl(quotationQry.getId());
		quotationOrderDetailService.sortQuotationOrderDetails(quotationRlt);
		model.addAttribute("quotationQry", quotationQry);
		model.addAttribute("quotationRlt",  quotationRlt);

		return "modules/quotation/show";
	}
	
	/**
	 * 报价单修改	
	 * @param quotationQry
	 * @param model
	 * @return
	 */
	@RequiresPermissions("quotation:quotationOrder:edit")
	@RequestMapping(value = {"edit", ""})
	public String edit(QuotationOrder quotationQry, Model model) {
		QuotationOrder po = quotationOrderService.queryQuotationOrderDtl(quotationQry.getId());
		Map<String, QuotationOrderDetail> map=new LinkedHashMap<String, QuotationOrderDetail>();
		String type=null;
		List<QuotationOrderDetail> list=null;
		for(QuotationOrderDetail quo:po.getQuotationOrderDetails()){
			type=quo.getProductType();
			if(map.containsKey(type)){
				QuotationOrderDetail sumPo=map.get(type);
				list=sumPo.getList();
				if(quo.getTotalAmt()!=null){
					sumPo.setTotalAmt(sumPo.getTotalAmt().add(quo.getTotalAmt()));
				}				
				list.add(quo);				
			}else{
				QuotationOrderDetail sumPo= new QuotationOrderDetail();
				sumPo.setProductName(quo.getProductName());
				if(quo.getTotalAmt()!=null){
					sumPo.setTotalAmt(quo.getTotalAmt());
				}
				list=new ArrayList<QuotationOrderDetail>();
				list.add(quo);
				sumPo.setList(list);
				map.put(type, sumPo);
			}
		}
		List<Map<String,Object>> resultList=new ArrayList();
		for(Map.Entry<String, QuotationOrderDetail> entry:map.entrySet()){
			Map<String,Object> result=new HashMap<String,Object>();
			result.put("name", entry.getKey());
			result.put("price", entry.getValue().getTotalAmt());
			result.put("detail", entry.getValue().getList());
			resultList.add(result);
		}
		model.addAttribute("data",po);
		model.addAttribute("result",resultList);

		return "modules/quotation/edit";
	}


	/**
	 * 查看，增加，编辑报价单表单页面
	 */
	@RequiresPermissions(value={"quotation:quotationOrder:view","quotation:quotationOrder:add","quotation:quotationOrder:edit"},logical=Logical.OR)
	@RequestMapping(value = "form")
	public String form(QuotationOrder quotationOrder, Model model) {
		QuotationOrder  order = quotationOrderService.queryQuotationOrderDtl(quotationOrder.getId());
		model.addAttribute("quotationOrder", quotationOrder);
//		model.addAttribute("JsonData", (order.getQuotationOrderDetails()));
		model.addAttribute("data",  order);
		return "modules/quotation/quotationOrderForm";
	}


	/**
	 * 保存报价单
	 */
	@RequiresPermissions("quotation:quotationOrder:save")
	@RequestMapping(value = {"save"}, method = {RequestMethod.POST})
	@ResponseBody
	public AjaxJson save(@RequestBody QuotationOrder quotationOrder, Model model) throws Exception{

		AjaxJson json = new AjaxJson();
		if (!beanValidator(model, quotationOrder)){
			form(quotationOrder, model);
			return json;
		}

		json = quotationOrderService.save(quotationOrder,json);
		//发送pdf
		quotationOrderService.sanderPdf(quotationOrder);
		return json;
	}

	/**
	 * 删除报价单
	 */
	@RequiresPermissions("quotation:quotationOrder:del")
	@RequestMapping(value = "delete")
	public String delete(QuotationOrder quotationOrder, RedirectAttributes redirectAttributes) {
		quotationOrderService.delete(quotationOrder);
		addMessage(redirectAttributes, "删除报价单成功");
		return "redirect:"+Global.getAdminPath()+"/quotation/quotationOrder/list?repage";
	}
	
	/**
	 * 批量删除报价单
	 */
	@RequiresPermissions("quotation:quotationOrder:del")
	@RequestMapping(value = "deleteAll")
	public String deleteAll(String ids, RedirectAttributes redirectAttributes) {
		String idArray[] =ids.split(",");
		for(String id : idArray){
			quotationOrderService.delete(quotationOrderService.get(id));
		}
		addMessage(redirectAttributes, "删除报价单成功");
		return "redirect:"+Global.getAdminPath()+"/quotation/quotationOrder/list?repage";
	}
	
	/**
	 * 导出excel文件
	 */
	@RequiresPermissions("quotation:quotationOrder:export")
    @RequestMapping(value = "export", method=RequestMethod.POST)
    public String exportFile(QuotationOrder quotationOrder, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
            String fileName = "报价单"+DateUtils.getDate("yyyyMMddHHmmss")+".xlsx";
            Page<QuotationOrder> page = quotationOrderService.findPage(new Page<QuotationOrder>(request, response, -1), quotationOrder);
    		new ExportExcel("报价单", QuotationOrder.class).setDataList(page.getList()).write(response, fileName).dispose();
    		return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导出报价单记录失败！失败信息："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/quotation/quotationOrder/?repage";
    }

	/**
	 * 导入Excel数据

	 */
	@RequiresPermissions("quotation:quotationOrder:import")
    @RequestMapping(value = "import", method=RequestMethod.POST)
    public String importFile(MultipartFile file, RedirectAttributes redirectAttributes) {
		try {
			int successNum = 0;
			int failureNum = 0;
			StringBuilder failureMsg = new StringBuilder();
			ImportExcel ei = new ImportExcel(file, 1, 0);
			List<QuotationOrder> list = ei.getDataList(QuotationOrder.class);
			for (QuotationOrder quotationOrder : list){
				try{
					quotationOrderService.save(quotationOrder);
					successNum++;
				}catch(ConstraintViolationException ex){
					failureNum++;
				}catch (Exception ex) {
					failureNum++;
				}
			}
			if (failureNum>0){
				failureMsg.insert(0, "，失败 "+failureNum+" 条报价单记录。");
			}
			addMessage(redirectAttributes, "已成功导入 "+successNum+" 条报价单记录"+failureMsg);
		} catch (Exception e) {
			addMessage(redirectAttributes, "导入报价单失败！失败信息："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/quotation/quotationOrder/?repage";
    }
	
	/**
	 * 下载导入报价单数据模板
	 */
	@RequiresPermissions("quotation:quotationOrder:import")
    @RequestMapping(value = "import/template")
    public String importFileTemplate(HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
            String fileName = "报价单数据导入模板.xlsx";
    		List<QuotationOrder> list = Lists.newArrayList(); 
    		new ExportExcel("报价单数据", QuotationOrder.class, 1).setDataList(list).write(response, fileName).dispose();
    		return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导入模板下载失败！失败信息："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/quotation/quotationOrder/?repage";
    }
	
}