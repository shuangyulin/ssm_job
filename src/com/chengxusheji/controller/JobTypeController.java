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
import com.chengxusheji.service.JobTypeService;
import com.chengxusheji.po.JobType;

//JobType管理控制层
@Controller
@RequestMapping("/JobType")
public class JobTypeController extends BaseController {

    /*业务层对象*/
    @Resource JobTypeService jobTypeService;

	@InitBinder("jobType")
	public void initBinderJobType(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("jobType.");
	}
	/*跳转到添加JobType视图*/
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model,HttpServletRequest request) throws Exception {
		model.addAttribute(new JobType());
		return "JobType_add";
	}

	/*客户端ajax方式提交添加职位类别信息*/
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public void add(@Validated JobType jobType, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
		boolean success = false;
		if (br.hasErrors()) {
			message = "输入信息不符合要求！";
			writeJsonResponse(response, success, message);
			return ;
		}
        jobTypeService.addJobType(jobType);
        message = "职位类别添加成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	/*ajax方式按照查询条件分页查询职位类别信息*/
	@RequestMapping(value = { "/list" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void list(Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		if (page==null || page == 0) page = 1;
		if(rows != 0)jobTypeService.setRows(rows);
		List<JobType> jobTypeList = jobTypeService.queryJobType(page);
	    /*计算总的页数和总的记录数*/
	    jobTypeService.queryTotalPageAndRecordNumber();
	    /*获取到总的页码数目*/
	    int totalPage = jobTypeService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = jobTypeService.getRecordNumber();
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象
		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(JobType jobType:jobTypeList) {
			JSONObject jsonJobType = jobType.getJsonObject();
			jsonArray.put(jsonJobType);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}

	/*ajax方式按照查询条件分页查询职位类别信息*/
	@RequestMapping(value = { "/listAll" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void listAll(HttpServletResponse response) throws Exception {
		List<JobType> jobTypeList = jobTypeService.queryAllJobType();
        response.setContentType("text/json;charset=UTF-8"); 
		PrintWriter out = response.getWriter();
		JSONArray jsonArray = new JSONArray();
		for(JobType jobType:jobTypeList) {
			JSONObject jsonJobType = new JSONObject();
			jsonJobType.accumulate("jobTypeId", jobType.getJobTypeId());
			jsonJobType.accumulate("jobTypeName", jobType.getJobTypeName());
			jsonArray.put(jsonJobType);
		}
		out.println(jsonArray.toString());
		out.flush();
		out.close();
	}

	/*前台按照查询条件分页查询职位类别信息*/
	@RequestMapping(value = { "/frontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String frontlist(Integer currentPage, Model model, HttpServletRequest request) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		List<JobType> jobTypeList = jobTypeService.queryJobType(currentPage);
	    /*计算总的页数和总的记录数*/
	    jobTypeService.queryTotalPageAndRecordNumber();
	    /*获取到总的页码数目*/
	    int totalPage = jobTypeService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = jobTypeService.getRecordNumber();
	    request.setAttribute("jobTypeList",  jobTypeList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
		return "JobType/jobType_frontquery_result"; 
	}

     /*前台查询JobType信息*/
	@RequestMapping(value="/{jobTypeId}/frontshow",method=RequestMethod.GET)
	public String frontshow(@PathVariable Integer jobTypeId,Model model,HttpServletRequest request) throws Exception {
		/*根据主键jobTypeId获取JobType对象*/
        JobType jobType = jobTypeService.getJobType(jobTypeId);

        request.setAttribute("jobType",  jobType);
        return "JobType/jobType_frontshow";
	}

	/*ajax方式显示职位类别修改jsp视图页*/
	@RequestMapping(value="/{jobTypeId}/update",method=RequestMethod.GET)
	public void update(@PathVariable Integer jobTypeId,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
        /*根据主键jobTypeId获取JobType对象*/
        JobType jobType = jobTypeService.getJobType(jobTypeId);

        response.setContentType("text/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象 
		JSONObject jsonJobType = jobType.getJsonObject();
		out.println(jsonJobType.toString());
		out.flush();
		out.close();
	}

	/*ajax方式更新职位类别信息*/
	@RequestMapping(value = "/{jobTypeId}/update", method = RequestMethod.POST)
	public void update(@Validated JobType jobType, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
    	boolean success = false;
		if (br.hasErrors()) { 
			message = "输入的信息有错误！";
			writeJsonResponse(response, success, message);
			return;
		}
		try {
			jobTypeService.updateJobType(jobType);
			message = "职位类别更新成功!";
			success = true;
			writeJsonResponse(response, success, message);
		} catch (Exception e) {
			e.printStackTrace();
			message = "职位类别更新失败!";
			writeJsonResponse(response, success, message); 
		}
	}
    /*删除职位类别信息*/
	@RequestMapping(value="/{jobTypeId}/delete",method=RequestMethod.GET)
	public String delete(@PathVariable Integer jobTypeId,HttpServletRequest request) throws UnsupportedEncodingException {
		  try {
			  jobTypeService.deleteJobType(jobTypeId);
	            request.setAttribute("message", "职位类别删除成功!");
	            return "message";
	        } catch (Exception e) { 
	            e.printStackTrace();
	            request.setAttribute("error", "职位类别删除失败!");
				return "error";

	        }

	}

	/*ajax方式删除多条职位类别记录*/
	@RequestMapping(value="/deletes",method=RequestMethod.POST)
	public void delete(String jobTypeIds,HttpServletRequest request,HttpServletResponse response) throws IOException, JSONException {
		String message = "";
    	boolean success = false;
        try { 
        	int count = jobTypeService.deleteJobTypes(jobTypeIds);
        	success = true;
        	message = count + "条记录删除成功";
        	writeJsonResponse(response, success, message);
        } catch (Exception e) { 
            //e.printStackTrace();
            message = "有记录存在外键约束,删除失败";
            writeJsonResponse(response, success, message);
        }
	}

	/*按照查询条件导出职位类别信息到Excel*/
	@RequestMapping(value = { "/OutToExcel" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void OutToExcel( Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
        List<JobType> jobTypeList = jobTypeService.queryJobType();
        ExportExcelUtil ex = new ExportExcelUtil();
        String _title = "JobType信息记录"; 
        String[] headers = { "职位类型id","职位类别名称","职位类别描述"};
        List<String[]> dataset = new ArrayList<String[]>(); 
        for(int i=0;i<jobTypeList.size();i++) {
        	JobType jobType = jobTypeList.get(i); 
        	dataset.add(new String[]{jobType.getJobTypeId() + "",jobType.getJobTypeName(),jobType.getJobTypeDesc()});
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
			response.setHeader("Content-disposition","attachment; filename="+"JobType.xls");//filename是下载的xls的名，建议最好用英文 
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
