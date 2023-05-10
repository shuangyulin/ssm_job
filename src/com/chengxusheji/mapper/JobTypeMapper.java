package com.chengxusheji.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.chengxusheji.po.JobType;

public interface JobTypeMapper {
	/*添加职位类别信息*/
	public void addJobType(JobType jobType) throws Exception;

	/*按照查询条件分页查询职位类别记录*/
	public ArrayList<JobType> queryJobType(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有职位类别记录*/
	public ArrayList<JobType> queryJobTypeList(@Param("where") String where) throws Exception;

	/*按照查询条件的职位类别记录数*/
	public int queryJobTypeCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条职位类别记录*/
	public JobType getJobType(int jobTypeId) throws Exception;

	/*更新职位类别记录*/
	public void updateJobType(JobType jobType) throws Exception;

	/*删除职位类别记录*/
	public void deleteJobType(int jobTypeId) throws Exception;

}
