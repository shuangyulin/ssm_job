package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class JobRecord {
    /*记录id*/
    private Integer recordId;
    public Integer getRecordId(){
        return recordId;
    }
    public void setRecordId(Integer recordId){
        this.recordId = recordId;
    }

    /*标题*/
    @NotEmpty(message="标题不能为空")
    private String title;
    public String getTitle() {
        return title;
    }
    public void setTitle(String title) {
        this.title = title;
    }

    /*内容*/
    @NotEmpty(message="内容不能为空")
    private String content;
    public String getContent() {
        return content;
    }
    public void setContent(String content) {
        this.content = content;
    }

    /*记录人*/
    private UserInfo userObj;
    public UserInfo getUserObj() {
        return userObj;
    }
    public void setUserObj(UserInfo userObj) {
        this.userObj = userObj;
    }

    /*记录时间*/
    @NotEmpty(message="记录时间不能为空")
    private String recordDate;
    public String getRecordDate() {
        return recordDate;
    }
    public void setRecordDate(String recordDate) {
        this.recordDate = recordDate;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonJobRecord=new JSONObject(); 
		jsonJobRecord.accumulate("recordId", this.getRecordId());
		jsonJobRecord.accumulate("title", this.getTitle());
		jsonJobRecord.accumulate("content", this.getContent());
		jsonJobRecord.accumulate("userObj", this.getUserObj().getName());
		jsonJobRecord.accumulate("userObjPri", this.getUserObj().getUser_name());
		jsonJobRecord.accumulate("recordDate", this.getRecordDate().length()>19?this.getRecordDate().substring(0,19):this.getRecordDate());
		return jsonJobRecord;
    }}