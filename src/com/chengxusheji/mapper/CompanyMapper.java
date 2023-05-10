package com.chengxusheji.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.chengxusheji.po.Company;

public interface CompanyMapper {
	/*添加企业信息*/
	public void addCompany(Company company) throws Exception;

	/*按照查询条件分页查询企业记录*/
	public ArrayList<Company> queryCompany(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有企业记录*/
	public ArrayList<Company> queryCompanyList(@Param("where") String where) throws Exception;

	/*按照查询条件的企业记录数*/
	public int queryCompanyCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条企业记录*/
	public Company getCompany(String companyUserName) throws Exception;

	/*更新企业记录*/
	public void updateCompany(Company company) throws Exception;

	/*删除企业记录*/
	public void deleteCompany(String companyUserName) throws Exception;

}
