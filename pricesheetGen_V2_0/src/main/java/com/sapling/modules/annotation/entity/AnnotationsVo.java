
package com.sapling.modules.annotation.entity;

import java.math.BigDecimal;
import java.util.List;

import com.sapling.common.persistence.DataEntity;

/**
 * 注释Entity
 * @author llz
 * @version 2017-01-24
 */
public class AnnotationsVo {
	private List<Annotation> annotations;
	private String quotationCode;
	public List<Annotation> getAnnotations() {
		return annotations;
	}
	public void setAnnotations(List<Annotation> annotations) {
		this.annotations = annotations;
	}
	public String getQuotationCode() {
		return quotationCode;
	}
	public void setQuotationCode(String quotationCode) {
		this.quotationCode = quotationCode;
	}
	 
	 
}