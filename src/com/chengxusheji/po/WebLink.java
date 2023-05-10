package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class WebLink {
    /*记录id*/
    private Integer linkId;
    public Integer getLinkId(){
        return linkId;
    }
    public void setLinkId(Integer linkId){
        this.linkId = linkId;
    }

    /*网站名称*/
    @NotEmpty(message="网站名称不能为空")
    private String webName;
    public String getWebName() {
        return webName;
    }
    public void setWebName(String webName) {
        this.webName = webName;
    }

    /*网站Logo*/
    private String webLogo;
    public String getWebLogo() {
        return webLogo;
    }
    public void setWebLogo(String webLogo) {
        this.webLogo = webLogo;
    }

    /*网站地址*/
    @NotEmpty(message="网站地址不能为空")
    private String webAddress;
    public String getWebAddress() {
        return webAddress;
    }
    public void setWebAddress(String webAddress) {
        this.webAddress = webAddress;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonWebLink=new JSONObject(); 
		jsonWebLink.accumulate("linkId", this.getLinkId());
		jsonWebLink.accumulate("webName", this.getWebName());
		jsonWebLink.accumulate("webLogo", this.getWebLogo());
		jsonWebLink.accumulate("webAddress", this.getWebAddress());
		return jsonWebLink;
    }}