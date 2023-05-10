package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class Delivery {
    /*投递id*/
    private Integer deliveryId;
    public Integer getDeliveryId(){
        return deliveryId;
    }
    public void setDeliveryId(Integer deliveryId){
        this.deliveryId = deliveryId;
    }

    /*应聘职位*/
    private Job jobObj;
    public Job getJobObj() {
        return jobObj;
    }
    public void setJobObj(Job jobObj) {
        this.jobObj = jobObj;
    }

    /*应聘人*/
    private UserInfo userObj;
    public UserInfo getUserObj() {
        return userObj;
    }
    public void setUserObj(UserInfo userObj) {
        this.userObj = userObj;
    }

    /*投递时间*/
    @NotEmpty(message="投递时间不能为空")
    private String deliveryTime;
    public String getDeliveryTime() {
        return deliveryTime;
    }
    public void setDeliveryTime(String deliveryTime) {
        this.deliveryTime = deliveryTime;
    }

    /*处理时间*/
    @NotEmpty(message="处理时间不能为空")
    private String handleTime;
    public String getHandleTime() {
        return handleTime;
    }
    public void setHandleTime(String handleTime) {
        this.handleTime = handleTime;
    }

    /*处理状态*/
    @NotEmpty(message="处理状态不能为空")
    private String clzt;
    public String getClzt() {
        return clzt;
    }
    public void setClzt(String clzt) {
        this.clzt = clzt;
    }

    /*通知信息*/
    @NotEmpty(message="通知信息不能为空")
    private String tzxx;
    public String getTzxx() {
        return tzxx;
    }
    public void setTzxx(String tzxx) {
        this.tzxx = tzxx;
    }

    /*工作评价*/
    @NotEmpty(message="工作评价不能为空")
    private String gzpj;
    public String getGzpj() {
        return gzpj;
    }
    public void setGzpj(String gzpj) {
        this.gzpj = gzpj;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonDelivery=new JSONObject(); 
		jsonDelivery.accumulate("deliveryId", this.getDeliveryId());
		jsonDelivery.accumulate("jobObj", this.getJobObj().getJobName());
		jsonDelivery.accumulate("jobObjPri", this.getJobObj().getJobId());
		jsonDelivery.accumulate("userObj", this.getUserObj().getName());
		jsonDelivery.accumulate("userObjPri", this.getUserObj().getUser_name());
		jsonDelivery.accumulate("deliveryTime", this.getDeliveryTime().length()>19?this.getDeliveryTime().substring(0,19):this.getDeliveryTime());
		jsonDelivery.accumulate("handleTime", this.getHandleTime().length()>19?this.getHandleTime().substring(0,19):this.getHandleTime());
		jsonDelivery.accumulate("clzt", this.getClzt());
		jsonDelivery.accumulate("tzxx", this.getTzxx());
		jsonDelivery.accumulate("gzpj", this.getGzpj());
		return jsonDelivery;
    }}