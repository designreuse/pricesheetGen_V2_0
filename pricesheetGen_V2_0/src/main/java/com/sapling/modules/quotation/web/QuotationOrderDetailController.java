/**
 * Copyright &copy; 2015-2020 <a href="http://www.jeeplus.org/">JeePlus</a> All rights reserved.
 */
package com.sapling.modules.quotation.web;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.ConstraintViolationException;

import org.apache.shiro.authz.annotation.Logical;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.common.collect.Lists;
import com.sapling.common.utils.DateUtils;
import com.sapling.common.utils.MyBeanUtils;
import com.sapling.common.config.Global;
import com.sapling.common.persistence.Page;
import com.sapling.common.web.BaseController;
import com.sapling.common.utils.StringUtils;
import com.sapling.common.utils.excel.ExportExcel;
import com.sapling.common.utils.excel.ImportExcel;
import com.sapling.modules.quotation.entity.QuotationOrderDetail;
import com.sapling.modules.quotation.service.QuotationOrderDetailService;

/**
 * 报价单明细Controller
 * @author cth
 * @version 2017-01-25
 */
@Controller
@RequestMapping(value = "${adminPath}/quotation/quotationOrderDetail")
public class QuotationOrderDetailController extends BaseController {

	@Autowired
	private QuotationOrderDetailService quotationOrderDetailService;
	
