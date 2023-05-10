package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.chengxusheji.po.Company;

import com.chengxusheji.mapper.CompanyMapper;
@Service
public class CompanyService {

	@Resource CompanyMapper companyMapper;
    /*每页显示记录数目*/
    private int rows = 10;;
    public int getRows() {
		return rows;
	}
	public void setRows(int rows) {
		this.rows = rows;
	}

    /*保存查询后总的页数*/
    private int totalPage;
    public void setTotalPage(int totalPage) {
        this.totalPage = totalPage;
    }
    public int getTotalPage() {
        return totalPage;
    }

    /*保存查询到的总记录数*/
    private int recordNumber;
    public void setRecordNumber(int recordNumber) {
        this.recordNumber = recordNumber;
    }
    public int getRecordNumber() {
        return recordNumber;
    }

    /*添加企业记录*/
    public void addCompany(Company company) throws Exception {
    	companyMapper.addCompany(company);
    }

    /*按照查询条件分页查询企业记录*/
    public ArrayList<Company> queryCompany(String qyjb,String companyName,String gszch,String gsxz,String gsgm,String gghy,String lxr,String lxdh,String shzt,int currentPage) throws Exception { 
     	String where = "where 1=1";
    	if(!qyjb.equals("")) where = where + " and t_company.qyjb like '%" + qyjb + "%'";
    	if(!companyName.equals("")) where = where + " and t_company.companyName like '%" + companyName + "%'";
    	if(!gszch.equals("")) where = where + " and t_company.gszch like '%" + gszch + "%'";
    	if(!gsxz.equals("")) where = where + " and t_company.gsxz like '%" + gsxz + "%'";
    	if(!gsgm.equals("")) where = where + " and t_company.gsgm like '%" + gsgm + "%'";
    	if(!gghy.equals("")) where = where + " and t_company.gghy like '%" + gghy + "%'";
    	if(!lxr.equals("")) where = where + " and t_company.lxr like '%" + lxr + "%'";
    	if(!lxdh.equals("")) where = where + " and t_company.lxdh like '%" + lxdh + "%'";
    	if(!shzt.equals("")) where = where + " and t_company.shzt like '%" + shzt + "%'";
    	int startIndex = (currentPage-1) * this.rows;
    	return companyMapper.queryCompany(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<Company> queryCompany(String qyjb,String companyName,String gszch,String gsxz,String gsgm,String gghy,String lxr,String lxdh,String shzt) throws Exception  { 
     	String where = "where 1=1";
    	if(!qyjb.equals("")) where = where + " and t_company.qyjb like '%" + qyjb + "%'";
    	if(!companyName.equals("")) where = where + " and t_company.companyName like '%" + companyName + "%'";
    	if(!gszch.equals("")) where = where + " and t_company.gszch like '%" + gszch + "%'";
    	if(!gsxz.equals("")) where = where + " and t_company.gsxz like '%" + gsxz + "%'";
    	if(!gsgm.equals("")) where = where + " and t_company.gsgm like '%" + gsgm + "%'";
    	if(!gghy.equals("")) where = where + " and t_company.gghy like '%" + gghy + "%'";
    	if(!lxr.equals("")) where = where + " and t_company.lxr like '%" + lxr + "%'";
    	if(!lxdh.equals("")) where = where + " and t_company.lxdh like '%" + lxdh + "%'";
    	if(!shzt.equals("")) where = where + " and t_company.shzt like '%" + shzt + "%'";
    	return companyMapper.queryCompanyList(where);
    }

    /*查询所有企业记录*/
    public ArrayList<Company> queryAllCompany()  throws Exception {
        return companyMapper.queryCompanyList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber(String qyjb,String companyName,String gszch,String gsxz,String gsgm,String gghy,String lxr,String lxdh,String shzt) throws Exception {
     	String where = "where 1=1";
    	if(!qyjb.equals("")) where = where + " and t_company.qyjb like '%" + qyjb + "%'";
    	if(!companyName.equals("")) where = where + " and t_company.companyName like '%" + companyName + "%'";
    	if(!gszch.equals("")) where = where + " and t_company.gszch like '%" + gszch + "%'";
    	if(!gsxz.equals("")) where = where + " and t_company.gsxz like '%" + gsxz + "%'";
    	if(!gsgm.equals("")) where = where + " and t_company.gsgm like '%" + gsgm + "%'";
    	if(!gghy.equals("")) where = where + " and t_company.gghy like '%" + gghy + "%'";
    	if(!lxr.equals("")) where = where + " and t_company.lxr like '%" + lxr + "%'";
    	if(!lxdh.equals("")) where = where + " and t_company.lxdh like '%" + lxdh + "%'";
    	if(!shzt.equals("")) where = where + " and t_company.shzt like '%" + shzt + "%'";
        recordNumber = companyMapper.queryCompanyCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取企业记录*/
    public Company getCompany(String companyUserName) throws Exception  {
        Company company = companyMapper.getCompany(companyUserName);
        return company;
    }

    /*更新企业记录*/
    public void updateCompany(Company company) throws Exception {
        companyMapper.updateCompany(company);
    }

    /*删除一条企业记录*/
    public void deleteCompany (String companyUserName) throws Exception {
        companyMapper.deleteCompany(companyUserName);
    }

    /*删除多条企业信息*/
    public int deleteCompanys (String companyUserNames) throws Exception {
    	String _companyUserNames[] = companyUserNames.split(",");
    	for(String _companyUserName: _companyUserNames) {
    		companyMapper.deleteCompany(_companyUserName);
    	}
    	return _companyUserNames.length;
    }
}
