package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.chengxusheji.po.WebLink;

import com.chengxusheji.mapper.WebLinkMapper;
@Service
public class WebLinkService {

	@Resource WebLinkMapper webLinkMapper;
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

    /*添加友情链接记录*/
    public void addWebLink(WebLink webLink) throws Exception {
    	webLinkMapper.addWebLink(webLink);
    }

    /*按照查询条件分页查询友情链接记录*/
    public ArrayList<WebLink> queryWebLink(int currentPage) throws Exception { 
     	String where = "where 1=1";
    	int startIndex = (currentPage-1) * this.rows;
    	return webLinkMapper.queryWebLink(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<WebLink> queryWebLink() throws Exception  { 
     	String where = "where 1=1";
    	return webLinkMapper.queryWebLinkList(where);
    }

    /*查询所有友情链接记录*/
    public ArrayList<WebLink> queryAllWebLink()  throws Exception {
        return webLinkMapper.queryWebLinkList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber() throws Exception {
     	String where = "where 1=1";
        recordNumber = webLinkMapper.queryWebLinkCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取友情链接记录*/
    public WebLink getWebLink(int linkId) throws Exception  {
        WebLink webLink = webLinkMapper.getWebLink(linkId);
        return webLink;
    }

    /*更新友情链接记录*/
    public void updateWebLink(WebLink webLink) throws Exception {
        webLinkMapper.updateWebLink(webLink);
    }

    /*删除一条友情链接记录*/
    public void deleteWebLink (int linkId) throws Exception {
        webLinkMapper.deleteWebLink(linkId);
    }

    /*删除多条友情链接信息*/
    public int deleteWebLinks (String linkIds) throws Exception {
    	String _linkIds[] = linkIds.split(",");
    	for(String _linkId: _linkIds) {
    		webLinkMapper.deleteWebLink(Integer.parseInt(_linkId));
    	}
    	return _linkIds.length;
    }
}
