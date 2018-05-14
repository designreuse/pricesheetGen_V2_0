package com.sapling.modules.quotation.utils;

import java.util.Comparator;

import com.sapling.modules.quotation.entity.QuotationOrderDetail;

public class QuotationComparator implements Comparator<Object> {

	public int compare(Object o1, Object o2) {

		QuotationOrderDetail p1 = (QuotationOrderDetail) o1;
		QuotationOrderDetail p2 = (QuotationOrderDetail) o2;

		if (!p1.getOrderNo().equals(p2.getOrderNo())) {
			return p1.getOrderNo().compareTo(p2.getOrderNo());
		} else {
			return 0;
		}
	}
}