	@ModelAttribute
	public QuotationOrderDetail get(@RequestParam(required=false) String id) {
		QuotationOrderDetail entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = quotationOrderDetailService.get(id);
		}
		if (entity == null){
			entity = new QuotationOrderDetail();
		}
		return entity;
	}
	
	/**
	 * 报价单明细列表页面
	 */
	@RequiresPermissions("quotation:quotationOrderDetail:list")
	@RequestMapping(value = {"list", ""})
	public String list(QuotationOrderDetail quotationOrderDetail, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<QuotationOrderDetail> page = quotationOrderDetailService.findPage(new Page<QuotationOrderDetail>(request, response), quotationOrderDetail); 
		model.addAttribute("page", page);
		return "modules/quotation/quotationOrderDetailList";
	}

	/**
	 * 查看，增加，编辑报价单明细表单页面
	 */
	@RequiresPermissions(value={"quotation:quotationOrderDetail:view","quotation:quotationOrderDetail:add","quotation:quotationOrderDetail:edit"},logical=Logical.OR)
	@RequestMapping(value = "form")
	public String form(QuotationOrderDetail quotationOrderDetail, Model model) {
		model.addAttribute("quotationOrderDetail", quotationOrderDetail);
		return "modules/quotation/quotationOrderDetailForm";
	}

	/**
	 * 保存报价单明细
	 */
	@RequiresPermissions(value={"quotation:quotationOrderDetail:add","quotation:quotationOrderDetail:edit"},logical=Logical.OR)
	@RequestMapping(value = "save")
	public String save(QuotationOrderDetail quotationOrderDetail, Model model, RedirectAttributes redirectAttributes) throws Exception{
		if (!beanValidator(model, quotationOrderDetail)){
			return form(quotationOrderDetail, model);
		}
		if(!quotationOrderDetail.getIsNewRecord()){//编辑表单保存
			QuotationOrderDetail t = quotationOrderDetailService.get(quotationOrderDetail.getId());//从数据库取出记录的值
			MyBeanUtils.copyBeanNotNull2Bean(quotationOrderDetail, t);//将编辑表单中的非NULL值覆盖数据库记录中的值
			quotationOrderDetailService.save(t);//保存
		}else{//新增表单保存
			quotationOrderDetailService.save(quotationOrderDetail);//保存
		}
		addMessage(redirectAttributes, "保存报价单明细成功");
		return "redirect:"+Global.getAdminPath()+"/quotation/quotationOrderDetail/?repage";
	}
	
	/**
	 * 删除报价单明细
	 */
	@RequiresPermissions("quotation:quotationOrderDetail:del")
	@RequestMapping(value = "delete")
	public String delete(QuotationOrderDetail quotationOrderDetail, RedirectAttributes redirectAttributes) {
		quotationOrderDetailService.delete(quotationOrderDetail);
		addMessage(redirectAttributes, "删除报价单明细成功");
		return "redirect:"+Global.getAdminPath()+"/quotation/quotationOrderDetail/?repage";
	}
	
	/**
	 * 批量删除报价单明细
	 */
	@RequiresPermissions("quotation:quotationOrderDetail:del")
	@RequestMapping(value = "deleteAll")
	public String deleteAll(String ids, RedirectAttributes redirectAttributes) {
		String idArray[] =ids.split(",");
		for(String id : idArray){
			quotationOrderDetailService.delete(quotationOrderDetailService.get(id));
		}
		addMessage(redirectAttributes, "删除报价单明细成功");
		return "redirect:"+Global.getAdminPath()+"/quotation/quotationOrderDetail/?repage";
	}
	
	/**
	 * 导出excel文件
	 */
	@RequiresPermissions("quotation:quotationOrderDetail:export")
    @RequestMapping(value = "export", method=RequestMethod.POST)
    public String exportFile(QuotationOrderDetail quotationOrderDetail, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
            String fileName = "报价单明细"+DateUtils.getDate("yyyyMMddHHmmss")+".xlsx";
            Page<QuotationOrderDetail> page = quotationOrderDetailService.findPage(new Page<QuotationOrderDetail>(request, response, -1), quotationOrderDetail);
    		new ExportExcel("报价单明细", QuotationOrderDetail.class).setDataList(page.getList()).write(response, fileName).dispose();
    		return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导出报价单明细记录失败！失败信息："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/quotation/quotationOrderDetail/?repage";
    }

	/**
	 * 导入Excel数据

	 */
	@RequiresPermissions("quotation:quotationOrderDetail:import")
    @RequestMapping(value = "import", method=RequestMethod.POST)
    public String importFile(MultipartFile file, RedirectAttributes redirectAttributes) {
		try {
			int successNum = 0;
			int failureNum = 0;
			StringBuilder failureMsg = new StringBuilder();
			ImportExcel ei = new ImportExcel(file, 1, 0);
			List<QuotationOrderDetail> list = ei.getDataList(QuotationOrderDetail.class);
			for (QuotationOrderDetail quotationOrderDetail : list){
				try{
					quotationOrderDetailService.save(quotationOrderDetail);
					successNum++;
				}catch(ConstraintViolationException ex){
					failureNum++;
				}catch (Exception ex) {
					failureNum++;
				}
			}
			if (failureNum>0){
				failureMsg.insert(0, "，失败 "+failureNum+" 条报价单明细记录。");
			}
			addMessage(redirectAttributes, "已成功导入 "+successNum+" 条报价单明细记录"+failureMsg);
		} catch (Exception e) {
			addMessage(redirectAttributes, "导入报价单明细失败！失败信息："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/quotation/quotationOrderDetail/?repage";
    }
	
	/**
	 * 下载导入报价单明细数据模板
	 */
	@RequiresPermissions("quotation:quotationOrderDetail:import")
    @RequestMapping(value = "import/template")
    public String importFileTemplate(HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
            String fileName = "报价单明细数据导入模板.xlsx";
    		List<QuotationOrderDetail> list = Lists.newArrayList(); 
    		new ExportExcel("报价单明细数据", QuotationOrderDetail.class, 1).setDataList(list).write(response, fileName).dispose();
    		return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导入模板下载失败！失败信息："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/quotation/quotationOrderDetail/?repage";
    }
	
	
	/**
	 * 选择报价单号
	 */
	@RequestMapping(value = "selectquotationCode")
	public String selectquotationCode(String quotationCode, String url, String fieldLabels, String fieldKeys, String searchLabel, String searchKey, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<String> page = quotationOrderDetailService.findPageByquotationCode(new Page<String>(request, response),  quotationCode);
		try {
			fieldLabels = URLDecoder.decode(fieldLabels, "UTF-8");
			fieldKeys = URLDecoder.decode(fieldKeys, "UTF-8");
			searchLabel = URLDecoder.decode(searchLabel, "UTF-8");
			searchKey = URLDecoder.decode(searchKey, "UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		model.addAttribute("labelNames", fieldLabels.split("\\|"));
		model.addAttribute("labelValues", fieldKeys.split("\\|"));
		model.addAttribute("fieldLabels", fieldLabels);
		model.addAttribute("fieldKeys", fieldKeys);
		model.addAttribute("url", url);
		model.addAttribute("searchLabel", searchLabel);
		model.addAttribute("searchKey", searchKey);
		model.addAttribute("obj", quotationCode);
		model.addAttribute("page", page);
		return "modules/sys/gridselect";
	}
	

}