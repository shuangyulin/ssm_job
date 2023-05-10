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
import com.chengxusheji.service.CompanyService;
import com.chengxusheji.po.Company;

//Company管理控制层
@Controller
@RequestMapping("/Company")
public class CompanyController extends BaseController {

    /*业务层对象*/
    @Resource CompanyService companyService;

	@InitBinder("company")
	public void initBinderCompany(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("company.");
	}
	/*跳转到添加Company视图*/
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model,HttpServletRequest request) throws Exception {
		model.addAttribute(new Company());
		return "Company_add";
	}

	/*客户端ajax方式提交添加企业信息*/
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public void add(@Validated Company company, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
		boolean success = false;
		if (br.hasErrors()) {
			message = "输入信息不符合要求！";
			writeJsonResponse(response, success, message);
			return ;
		}
		if(companyService.getCompany(company.getCompanyUserName()) != null) {
			message = "企业用户名已经存在！";
			writeJsonResponse(response, success, message);
			return ;
		}
		try {
			company.setYyzz(this.handlePhotoUpload(request, "yyzzFile"));
		} catch(UserException ex) {
			message = "图片格式不正确！";
			writeJsonResponse(response, success, message);
			return ;
		}
        companyService.addCompany(company);
        message = "企业添加成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	/*ajax方式按照查询条件分页查询企业信息*/
	@RequestMapping(value = { "/list" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void list(String qyjb,String companyName,String gszch,String gsxz,String gsgm,String gghy,String lxr,String lxdh,String shzt,Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		if (page==null || page == 0) page = 1;
		if (qyjb == null) qyjb = "";
		if (companyName == null) companyName = "";
		if (gszch == null) gszch = "";
		if (gsxz == null) gsxz = "";
		if (gsgm == null) gsgm = "";
		if (gghy == null) gghy = "";
		if (lxr == null) lxr = "";
		if (lxdh == null) lxdh = "";
		if (shzt == null) shzt = "";
		if(rows != 0)companyService.setRows(rows);
		List<Company> companyList = companyService.queryCompany(qyjb, companyName, gszch, gsxz, gsgm, gghy, lxr, lxdh, shzt, page);
	    /*计算总的页数和总的记录数*/
	    companyService.queryTotalPageAndRecordNumber(qyjb, companyName, gszch, gsxz, gsgm, gghy, lxr, lxdh, shzt);
	    /*获取到总的页码数目*/
	    int totalPage = companyService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = companyService.getRecordNumber();
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象
		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(Company company:companyList) {
			JSONObject jsonCompany = company.getJsonObject();
			jsonArray.put(jsonCompany);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}

	/*ajax方式按照查询条件分页查询企业信息*/
	@RequestMapping(value = { "/listAll" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void listAll(HttpServletResponse response) throws Exception {
		List<Company> companyList = companyService.queryAllCompany();
        response.setContentType("text/json;charset=UTF-8"); 
		PrintWriter out = response.getWriter();
		JSONArray jsonArray = new JSONArray();
		for(Company company:companyList) {
			JSONObject jsonCompany = new JSONObject();
			jsonCompany.accumulate("companyUserName", company.getCompanyUserName());
			jsonCompany.accumulate("companyName", company.getCompanyName());
			jsonArray.put(jsonCompany);
		}
		out.println(jsonArray.toString());
		out.flush();
		out.close();
	}

	/*前台按照查询条件分页查询企业信息*/
	@RequestMapping(value = { "/frontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String frontlist(String qyjb,String companyName,String gszch,String gsxz,String gsgm,String gghy,String lxr,String lxdh,String shzt,Integer currentPage, Model model, HttpServletRequest request) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		if (qyjb == null) qyjb = "";
		if (companyName == null) companyName = "";
		if (gszch == null) gszch = "";
		if (gsxz == null) gsxz = "";
		if (gsgm == null) gsgm = "";
		if (gghy == null) gghy = "";
		if (lxr == null) lxr = "";
		if (lxdh == null) lxdh = "";
		if (shzt == null) shzt = "";
		List<Company> companyList = companyService.queryCompany(qyjb, companyName, gszch, gsxz, gsgm, gghy, lxr, lxdh, shzt, currentPage);
	    /*计算总的页数和总的记录数*/
	    companyService.queryTotalPageAndRecordNumber(qyjb, companyName, gszch, gsxz, gsgm, gghy, lxr, lxdh, shzt);
	    /*获取到总的页码数目*/
	    int totalPage = companyService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = companyService.getRecordNumber();
	    request.setAttribute("companyList",  companyList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
	    request.setAttribute("qyjb", qyjb);
	    request.setAttribute("companyName", companyName);
	    request.setAttribute("gszch", gszch);
	    request.setAttribute("gsxz", gsxz);
	    request.setAttribute("gsgm", gsgm);
	    request.setAttribute("gghy", gghy);
	    request.setAttribute("lxr", lxr);
	    request.setAttribute("lxdh", lxdh);
	    request.setAttribute("shzt", shzt);
		return "Company/company_frontquery_result"; 
	}

     /*前台查询Company信息*/
	@RequestMapping(value="/{companyUserName}/frontshow",method=RequestMethod.GET)
	public String frontshow(@PathVariable String companyUserName,Model model,HttpServletRequest request) throws Exception {
		/*根据主键companyUserName获取Company对象*/
        Company company = companyService.getCompany(companyUserName);

        request.setAttribute("company",  company);
        return "Company/company_frontshow";
	}

	/*ajax方式显示企业修改jsp视图页*/
	@RequestMapping(value="/{companyUserName}/update",method=RequestMethod.GET)
	public void update(@PathVariable String companyUserName,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
        /*根据主键companyUserName获取Company对象*/
        Company company = companyService.getCompany(companyUserName);

        response.setContentType("text/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象 
		JSONObject jsonCompany = company.getJsonObject();
		out.println(jsonCompany.toString());
		out.flush();
		out.close();
	}

	/*ajax方式更新企业信息*/
	@RequestMapping(value = "/{companyUserName}/update", method = RequestMethod.POST)
	public void update(@Validated Company company, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
    	boolean success = false;
		if (br.hasErrors()) { 
			message = "输入的信息有错误！";
			writeJsonResponse(response, success, message);
			return;
		}
		String yyzzFileName = this.handlePhotoUpload(request, "yyzzFile");
		if(!yyzzFileName.equals("upload/NoImage.jpg"))company.setYyzz(yyzzFileName); 


		try {
			companyService.updateCompany(company);
			message = "企业更新成功!";
			success = true;
			writeJsonResponse(response, success, message);
		} catch (Exception e) {
			e.printStackTrace();
			message = "企业更新失败!";
			writeJsonResponse(response, success, message); 
		}
	}
    /*删除企业信息*/
	@RequestMapping(value="/{companyUserName}/delete",method=RequestMethod.GET)
	public String delete(@PathVariable String companyUserName,HttpServletRequest request) throws UnsupportedEncodingException {
		  try {
			  companyService.deleteCompany(companyUserName);
	            request.setAttribute("message", "企业删除成功!");
	            return "message";
	        } catch (Exception e) { 
	            e.printStackTrace();
	            request.setAttribute("error", "企业删除失败!");
				return "error";

	        }

	}

	/*ajax方式删除多条企业记录*/
	@RequestMapping(value="/deletes",method=RequestMethod.POST)
	public void delete(String companyUserNames,HttpServletRequest request,HttpServletResponse response) throws IOException, JSONException {
		String message = "";
    	boolean success = false;
        try { 
        	int count = companyService.deleteCompanys(companyUserNames);
        	success = true;
        	message = count + "条记录删除成功";
        	writeJsonResponse(response, success, message);
        } catch (Exception e) { 
            //e.printStackTrace();
            message = "有记录存在外键约束,删除失败";
            writeJsonResponse(response, success, message);
        }
	}

	/*按照查询条件导出企业信息到Excel*/
	@RequestMapping(value = { "/OutToExcel" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void OutToExcel(String qyjb,String companyName,String gszch,String gsxz,String gsgm,String gghy,String lxr,String lxdh,String shzt, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
        if(qyjb == null) qyjb = "";
        if(companyName == null) companyName = "";
        if(gszch == null) gszch = "";
        if(gsxz == null) gsxz = "";
        if(gsgm == null) gsgm = "";
        if(gghy == null) gghy = "";
        if(lxr == null) lxr = "";
        if(lxdh == null) lxdh = "";
        if(shzt == null) shzt = "";
        List<Company> companyList = companyService.queryCompany(qyjb,companyName,gszch,gsxz,gsgm,gghy,lxr,lxdh,shzt);
        ExportExcelUtil ex = new ExportExcelUtil();
        String _title = "Company信息记录"; 
        String[] headers = { "企业用户名","信用级别","企业名称","工商注册号","营业执照","公司性质","公司规模","公司行业","联系人","联系电话","审核状态"};
        List<String[]> dataset = new ArrayList<String[]>(); 
        for(int i=0;i<companyList.size();i++) {
        	Company company = companyList.get(i); 
        	dataset.add(new String[]{company.getCompanyUserName(),company.getQyjb(),company.getCompanyName(),company.getGszch(),company.getYyzz(),company.getGsxz(),company.getGsgm(),company.getGghy(),company.getLxr(),company.getLxdh(),company.getShzt()});
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
			response.setHeader("Content-disposition","attachment; filename="+"Company.xls");//filename是下载的xls的名，建议最好用英文 
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
