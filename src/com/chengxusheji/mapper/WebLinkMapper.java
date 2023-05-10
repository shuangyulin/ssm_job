package com.chengxusheji.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.chengxusheji.po.WebLink;

public interface WebLinkMapper {
	/*添加友情链接信息*/
	public void addWebLink(WebLink webLink) throws Exception;

	/*按照查询条件分页查询友情链接记录*/
	public ArrayList<WebLink> queryWebLink(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有友情链接记录*/
	public ArrayList<WebLink> queryWebLinkList(@Param("where") String where) throws Exception;

	/*按照查询条件的友情链接记录数*/
	public int queryWebLinkCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条友情链接记录*/
	public WebLink getWebLink(int linkId) throws Exception;

	/*更新友情链接记录*/
	public void updateWebLink(WebLink webLink) throws Exception;

	/*删除友情链接记录*/
	public void deleteWebLink(int linkId) throws Exception;

}
