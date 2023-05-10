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
import com.chengxusheji.service.JobService;
import com.chengxusheji.po.Job;
import com.chengxusheji.service.CompanyService;
import com.chengxusheji.po.Company;
import com.chengxusheji.service.JobTypeService;
import com.chengxusheji.po.JobType;

//Job管理控制层
@Controller
@RequestMapping("/Job")
public class JobController extends BaseController {

    /*业务层对象*/
    @Resource JobService jobService;

    @Resource CompanyService companyService;
    @Resource JobTypeService jobTypeService;
	@InitBinder("jobTypeObj")
	public void initBinderjobTypeObj(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("jobTypeObj.");
	}
	@InitBinder("companyObj")
	public void initBindercompanyObj(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("companyObj.");
	}
	@InitBinder("job")
	public void initBinderJob(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("job.");
	}
	/*跳转到添加Job视图*/
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model,HttpServletRequest request) throws Exception {
		model.addAttribute(new Job());
		/*查询所有的Company信息*/
		List<Company> companyList = companyService.queryAllCompany();
		request.setAttribute("companyList", companyList);
		/*查询所有的JobType信息*/
		List<JobType> jobTypeList = jobTypeService.queryAllJobType();
		request.setAttribute("jobTypeList", jobTypeList);
		return "Job_add";
	}

	/*客户端ajax方式提交添加职位信息*/
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public void add(@Validated Job job, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
		boolean success = false;
		if (br.hasErrors()) {
			message = "输入信息不符合要求！";
			writeJsonResponse(response, success, message);
			return ;
		}
        jobService.addJob(job);
        message = "职位添加成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	/*ajax方式按照查询条件分页查询职位信息*/
	@RequestMapping(value = { "/list" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void list(@ModelAttribute("jobTypeObj") JobType jobTypeObj,String jobName,String xlyq,String gzqy,@ModelAttribute("companyObj") Company companyObj,String addTime,Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		if (page==null || page == 0) page = 1;
		if (jobName == null) jobName = "";
		if (xlyq == null) xlyq = "";
		if (gzqy == null) gzqy = "";
		if (addTime == null) addTime = "";
		if(rows != 0)jobService.setRows(rows);
		List<Job> jobList = jobService.queryJob(jobTypeObj, jobName, xlyq, gzqy, companyObj, addTime, page);
	    /*计算总的页数和总的记录数*/
	    jobService.queryTotalPageAndRecordNumber(jobTypeObj, jobName, xlyq, gzqy, companyObj, addTime);
	    /*获取到总的页码数目*/
	    int totalPage = jobService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = jobService.getRecordNumber();
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象
		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(Job job:jobList) {
			JSONObject jsonJob = job.getJsonObject();
			jsonArray.put(jsonJob);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}

	/*ajax方式按照查询条件分页查询职位信息*/
	@RequestMapping(value = { "/listAll" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void listAll(HttpServletResponse response) throws Exception {
		List<Job> jobList = jobService.queryAllJob();
        response.setContentType("text/json;charset=UTF-8"); 
		PrintWriter out = response.getWriter();
		JSONArray jsonArray = new JSONArray();
		for(Job job:jobList) {
			JSONObject jsonJob = new JSONObject();
			jsonJob.accumulate("jobId", job.getJobId());
			jsonJob.accumulate("jobName", job.getJobName());
			jsonArray.put(jsonJob);
		}
		out.println(jsonArray.toString());
		out.flush();
		out.close();
	}

	/*前台按照查询条件分页查询职位信息*/
	@RequestMapping(value = { "/frontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String frontlist(@ModelAttribute("jobTypeObj") JobType jobTypeObj,String jobName,String xlyq,String gzqy,@ModelAttribute("companyObj") Company companyObj,String addTime,Integer currentPage, Model model, HttpServletRequest request) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		if (jobName == null) jobName = "";
		if (xlyq == null) xlyq = "";
		if (gzqy == null) gzqy = "";
		if (addTime == null) addTime = "";
		List<Job> jobList = jobService.queryJob(jobTypeObj, jobName, xlyq, gzqy, companyObj, addTime, currentPage);
	    /*计算总的页数和总的记录数*/
	    jobService.queryTotalPageAndRecordNumber(jobTypeObj, jobName, xlyq, gzqy, companyObj, addTime);
	    /*获取到总的页码数目*/
	    int totalPage = jobService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = jobService.getRecordNumber();
	    request.setAttribute("jobList",  jobList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
	    request.setAttribute("jobTypeObj", jobTypeObj);
	    request.setAttribute("jobName", jobName);
	    request.setAttribute("xlyq", xlyq);
	    request.setAttribute("gzqy", gzqy);
	    request.setAttribute("companyObj", companyObj);
	    request.setAttribute("addTime", addTime);
	    List<Company> companyList = companyService.queryAllCompany();
	    request.setAttribute("companyList", companyList);
	    List<JobType> jobTypeList = jobTypeService.queryAllJobType();
	    request.setAttribute("jobTypeList", jobTypeList);
		return "Job/job_frontquery_result"; 
	}

     /*前台查询Job信息*/
	@RequestMapping(value="/{jobId}/frontshow",method=RequestMethod.GET)
	public String frontshow(@PathVariable Integer jobId,Model model,HttpServletRequest request) throws Exception {
		/*根据主键jobId获取Job对象*/
        Job job = jobService.getJob(jobId);

        List<Company> companyList = companyService.queryAllCompany();
        request.setAttribute("companyList", companyList);
        List<JobType> jobTypeList = jobTypeService.queryAllJobType();
        request.setAttribute("jobTypeList", jobTypeList);
        request.setAttribute("job",  job);
        return "Job/job_frontshow";
	}

	/*ajax方式显示职位修改jsp视图页*/
	@RequestMapping(value="/{jobId}/update",method=RequestMethod.GET)
	public void update(@PathVariable Integer jobId,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
        /*根据主键jobId获取Job对象*/
        Job job = jobService.getJob(jobId);

        response.setContentType("text/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象 
		JSONObject jsonJob = job.getJsonObject();
		out.println(jsonJob.toString());
		out.flush();
		out.close();
	}

	/*ajax方式更新职位信息*/
	@RequestMapping(value = "/{jobId}/update", method = RequestMethod.POST)
	public void update(@Validated Job job, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
    	boolean success = false;
		if (br.hasErrors()) { 
			message = "输入的信息有错误！";
			writeJsonResponse(response, success, message);
			return;
		}
		try {
			jobService.updateJob(job);
			message = "职位更新成功!";
			success = true;
			writeJsonResponse(response, success, message);
		} catch (Exception e) {
			e.printStackTrace();
			message = "职位更新失败!";
			writeJsonResponse(response, success, message); 
		}
	}
    /*删除职位信息*/
	@RequestMapping(value="/{jobId}/delete",method=RequestMethod.GET)
	public String delete(@PathVariable Integer jobId,HttpServletRequest request) throws UnsupportedEncodingException {
		  try {
			  jobService.deleteJob(jobId);
	            request.setAttribute("message", "职位删除成功!");
	            return "message";
	        } catch (Exception e) { 
	            e.printStackTrace();
	            request.setAttribute("error", "职位删除失败!");
				return "error";

	        }

	}

	/*ajax方式删除多条职位记录*/
	@RequestMapping(value="/deletes",method=RequestMethod.POST)
	public void delete(String jobIds,HttpServletRequest request,HttpServletResponse response) throws IOException, JSONException {
		String message = "";
    	boolean success = false;
        try { 
        	int count = jobService.deleteJobs(jobIds);
        	success = true;
        	message = count + "条记录删除成功";
        	writeJsonResponse(response, success, message);
        } catch (Exception e) { 
            //e.printStackTrace();
            message = "有记录存在外键约束,删除失败";
            writeJsonResponse(response, success, message);
        }
	}

	/*按照查询条件导出职位信息到Excel*/
	@RequestMapping(value = { "/OutToExcel" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void OutToExcel(@ModelAttribute("jobTypeObj") JobType jobTypeObj,String jobName,String xlyq,String gzqy,@ModelAttribute("companyObj") Company companyObj,String addTime, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
        if(jobName == null) jobName = "";
        if(xlyq == null) xlyq = "";
        if(gzqy == null) gzqy = "";
        if(addTime == null) addTime = "";
        List<Job> jobList = jobService.queryJob(jobTypeObj,jobName,xlyq,gzqy,companyObj,addTime);
        ExportExcelUtil ex = new ExportExcelUtil();
        String _title = "Job信息记录"; 
        String[] headers = { "职位id","职位类别","职位名称","工作薪酬","招聘人数","学历要求","有效期限","工作区域","浏览次数","发布企业","发布时间"};
        List<String[]> dataset = new ArrayList<String[]>(); 
        for(int i=0;i<jobList.size();i++) {
        	Job job = jobList.get(i); 
        	dataset.add(new String[]{job.getJobId() + "",job.getJobTypeObj().getJobTypeName(),job.getJobName(),job.getSalary(),job.getZprs() + "",job.getXlyq(),job.getYxqx(),job.getGzqy(),job.getViewNum() + "",job.getCompanyObj().getCompanyName(),job.getAddTime()});
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
			response.setHeader("Content-disposition","attachment; filename="+"Job.xls");//filename是下载的xls的名，建议最好用英文 
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
