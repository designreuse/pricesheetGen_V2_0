package com.sapling.modules.annotation.web;


import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.Logical;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.sapling.common.config.Global;
import com.sapling.common.json.AjaxJson;
import com.sapling.common.persistence.Page;
import com.sapling.common.utils.MyBeanUtils;
import com.sapling.common.utils.StringUtils;
import com.sapling.common.web.BaseController;
import com.sapling.modules.annotation.entity.Annotation;
import com.sapling.modules.annotation.entity.AnnotationsVo;
import com.sapling.modules.annotation.service.AnnotationService;
import com.sapling.modules.quotation.entity.QuotationOrder;
import com.sapling.modules.quotation.entity.QuotationOrderDetail;
import com.sapling.modules.quotation.service.QuotationOrderDetailService;

/**
 * 注释Controller
 * @author llz
 * @version 2017-01-24
 */
@Controller
@RequestMapping(value = "${adminPath}/annotation/annotation")
public class AnnotationController extends BaseController {

	@Autowired
	private QuotationOrderDetailService quotationOrderDetailService;

	@Autowired
	private AnnotationService annotationService;

	
	/**
	 * 功能: 报价单注释录入页面导航入口
	 * 作者: 刘张学
	 * 
	 */	
	@RequiresPermissions("annotation:annotation:annotationAddNav")
	@RequestMapping(value = {"annotationAddNav"})
	public String annotationAddNav(QuotationOrder quotationQry, Model model) {

		// 获取报价单明细Id
		List<QuotationOrderDetail> detailListRlt = quotationOrderDetailService.getQuotationOrderDetails(quotationQry);
		List<Long> uidList = quotationOrderDetailService.getQuotationOrderDetailIds(detailListRlt);

		// 查注释
		List<Annotation> annotationList = annotationService.getListByDetailIds(quotationQry, uidList);

		// 为报价单明细绑定产品注释
		annotationService.bindAnnotation2OrderDetail(detailListRlt, annotationList);

		model.addAttribute("quotationQry", quotationQry);
		model.addAttribute("detailListRlt",  detailListRlt);
		model.addAttribute("detailListRltSize",  detailListRlt.size());
		return "modules/annotation/annotationAdd";
	}


	@ModelAttribute
	public Annotation get(@RequestParam(required=false) String id) {
		Annotation entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = annotationService.get(id);
		}
		if (entity == null){
			entity = new Annotation();
		}
		return entity;
	}
	
	/**
	 * 注释列表页面
	 */
	@RequiresPermissions("annotation:annotation:list")
	@RequestMapping(value = {"list", ""})
	public String list(Annotation annotation, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<Annotation> page = annotationService.findPage(new Page<Annotation>(request, response), annotation); 
		model.addAttribute("page", page);
		return "modules/annotation/annotationList";
	}

	
	/**
	 * 查看，增加，编辑注释表单页面
	 */
	@RequiresPermissions(value={"annotation:annotation:view","annotation:annotation:add","annotation:annotation:edit"},logical=Logical.OR)
	@RequestMapping(value = "form")
	public String form(Annotation annotation, Model model) {
		model.addAttribute("annotation", annotation);
		return "modules/annotation/annotationForm";
	}

	/**
	 * 保存注释
	 */
	@RequiresPermissions(value={"annotation:annotation:add","annotation:annotation:edit"},logical=Logical.OR)
	@RequestMapping(value = "save")
	public String save(Annotation annotation, Model model, RedirectAttributes redirectAttributes) throws Exception{
		if (!beanValidator(model, annotation)){
			return form(annotation, model);
		}
		if(!annotation.getIsNewRecord()){//编辑表单保存
			Annotation t = annotationService.get(annotation.getId());//从数据库取出记录的值
			MyBeanUtils.copyBeanNotNull2Bean(annotation, t);//将编辑表单中的非NULL值覆盖数据库记录中的值
			annotationService.save(t);//保存
		}else{//新增表单保存
			annotationService.save(annotation);//保存
		}
		addMessage(redirectAttributes, "保存注释成功");
		return "redirect:"+Global.getAdminPath()+"/annotation/annotation/?repage";
	}
	
	/**
	 * 保存注释
	 */
	@RequiresPermissions("annotation:annotation:addList")
	@RequestMapping(value = {"saveList"}, method = {RequestMethod.POST})	
	@ResponseBody
	public AjaxJson saveList(@RequestBody AnnotationsVo annotationsVo, Model model) throws Exception{

		// 商品注释不能为空
		AjaxJson json = new AjaxJson();
		 

		// 报价单号不能为空
		if(null == annotationsVo.getQuotationCode() 
				|| "".equals(annotationsVo.getQuotationCode().trim())) {
			json.put("state", "0");
			json.put("msg", "商品注释的报价单号不能为空!");
			return json;
		}
		for (Annotation annotation : annotationsVo.getAnnotations()) {
			if(annotation.getAnnoName()==null || annotation.getAnnoName().equals("")){
				json.put("state", "0");
				json.put("msg", "商品品牌不能为空");
				return json;
			}
			if(annotation.getAnnoType()==null || annotation.getAnnoType().equals("")){
				json.put("state", "0");
				json.put("msg", "商品型号不能为空");
				return json;
			}
		}
		// 保存
		annotationService.saveList(annotationsVo);;

		json.put("state", "1");
		json.put("msg", "添加注释成功!");
		return json;
	}	

	/**
	 * 删除注释
	 */
	@RequiresPermissions("annotation:annotation:del")
	@RequestMapping(value = "delete")
	public String delete(Annotation annotation, RedirectAttributes redirectAttributes) {
		annotationService.delete(annotation);
		addMessage(redirectAttributes, "删除注释成功");
		return "redirect:"+Global.getAdminPath()+"/annotation/annotation/?repage";
	}
}