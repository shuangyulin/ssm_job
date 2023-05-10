package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.chengxusheji.po.Job;
import com.chengxusheji.po.UserInfo;
import com.chengxusheji.po.Delivery;

import com.chengxusheji.mapper.DeliveryMapper;
@Service
public class DeliveryService {

	@Resource DeliveryMapper deliveryMapper;
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

    /*添加简历投递记录*/
    public void addDelivery(Delivery delivery) throws Exception {
    	deliveryMapper.addDelivery(delivery);
    }

    /*按照查询条件分页查询简历投递记录*/
    public ArrayList<Delivery> queryDelivery(Job jobObj,UserInfo userObj,String deliveryTime,String handleTime,String clzt,int currentPage) throws Exception { 
     	String where = "where 1=1";
    	if(null != jobObj && jobObj.getJobId()!= null && jobObj.getJobId()!= 0)  where += " and t_delivery.jobObj=" + jobObj.getJobId();
    	if(null != userObj &&  userObj.getUser_name() != null  && !userObj.getUser_name().equals(""))  where += " and t_delivery.userObj='" + userObj.getUser_name() + "'";
    	if(!deliveryTime.equals("")) where = where + " and t_delivery.deliveryTime like '%" + deliveryTime + "%'";
    	if(!handleTime.equals("")) where = where + " and t_delivery.handleTime like '%" + handleTime + "%'";
    	if(!clzt.equals("")) where = where + " and t_delivery.clzt like '%" + clzt + "%'";
    	int startIndex = (currentPage-1) * this.rows;
    	return deliveryMapper.queryDelivery(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<Delivery> queryDelivery(Job jobObj,UserInfo userObj,String deliveryTime,String handleTime,String clzt) throws Exception  { 
     	String where = "where 1=1";
    	if(null != jobObj && jobObj.getJobId()!= null && jobObj.getJobId()!= 0)  where += " and t_delivery.jobObj=" + jobObj.getJobId();
    	if(null != userObj &&  userObj.getUser_name() != null && !userObj.getUser_name().equals(""))  where += " and t_delivery.userObj='" + userObj.getUser_name() + "'";
    	if(!deliveryTime.equals("")) where = where + " and t_delivery.deliveryTime like '%" + deliveryTime + "%'";
    	if(!handleTime.equals("")) where = where + " and t_delivery.handleTime like '%" + handleTime + "%'";
    	if(!clzt.equals("")) where = where + " and t_delivery.clzt like '%" + clzt + "%'";
    	return deliveryMapper.queryDeliveryList(where);
    }

    /*查询所有简历投递记录*/
    public ArrayList<Delivery> queryAllDelivery()  throws Exception {
        return deliveryMapper.queryDeliveryList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber(Job jobObj,UserInfo userObj,String deliveryTime,String handleTime,String clzt) throws Exception {
     	String where = "where 1=1";
    	if(null != jobObj && jobObj.getJobId()!= null && jobObj.getJobId()!= 0)  where += " and t_delivery.jobObj=" + jobObj.getJobId();
    	if(null != userObj &&  userObj.getUser_name() != null && !userObj.getUser_name().equals(""))  where += " and t_delivery.userObj='" + userObj.getUser_name() + "'";
    	if(!deliveryTime.equals("")) where = where + " and t_delivery.deliveryTime like '%" + deliveryTime + "%'";
    	if(!handleTime.equals("")) where = where + " and t_delivery.handleTime like '%" + handleTime + "%'";
    	if(!clzt.equals("")) where = where + " and t_delivery.clzt like '%" + clzt + "%'";
        recordNumber = deliveryMapper.queryDeliveryCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取简历投递记录*/
    public Delivery getDelivery(int deliveryId) throws Exception  {
        Delivery delivery = deliveryMapper.getDelivery(deliveryId);
        return delivery;
    }

    /*更新简历投递记录*/
    public void updateDelivery(Delivery delivery) throws Exception {
        deliveryMapper.updateDelivery(delivery);
    }

    /*删除一条简历投递记录*/
    public void deleteDelivery (int deliveryId) throws Exception {
        deliveryMapper.deleteDelivery(deliveryId);
    }

    /*删除多条简历投递信息*/
    public int deleteDeliverys (String deliveryIds) throws Exception {
    	String _deliveryIds[] = deliveryIds.split(",");
    	for(String _deliveryId: _deliveryIds) {
    		deliveryMapper.deleteDelivery(Integer.parseInt(_deliveryId));
    	}
    	return _deliveryIds.length;
    }
}
