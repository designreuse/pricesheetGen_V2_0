/**
 * Copyright &copy; 2015-2020 <a href="http://www.SapLing.org/">SapLing</a> All rights reserved.
 */
package com.sapling.modules.sys.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sapling.common.service.TreeService;
import com.sapling.modules.sys.dao.AreaDao;
import com.sapling.modules.sys.entity.Area;
import com.sapling.modules.sys.utils.UserUtils;

/**
 * 区域Service
 * @author SapLing
 * @version 2014-05-16
 */
@Service
@Transactional(readOnly = true)
public class AreaService extends TreeService<AreaDao, Area> {

	public List<Area> findAll(){
		return UserUtils.getAreaList();
	}

	@Transactional(readOnly = false)
	public void save(Area area) {
		super.save(area);
		UserUtils.removeCache(UserUtils.CACHE_AREA_LIST);
	}
	
	@Transactional(readOnly = false)
	public void delete(Area area) {
		super.delete(area);
		UserUtils.removeCache(UserUtils.CACHE_AREA_LIST);
	}
	
}
