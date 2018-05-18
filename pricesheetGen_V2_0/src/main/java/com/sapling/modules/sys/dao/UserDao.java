/**
 * Copyright &copy; 2015-2020 <a href="http://www.SapLing.org/">SapLing</a> All rights reserved.
 */
package com.sapling.modules.sys.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.sapling.common.persistence.CrudDao;
import com.sapling.common.persistence.annotation.MyBatisDao;
import com.sapling.modules.sys.entity.User;

/**
 * 用户DAO接口
 * @author SapLing
 * @version 2014-05-16
 */
@MyBatisDao
public interface UserDao extends CrudDao<User> {
	
	/**
	 * 根据登录名称查询用户
	 * @param loginName
	 * @return
	 */
	public User getByLoginName(User user);

	/**
	 * 通过OfficeId获取用户列表，仅返回用户id和name（树查询用户时用）
	 * @param user
	 * @return
	 */
	public List<User> findUserByOfficeId(User user);
	
	/**
	 * 查询全部用户数目
	 * @return
	 */
	public long findAllCount(User user);
	
	/**
	 * 更新用户密码
	 * @param user
	 * @return
	 */
	public int updatePasswordById(User user);
	
	/**
	 * 更新登录信息，如：登录IP、登录时间
	 * @param user
	 * @return
	 */
	public int updateLoginInfo(User user);

	/**
	 * 删除用户角色关联数据
	 * @param user
	 * @return
	 */
	public int deleteUserRole(User user);
	
	/**
	 * 插入用户角色关联数据
	 * @param user
	 * @return
	 */
	public int insertUserRole(User user);
	
	/**
	 * 更新用户信息
	 * @param user
	 * @return
	 */
	public int updateUserInfo(User user);
	
	/**
	 * 插入好友
	 */
	public int insertFriend(@Param("id")String id, @Param("userId")String userId, @Param("friendId")String friendId);
	
	/**
	 * 查找好友
	 */
	public User findFriend(@Param("userId")String userId, @Param("friendId")String friendId);
	/**
	 * 删除好友
	 */
	public void deleteFriend(@Param("userId")String userId, @Param("friendId")String friendId);
	
	/**
	 * 
	 * 获取我的好友列表
	 * 
	 */
	public List<User> findFriends(User currentUser);
	
	/**
	 * 
	 * 查询用户-->用来添加到常用联系人
	 * 
	 */
	public List<User> searchUsers(User user);
	
	/**
	 * 
	 */
	
	public List<User>  findListByOffice(User user);

	/**
	 * 添加手机短信验证码
	 * @param phone
	 * @param code
	 * @return
	 */
	public int savePhoneCode(@Param("id")String id,@Param("phone")String phone, @Param("code")String code);
	
	/**
	 * 新增用户
	 * @param user
	 * @return
	 */
	public int  saveUser(User user);

	/**
	 * 根据手机号码查询用户
	 * @param phone
	 * @return
	 */
	public User findUserByPhone(User user);

	/**
	 * 检验手机验证码
	 * @param phone
	 * @param code
	 * @return
	 */
	public long exitSMSCodeByCodePhone(@Param("phone")String phone, @Param("code")String code,@Param("status")String status);

	/**
	 * 更改手机验证码状态
	 * @param phone
	 * @param code
	 * @param string
	 */
	public void updateSMSCodeByCodePhone(@Param("phone")String phone, @Param("code")String code);

	/**
	 * 修改手机号码
	 * @param user
	 * @return
	 */
	public long updateUserPhone(@Param("phone")String phone,@Param("newPhone")String newPhone);
	/**
	 * 修改用户密码
	 * @param user
	 * @return
	 */
	public long updateUserPassword(@Param("phone")String phone,@Param("newPassword")String newPassword);
	/**
	 * 修改用户资料
	 * @param user
	 * @return
	 */
	public int updateFrontUser(User user);


	/**
	 * 根据手机号码查询用户
	 * @param loginName
	 * @return
	 */
	public User getByPhone(User iuser);
	
	/**
	 * 根据角色获取用户
	 * @param string
	 * @return
	 */
	public List<User> findUserRuleCodeOrId(@Param("roleCode")String roleCode);

	public List<User> findCustomersByUserId(@Param("userId")String userId);

	public List<User> findNotSelectCustomers(User user);

	public void insertUserCustomer(@Param("userId")String userId, @Param("customerId")String customerId);

	public void deleteUserCustomer(@Param("userId")String userId,@Param("customerId")String customerId);

	public List<User> findUserByCustomerId(@Param("customerId")String id);
}
