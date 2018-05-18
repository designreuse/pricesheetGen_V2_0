/**
 * Copyright &copy; 2015-2020 <a href="http://www.SapLing.org/">SapLing</a> All rights reserved.
 */
package com.sapling.modules.sys.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sapling.common.service.TreeService;
import com.sapling.modules.sys.dao.OfficeDao;
import com.sapling.modules.sys.entity.Office;
import com.sapling.modules.sys.utils.UserUtils;

/**
 * 机构Service
 * @author SapLing
 * @version 2014-05-16
 */
@Service
@Transactional(readOnly = true)
public class OfficeService extends TreeService<OfficeDao, Office> {

	@Autowired
	private OfficeDao OfficeDao;
	
	public List<Office> findAll(){
		return UserUtils.getOfficeList();
	}

	public List<Office> findList(Boolean isAll){
		if (isAll != null && isAll){
			return UserUtils.getOfficeAllList();
		}else{
			return UserUtils.getOfficeList();
		}
	}
	
	@Transactional(readOnly = true)
	public List<Office> findList(Office office){
		office.setParentIds(office.getParentIds()+"%");
		return dao.findByParentIdsLike(office);
	}
	
	@Transactional(readOnly = true)
	public Office getByCode(String code){
		return dao.getByCode(code);
	}
	
	@Transactional(readOnly = true)
	public Office getEntity(Office office){
		return dao.getEntity(office);
	}
	
	@Transactional(readOnly = false)
	public void save(Office office) {
		super.save(office);
		UserUtils.removeCache(UserUtils.CACHE_OFFICE_LIST);
	}
	
	@Transactional(readOnly = false)
	public void delete(Office office) {
		super.delete(office);
		UserUtils.removeCache(UserUtils.CACHE_OFFICE_LIST);
	}
	
	public List<Office> findAllListByCompany(String isXSCompany) {
		return OfficeDao.findAllListByCompany(isXSCompany);
	}

	public List<Office> findOfficeListByCompanyId(Office company) {
		return OfficeDao.findOfficeListByCompanyId(company);
	}
	
}
