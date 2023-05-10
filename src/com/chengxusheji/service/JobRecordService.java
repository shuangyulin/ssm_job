package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.chengxusheji.po.UserInfo;
import com.chengxusheji.po.JobRecord;

import com.chengxusheji.mapper.JobRecordMapper;
@Service
public class JobRecordService {

	@Resource JobRecordMapper jobRecordMapper;
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

    /*添加兼职记录记录*/
    public void addJobRecord(JobRecord jobRecord) throws Exception {
    	jobRecordMapper.addJobRecord(jobRecord);
    }

    /*按照查询条件分页查询兼职记录记录*/
    public ArrayList<JobRecord> queryJobRecord(String title,UserInfo userObj,String recordDate,int currentPage) throws Exception { 
     	String where = "where 1=1";
    	if(!title.equals("")) where = where + " and t_jobRecord.title like '%" + title + "%'";
    	if(null != userObj &&  userObj.getUser_name() != null  && !userObj.getUser_name().equals(""))  where += " and t_jobRecord.userObj='" + userObj.getUser_name() + "'";
    	if(!recordDate.equals("")) where = where + " and t_jobRecord.recordDate like '%" + recordDate + "%'";
    	int startIndex = (currentPage-1) * this.rows;
    	return jobRecordMapper.queryJobRecord(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<JobRecord> queryJobRecord(String title,UserInfo userObj,String recordDate) throws Exception  { 
     	String where = "where 1=1";
    	if(!title.equals("")) where = where + " and t_jobRecord.title like '%" + title + "%'";
    	if(null != userObj &&  userObj.getUser_name() != null && !userObj.getUser_name().equals(""))  where += " and t_jobRecord.userObj='" + userObj.getUser_name() + "'";
    	if(!recordDate.equals("")) where = where + " and t_jobRecord.recordDate like '%" + recordDate + "%'";
    	return jobRecordMapper.queryJobRecordList(where);
    }

    /*查询所有兼职记录记录*/
    public ArrayList<JobRecord> queryAllJobRecord()  throws Exception {
        return jobRecordMapper.queryJobRecordList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber(String title,UserInfo userObj,String recordDate) throws Exception {
     	String where = "where 1=1";
    	if(!title.equals("")) where = where + " and t_jobRecord.title like '%" + title + "%'";
    	if(null != userObj &&  userObj.getUser_name() != null && !userObj.getUser_name().equals(""))  where += " and t_jobRecord.userObj='" + userObj.getUser_name() + "'";
    	if(!recordDate.equals("")) where = where + " and t_jobRecord.recordDate like '%" + recordDate + "%'";
        recordNumber = jobRecordMapper.queryJobRecordCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取兼职记录记录*/
    public JobRecord getJobRecord(int recordId) throws Exception  {
        JobRecord jobRecord = jobRecordMapper.getJobRecord(recordId);
        return jobRecord;
    }

    /*更新兼职记录记录*/
    public void updateJobRecord(JobRecord jobRecord) throws Exception {
        jobRecordMapper.updateJobRecord(jobRecord);
    }

    /*删除一条兼职记录记录*/
    public void deleteJobRecord (int recordId) throws Exception {
        jobRecordMapper.deleteJobRecord(recordId);
    }

    /*删除多条兼职记录信息*/
    public int deleteJobRecords (String recordIds) throws Exception {
    	String _recordIds[] = recordIds.split(",");
    	for(String _recordId: _recordIds) {
    		jobRecordMapper.deleteJobRecord(Integer.parseInt(_recordId));
    	}
    	return _recordIds.length;
    }
}
