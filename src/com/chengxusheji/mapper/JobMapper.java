package com.chengxusheji.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.chengxusheji.po.Job;

public interface JobMapper {
	/*添加职位信息*/
	public void addJob(Job job) throws Exception;

	/*按照查询条件分页查询职位记录*/
	public ArrayList<Job> queryJob(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有职位记录*/
	public ArrayList<Job> queryJobList(@Param("where") String where) throws Exception;

	/*按照查询条件的职位记录数*/
	public int queryJobCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条职位记录*/
	public Job getJob(int jobId) throws Exception;

	/*更新职位记录*/
	public void updateJob(Job job) throws Exception;

	/*删除职位记录*/
	public void deleteJob(int jobId) throws Exception;

}
