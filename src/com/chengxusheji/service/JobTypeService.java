package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.chengxusheji.po.JobType;

import com.chengxusheji.mapper.JobTypeMapper;
@Service
public class JobTypeService {

	@Resource JobTypeMapper jobTypeMapper;
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

    /*添加职位类别记录*/
    public void addJobType(JobType jobType) throws Exception {
    	jobTypeMapper.addJobType(jobType);
    }

    /*按照查询条件分页查询职位类别记录*/
    public ArrayList<JobType> queryJobType(int currentPage) throws Exception { 
     	String where = "where 1=1";
    	int startIndex = (currentPage-1) * this.rows;
    	return jobTypeMapper.queryJobType(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<JobType> queryJobType() throws Exception  { 
     	String where = "where 1=1";
    	return jobTypeMapper.queryJobTypeList(where);
    }

    /*查询所有职位类别记录*/
    public ArrayList<JobType> queryAllJobType()  throws Exception {
        return jobTypeMapper.queryJobTypeList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber() throws Exception {
     	String where = "where 1=1";
        recordNumber = jobTypeMapper.queryJobTypeCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取职位类别记录*/
    public JobType getJobType(int jobTypeId) throws Exception  {
        JobType jobType = jobTypeMapper.getJobType(jobTypeId);
        return jobType;
    }

    /*更新职位类别记录*/
    public void updateJobType(JobType jobType) throws Exception {
        jobTypeMapper.updateJobType(jobType);
    }

    /*删除一条职位类别记录*/
    public void deleteJobType (int jobTypeId) throws Exception {
        jobTypeMapper.deleteJobType(jobTypeId);
    }

    /*删除多条职位类别信息*/
    public int deleteJobTypes (String jobTypeIds) throws Exception {
    	String _jobTypeIds[] = jobTypeIds.split(",");
    	for(String _jobTypeId: _jobTypeIds) {
    		jobTypeMapper.deleteJobType(Integer.parseInt(_jobTypeId));
    	}
    	return _jobTypeIds.length;
    }
}
