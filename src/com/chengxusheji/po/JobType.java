package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class JobType {
    /*职位类型id*/
    private Integer jobTypeId;
    public Integer getJobTypeId(){
        return jobTypeId;
    }
    public void setJobTypeId(Integer jobTypeId){
        this.jobTypeId = jobTypeId;
    }

    /*职位类别名称*/
    @NotEmpty(message="职位类别名称不能为空")
    private String jobTypeName;
    public String getJobTypeName() {
        return jobTypeName;
    }
    public void setJobTypeName(String jobTypeName) {
        this.jobTypeName = jobTypeName;
    }

    /*职位类别描述*/
    @NotEmpty(message="职位类别描述不能为空")
    private String jobTypeDesc;
    public String getJobTypeDesc() {
        return jobTypeDesc;
    }
    public void setJobTypeDesc(String jobTypeDesc) {
        this.jobTypeDesc = jobTypeDesc;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonJobType=new JSONObject(); 
		jsonJobType.accumulate("jobTypeId", this.getJobTypeId());
		jsonJobType.accumulate("jobTypeName", this.getJobTypeName());
		jsonJobType.accumulate("jobTypeDesc", this.getJobTypeDesc());
		return jsonJobType;
    }}