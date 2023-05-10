package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class Job {
    /*职位id*/
    private Integer jobId;
    public Integer getJobId(){
        return jobId;
    }
    public void setJobId(Integer jobId){
        this.jobId = jobId;
    }

    /*职位类别*/
    private JobType jobTypeObj;
    public JobType getJobTypeObj() {
        return jobTypeObj;
    }
    public void setJobTypeObj(JobType jobTypeObj) {
        this.jobTypeObj = jobTypeObj;
    }

    /*职位名称*/
    @NotEmpty(message="职位名称不能为空")
    private String jobName;
    public String getJobName() {
        return jobName;
    }
    public void setJobName(String jobName) {
        this.jobName = jobName;
    }

    /*职位描述*/
    @NotEmpty(message="职位描述不能为空")
    private String jobDesc;
    public String getJobDesc() {
        return jobDesc;
    }
    public void setJobDesc(String jobDesc) {
        this.jobDesc = jobDesc;
    }

    /*工作薪酬*/
    @NotEmpty(message="工作薪酬不能为空")
    private String salary;
    public String getSalary() {
        return salary;
    }
    public void setSalary(String salary) {
        this.salary = salary;
    }

    /*招聘人数*/
    @NotNull(message="必须输入招聘人数")
    private Integer zprs;
    public Integer getZprs() {
        return zprs;
    }
    public void setZprs(Integer zprs) {
        this.zprs = zprs;
    }

    /*学历要求*/
    @NotEmpty(message="学历要求不能为空")
    private String xlyq;
    public String getXlyq() {
        return xlyq;
    }
    public void setXlyq(String xlyq) {
        this.xlyq = xlyq;
    }

    /*有效期限*/
    @NotEmpty(message="有效期限不能为空")
    private String yxqx;
    public String getYxqx() {
        return yxqx;
    }
    public void setYxqx(String yxqx) {
        this.yxqx = yxqx;
    }

    /*工作区域*/
    @NotEmpty(message="工作区域不能为空")
    private String gzqy;
    public String getGzqy() {
        return gzqy;
    }
    public void setGzqy(String gzqy) {
        this.gzqy = gzqy;
    }

    /*工作地址*/
    @NotEmpty(message="工作地址不能为空")
    private String gzdz;
    public String getGzdz() {
        return gzdz;
    }
    public void setGzdz(String gzdz) {
        this.gzdz = gzdz;
    }

    /*浏览次数*/
    @NotNull(message="必须输入浏览次数")
    private Integer viewNum;
    public Integer getViewNum() {
        return viewNum;
    }
    public void setViewNum(Integer viewNum) {
        this.viewNum = viewNum;
    }

    /*发布企业*/
    private Company companyObj;
    public Company getCompanyObj() {
        return companyObj;
    }
    public void setCompanyObj(Company companyObj) {
        this.companyObj = companyObj;
    }

    /*发布时间*/
    @NotEmpty(message="发布时间不能为空")
    private String addTime;
    public String getAddTime() {
        return addTime;
    }
    public void setAddTime(String addTime) {
        this.addTime = addTime;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonJob=new JSONObject(); 
		jsonJob.accumulate("jobId", this.getJobId());
		jsonJob.accumulate("jobTypeObj", this.getJobTypeObj().getJobTypeName());
		jsonJob.accumulate("jobTypeObjPri", this.getJobTypeObj().getJobTypeId());
		jsonJob.accumulate("jobName", this.getJobName());
		jsonJob.accumulate("jobDesc", this.getJobDesc());
		jsonJob.accumulate("salary", this.getSalary());
		jsonJob.accumulate("zprs", this.getZprs());
		jsonJob.accumulate("xlyq", this.getXlyq());
		jsonJob.accumulate("yxqx", this.getYxqx());
		jsonJob.accumulate("gzqy", this.getGzqy());
		jsonJob.accumulate("gzdz", this.getGzdz());
		jsonJob.accumulate("viewNum", this.getViewNum());
		jsonJob.accumulate("companyObj", this.getCompanyObj().getCompanyName());
		jsonJob.accumulate("companyObjPri", this.getCompanyObj().getCompanyUserName());
		jsonJob.accumulate("addTime", this.getAddTime().length()>19?this.getAddTime().substring(0,19):this.getAddTime());
		return jsonJob;
    }}