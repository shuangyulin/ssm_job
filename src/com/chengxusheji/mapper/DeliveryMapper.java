package com.chengxusheji.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.chengxusheji.po.Delivery;

public interface DeliveryMapper {
	/*添加简历投递信息*/
	public void addDelivery(Delivery delivery) throws Exception;

	/*按照查询条件分页查询简历投递记录*/
	public ArrayList<Delivery> queryDelivery(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有简历投递记录*/
	public ArrayList<Delivery> queryDeliveryList(@Param("where") String where) throws Exception;

	/*按照查询条件的简历投递记录数*/
	public int queryDeliveryCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条简历投递记录*/
	public Delivery getDelivery(int deliveryId) throws Exception;

	/*更新简历投递记录*/
	public void updateDelivery(Delivery delivery) throws Exception;

	/*删除简历投递记录*/
	public void deleteDelivery(int deliveryId) throws Exception;

}
