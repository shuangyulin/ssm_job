package com.chengxusheji.controller;

import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import com.chengxusheji.utils.ExportExcelUtil;
import com.chengxusheji.utils.UserException;
import com.chengxusheji.service.DeliveryService;
import com.chengxusheji.po.Delivery;
import com.chengxusheji.service.JobService;
import com.chengxusheji.po.Job;
import com.chengxusheji.service.UserInfoService;
import com.chengxusheji.po.UserInfo;

//Delivery管理控制层
@Controller
@RequestMapping("/Delivery")
public class DeliveryController extends BaseController {

    /*业务层对象*/
    @Resource DeliveryService deliveryService;

    @Resource JobService jobService;
    @Resource UserInfoService userInfoService;
	@InitBinder("jobObj")
	public void initBinderjobObj(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("jobObj.");
	}
	@InitBinder("userObj")
	public void initBinderuserObj(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("userObj.");
	}
	@InitBinder("delivery")
	public void initBinderDelivery(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("delivery.");
	}
	/*跳转到添加Delivery视图*/
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model,HttpServletRequest request) throws Exception {
		model.addAttribute(new Delivery());
		/*查询所有的Job信息*/
		List<Job> jobList = jobService.queryAllJob();
		request.setAttribute("jobList", jobList);
		/*查询所有的UserInfo信息*/
		List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
		request.setAttribute("userInfoList", userInfoList);
		return "Delivery_add";
	}

	/*客户端ajax方式提交添加简历投递信息*/
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public void add(@Validated Delivery delivery, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
		boolean success = false;
		if (br.hasErrors()) {
			message = "输入信息不符合要求！";
			writeJsonResponse(response, success, message);
			return ;
		}
        deliveryService.addDelivery(delivery);
        message = "简历投递添加成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	/*ajax方式按照查询条件分页查询简历投递信息*/
	@RequestMapping(value = { "/list" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void list(@ModelAttribute("jobObj") Job jobObj,@ModelAttribute("userObj") UserInfo userObj,String deliveryTime,String handleTime,String clzt,Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		if (page==null || page == 0) page = 1;
		if (deliveryTime == null) deliveryTime = "";
		if (handleTime == null) handleTime = "";
		if (clzt == null) clzt = "";
		if(rows != 0)deliveryService.setRows(rows);
		List<Delivery> deliveryList = deliveryService.queryDelivery(jobObj, userObj, deliveryTime, handleTime, clzt, page);
	    /*计算总的页数和总的记录数*/
	    deliveryService.queryTotalPageAndRecordNumber(jobObj, userObj, deliveryTime, handleTime, clzt);
	    /*获取到总的页码数目*/
	    int totalPage = deliveryService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = deliveryService.getRecordNumber();
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象
		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(Delivery delivery:deliveryList) {
			JSONObject jsonDelivery = delivery.getJsonObject();
			jsonArray.put(jsonDelivery);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}

	/*ajax方式按照查询条件分页查询简历投递信息*/
	@RequestMapping(value = { "/listAll" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void listAll(HttpServletResponse response) throws Exception {
		List<Delivery> deliveryList = deliveryService.queryAllDelivery();
        response.setContentType("text/json;charset=UTF-8"); 
		PrintWriter out = response.getWriter();
		JSONArray jsonArray = new JSONArray();
		for(Delivery delivery:deliveryList) {
			JSONObject jsonDelivery = new JSONObject();
			jsonDelivery.accumulate("deliveryId", delivery.getDeliveryId());
			jsonArray.put(jsonDelivery);
		}
		out.println(jsonArray.toString());
		out.flush();
		out.close();
	}

	/*前台按照查询条件分页查询简历投递信息*/
	@RequestMapping(value = { "/frontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String frontlist(@ModelAttribute("jobObj") Job jobObj,@ModelAttribute("userObj") UserInfo userObj,String deliveryTime,String handleTime,String clzt,Integer currentPage, Model model, HttpServletRequest request) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		if (deliveryTime == null) deliveryTime = "";
		if (handleTime == null) handleTime = "";
		if (clzt == null) clzt = "";
		List<Delivery> deliveryList = deliveryService.queryDelivery(jobObj, userObj, deliveryTime, handleTime, clzt, currentPage);
	    /*计算总的页数和总的记录数*/
	    deliveryService.queryTotalPageAndRecordNumber(jobObj, userObj, deliveryTime, handleTime, clzt);
	    /*获取到总的页码数目*/
	    int totalPage = deliveryService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = deliveryService.getRecordNumber();
	    request.setAttribute("deliveryList",  deliveryList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
	    request.setAttribute("jobObj", jobObj);
	    request.setAttribute("userObj", userObj);
	    request.setAttribute("deliveryTime", deliveryTime);
	    request.setAttribute("handleTime", handleTime);
	    request.setAttribute("clzt", clzt);
	    List<Job> jobList = jobService.queryAllJob();
	    request.setAttribute("jobList", jobList);
	    List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
	    request.setAttribute("userInfoList", userInfoList);
		return "Delivery/delivery_frontquery_result"; 
	}

     /*前台查询Delivery信息*/
	@RequestMapping(value="/{deliveryId}/frontshow",method=RequestMethod.GET)
	public String frontshow(@PathVariable Integer deliveryId,Model model,HttpServletRequest request) throws Exception {
		/*根据主键deliveryId获取Delivery对象*/
        Delivery delivery = deliveryService.getDelivery(deliveryId);

        List<Job> jobList = jobService.queryAllJob();
        request.setAttribute("jobList", jobList);
        List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
        request.setAttribute("userInfoList", userInfoList);
        request.setAttribute("delivery",  delivery);
        return "Delivery/delivery_frontshow";
	}

	/*ajax方式显示简历投递修改jsp视图页*/
	@RequestMapping(value="/{deliveryId}/update",method=RequestMethod.GET)
	public void update(@PathVariable Integer deliveryId,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
        /*根据主键deliveryId获取Delivery对象*/
        Delivery delivery = deliveryService.getDelivery(deliveryId);

        response.setContentType("text/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象 
		JSONObject jsonDelivery = delivery.getJsonObject();
		out.println(jsonDelivery.toString());
		out.flush();
		out.close();
	}

	/*ajax方式更新简历投递信息*/
	@RequestMapping(value = "/{deliveryId}/update", method = RequestMethod.POST)
	public void update(@Validated Delivery delivery, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
    	boolean success = false;
		if (br.hasErrors()) { 
			message = "输入的信息有错误！";
			writeJsonResponse(response, success, message);
			return;
		}
		try {
			deliveryService.updateDelivery(delivery);
			message = "简历投递更新成功!";
			success = true;
			writeJsonResponse(response, success, message);
		} catch (Exception e) {
			e.printStackTrace();
			message = "简历投递更新失败!";
			writeJsonResponse(response, success, message); 
		}
	}
    /*删除简历投递信息*/
	@RequestMapping(value="/{deliveryId}/delete",method=RequestMethod.GET)
	public String delete(@PathVariable Integer deliveryId,HttpServletRequest request) throws UnsupportedEncodingException {
		  try {
			  deliveryService.deleteDelivery(deliveryId);
	            request.setAttribute("message", "简历投递删除成功!");
	            return "message";
	        } catch (Exception e) { 
	            e.printStackTrace();
	            request.setAttribute("error", "简历投递删除失败!");
				return "error";

	        }

	}

	/*ajax方式删除多条简历投递记录*/
	@RequestMapping(value="/deletes",method=RequestMethod.POST)
	public void delete(String deliveryIds,HttpServletRequest request,HttpServletResponse response) throws IOException, JSONException {
		String message = "";
    	boolean success = false;
        try { 
        	int count = deliveryService.deleteDeliverys(deliveryIds);
        	success = true;
        	message = count + "条记录删除成功";
        	writeJsonResponse(response, success, message);
        } catch (Exception e) { 
            //e.printStackTrace();
            message = "有记录存在外键约束,删除失败";
            writeJsonResponse(response, success, message);
        }
	}

	/*按照查询条件导出简历投递信息到Excel*/
	@RequestMapping(value = { "/OutToExcel" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void OutToExcel(@ModelAttribute("jobObj") Job jobObj,@ModelAttribute("userObj") UserInfo userObj,String deliveryTime,String handleTime,String clzt, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
        if(deliveryTime == null) deliveryTime = "";
        if(handleTime == null) handleTime = "";
        if(clzt == null) clzt = "";
        List<Delivery> deliveryList = deliveryService.queryDelivery(jobObj,userObj,deliveryTime,handleTime,clzt);
        ExportExcelUtil ex = new ExportExcelUtil();
        String _title = "Delivery信息记录"; 
        String[] headers = { "投递id","应聘职位","应聘人","投递时间","处理时间","处理状态","通知信息","工作评价"};
        List<String[]> dataset = new ArrayList<String[]>(); 
        for(int i=0;i<deliveryList.size();i++) {
        	Delivery delivery = deliveryList.get(i); 
        	dataset.add(new String[]{delivery.getDeliveryId() + "",delivery.getJobObj().getJobName(),delivery.getUserObj().getName(),delivery.getDeliveryTime(),delivery.getHandleTime(),delivery.getClzt(),delivery.getTzxx(),delivery.getGzpj()});
        }
        /*
        OutputStream out = null;
		try {
			out = new FileOutputStream("C://output.xls");
			ex.exportExcel(title,headers, dataset, out);
		    out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		*/
		OutputStream out = null;//创建一个输出流对象 
		try { 
			out = response.getOutputStream();//
			response.setHeader("Content-disposition","attachment; filename="+"Delivery.xls");//filename是下载的xls的名，建议最好用英文 
			response.setContentType("application/msexcel;charset=UTF-8");//设置类型 
			response.setHeader("Pragma","No-cache");//设置头 
			response.setHeader("Cache-Control","no-cache");//设置头 
			response.setDateHeader("Expires", 0);//设置日期头  
			String rootPath = request.getSession().getServletContext().getRealPath("/");
			ex.exportExcel(rootPath,_title,headers, dataset, out);
			out.flush();
		} catch (IOException e) { 
			e.printStackTrace(); 
		}finally{
			try{
				if(out!=null){ 
					out.close(); 
				}
			}catch(IOException e){ 
				e.printStackTrace(); 
			} 
		}
    }
}
