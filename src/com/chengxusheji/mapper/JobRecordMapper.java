package com.chengxusheji.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.chengxusheji.po.JobRecord;

public interface JobRecordMapper {
	/*添加兼职记录信息*/
	public void addJobRecord(JobRecord jobRecord) throws Exception;

	/*按照查询条件分页查询兼职记录记录*/
	public ArrayList<JobRecord> queryJobRecord(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有兼职记录记录*/
	public ArrayList<JobRecord> queryJobRecordList(@Param("where") String where) throws Exception;

	/*按照查询条件的兼职记录记录数*/
	public int queryJobRecordCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条兼职记录记录*/
	public JobRecord getJobRecord(int recordId) throws Exception;

	/*更新兼职记录记录*/
	public void updateJobRecord(JobRecord jobRecord) throws Exception;

	/*删除兼职记录记录*/
	public void deleteJobRecord(int recordId) throws Exception;

}
