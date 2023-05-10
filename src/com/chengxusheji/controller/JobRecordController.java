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
import com.chengxusheji.service.JobRecordService;
import com.chengxusheji.po.JobRecord;
import com.chengxusheji.service.UserInfoService;
import com.chengxusheji.po.UserInfo;

//JobRecord管理控制层
@Controller
@RequestMapping("/JobRecord")
public class JobRecordController extends BaseController {

    /*业务层对象*/
    @Resource JobRecordService jobRecordService;

    @Resource UserInfoService userInfoService;
	@InitBinder("userObj")
	public void initBinderuserObj(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("userObj.");
	}
	@InitBinder("jobRecord")
	public void initBinderJobRecord(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("jobRecord.");
	}
	/*跳转到添加JobRecord视图*/
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model,HttpServletRequest request) throws Exception {
		model.addAttribute(new JobRecord());
		/*查询所有的UserInfo信息*/
		List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
		request.setAttribute("userInfoList", userInfoList);
		return "JobRecord_add";
	}

	/*客户端ajax方式提交添加兼职记录信息*/
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public void add(@Validated JobRecord jobRecord, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
		boolean success = false;
		if (br.hasErrors()) {
			message = "输入信息不符合要求！";
			writeJsonResponse(response, success, message);
			return ;
		}
        jobRecordService.addJobRecord(jobRecord);
        message = "兼职记录添加成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	/*ajax方式按照查询条件分页查询兼职记录信息*/
	@RequestMapping(value = { "/list" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void list(String title,@ModelAttribute("userObj") UserInfo userObj,String recordDate,Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		if (page==null || page == 0) page = 1;
		if (title == null) title = "";
		if (recordDate == null) recordDate = "";
		if(rows != 0)jobRecordService.setRows(rows);
		List<JobRecord> jobRecordList = jobRecordService.queryJobRecord(title, userObj, recordDate, page);
	    /*计算总的页数和总的记录数*/
	    jobRecordService.queryTotalPageAndRecordNumber(title, userObj, recordDate);
	    /*获取到总的页码数目*/
	    int totalPage = jobRecordService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = jobRecordService.getRecordNumber();
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象
		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(JobRecord jobRecord:jobRecordList) {
			JSONObject jsonJobRecord = jobRecord.getJsonObject();
			jsonArray.put(jsonJobRecord);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}

	/*ajax方式按照查询条件分页查询兼职记录信息*/
	@RequestMapping(value = { "/listAll" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void listAll(HttpServletResponse response) throws Exception {
		List<JobRecord> jobRecordList = jobRecordService.queryAllJobRecord();
        response.setContentType("text/json;charset=UTF-8"); 
		PrintWriter out = response.getWriter();
		JSONArray jsonArray = new JSONArray();
		for(JobRecord jobRecord:jobRecordList) {
			JSONObject jsonJobRecord = new JSONObject();
			jsonJobRecord.accumulate("recordId", jobRecord.getRecordId());
			jsonJobRecord.accumulate("title", jobRecord.getTitle());
			jsonArray.put(jsonJobRecord);
		}
		out.println(jsonArray.toString());
		out.flush();
		out.close();
	}

	/*前台按照查询条件分页查询兼职记录信息*/
	@RequestMapping(value = { "/frontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String frontlist(String title,@ModelAttribute("userObj") UserInfo userObj,String recordDate,Integer currentPage, Model model, HttpServletRequest request) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		if (title == null) title = "";
		if (recordDate == null) recordDate = "";
		List<JobRecord> jobRecordList = jobRecordService.queryJobRecord(title, userObj, recordDate, currentPage);
	    /*计算总的页数和总的记录数*/
	    jobRecordService.queryTotalPageAndRecordNumber(title, userObj, recordDate);
	    /*获取到总的页码数目*/
	    int totalPage = jobRecordService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = jobRecordService.getRecordNumber();
	    request.setAttribute("jobRecordList",  jobRecordList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
	    request.setAttribute("title", title);
	    request.setAttribute("userObj", userObj);
	    request.setAttribute("recordDate", recordDate);
	    List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
	    request.setAttribute("userInfoList", userInfoList);
		return "JobRecord/jobRecord_frontquery_result"; 
	}

     /*前台查询JobRecord信息*/
	@RequestMapping(value="/{recordId}/frontshow",method=RequestMethod.GET)
	public String frontshow(@PathVariable Integer recordId,Model model,HttpServletRequest request) throws Exception {
		/*根据主键recordId获取JobRecord对象*/
        JobRecord jobRecord = jobRecordService.getJobRecord(recordId);

        List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
        request.setAttribute("userInfoList", userInfoList);
        request.setAttribute("jobRecord",  jobRecord);
        return "JobRecord/jobRecord_frontshow";
	}

	/*ajax方式显示兼职记录修改jsp视图页*/
	@RequestMapping(value="/{recordId}/update",method=RequestMethod.GET)
	public void update(@PathVariable Integer recordId,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
        /*根据主键recordId获取JobRecord对象*/
        JobRecord jobRecord = jobRecordService.getJobRecord(recordId);

        response.setContentType("text/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象 
		JSONObject jsonJobRecord = jobRecord.getJsonObject();
		out.println(jsonJobRecord.toString());
		out.flush();
		out.close();
	}

	/*ajax方式更新兼职记录信息*/
	@RequestMapping(value = "/{recordId}/update", method = RequestMethod.POST)
	public void update(@Validated JobRecord jobRecord, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
    	boolean success = false;
		if (br.hasErrors()) { 
			message = "输入的信息有错误！";
			writeJsonResponse(response, success, message);
			return;
		}
		try {
			jobRecordService.updateJobRecord(jobRecord);
			message = "兼职记录更新成功!";
			success = true;
			writeJsonResponse(response, success, message);
		} catch (Exception e) {
			e.printStackTrace();
			message = "兼职记录更新失败!";
			writeJsonResponse(response, success, message); 
		}
	}
    /*删除兼职记录信息*/
	@RequestMapping(value="/{recordId}/delete",method=RequestMethod.GET)
	public String delete(@PathVariable Integer recordId,HttpServletRequest request) throws UnsupportedEncodingException {
		  try {
			  jobRecordService.deleteJobRecord(recordId);
	            request.setAttribute("message", "兼职记录删除成功!");
	            return "message";
	        } catch (Exception e) { 
	            e.printStackTrace();
	            request.setAttribute("error", "兼职记录删除失败!");
				return "error";

	        }

	}

	/*ajax方式删除多条兼职记录记录*/
	@RequestMapping(value="/deletes",method=RequestMethod.POST)
	public void delete(String recordIds,HttpServletRequest request,HttpServletResponse response) throws IOException, JSONException {
		String message = "";
    	boolean success = false;
        try { 
        	int count = jobRecordService.deleteJobRecords(recordIds);
        	success = true;
        	message = count + "条记录删除成功";
        	writeJsonResponse(response, success, message);
        } catch (Exception e) { 
            //e.printStackTrace();
            message = "有记录存在外键约束,删除失败";
            writeJsonResponse(response, success, message);
        }
	}

	/*按照查询条件导出兼职记录信息到Excel*/
	@RequestMapping(value = { "/OutToExcel" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void OutToExcel(String title,@ModelAttribute("userObj") UserInfo userObj,String recordDate, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
        if(title == null) title = "";
        if(recordDate == null) recordDate = "";
        List<JobRecord> jobRecordList = jobRecordService.queryJobRecord(title,userObj,recordDate);
        ExportExcelUtil ex = new ExportExcelUtil();
        String _title = "JobRecord信息记录"; 
        String[] headers = { "记录id","标题","记录人","记录时间"};
        List<String[]> dataset = new ArrayList<String[]>(); 
        for(int i=0;i<jobRecordList.size();i++) {
        	JobRecord jobRecord = jobRecordList.get(i); 
        	dataset.add(new String[]{jobRecord.getRecordId() + "",jobRecord.getTitle(),jobRecord.getUserObj().getName(),jobRecord.getRecordDate()});
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
			response.setHeader("Content-disposition","attachment; filename="+"JobRecord.xls");//filename是下载的xls的名，建议最好用英文 
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
