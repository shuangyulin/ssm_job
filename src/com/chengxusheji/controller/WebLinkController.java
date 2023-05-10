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
import com.chengxusheji.service.WebLinkService;
import com.chengxusheji.po.WebLink;

//WebLink管理控制层
@Controller
@RequestMapping("/WebLink")
public class WebLinkController extends BaseController {

    /*业务层对象*/
    @Resource WebLinkService webLinkService;

	@InitBinder("webLink")
	public void initBinderWebLink(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("webLink.");
	}
	/*跳转到添加WebLink视图*/
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model,HttpServletRequest request) throws Exception {
		model.addAttribute(new WebLink());
		return "WebLink_add";
	}

	/*客户端ajax方式提交添加友情链接信息*/
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public void add(@Validated WebLink webLink, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
		boolean success = false;
		if (br.hasErrors()) {
			message = "输入信息不符合要求！";
			writeJsonResponse(response, success, message);
			return ;
		}
		try {
			webLink.setWebLogo(this.handlePhotoUpload(request, "webLogoFile"));
		} catch(UserException ex) {
			message = "图片格式不正确！";
			writeJsonResponse(response, success, message);
			return ;
		}
        webLinkService.addWebLink(webLink);
        message = "友情链接添加成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	/*ajax方式按照查询条件分页查询友情链接信息*/
	@RequestMapping(value = { "/list" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void list(Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		if (page==null || page == 0) page = 1;
		if(rows != 0)webLinkService.setRows(rows);
		List<WebLink> webLinkList = webLinkService.queryWebLink(page);
	    /*计算总的页数和总的记录数*/
	    webLinkService.queryTotalPageAndRecordNumber();
	    /*获取到总的页码数目*/
	    int totalPage = webLinkService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = webLinkService.getRecordNumber();
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象
		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(WebLink webLink:webLinkList) {
			JSONObject jsonWebLink = webLink.getJsonObject();
			jsonArray.put(jsonWebLink);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}

	/*ajax方式按照查询条件分页查询友情链接信息*/
	@RequestMapping(value = { "/listAll" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void listAll(HttpServletResponse response) throws Exception {
		List<WebLink> webLinkList = webLinkService.queryAllWebLink();
        response.setContentType("text/json;charset=UTF-8"); 
		PrintWriter out = response.getWriter();
		JSONArray jsonArray = new JSONArray();
		for(WebLink webLink:webLinkList) {
			JSONObject jsonWebLink = new JSONObject();
			jsonWebLink.accumulate("linkId", webLink.getLinkId());
			jsonWebLink.accumulate("webName", webLink.getWebName());
			jsonArray.put(jsonWebLink);
		}
		out.println(jsonArray.toString());
		out.flush();
		out.close();
	}

	/*前台按照查询条件分页查询友情链接信息*/
	@RequestMapping(value = { "/frontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String frontlist(Integer currentPage, Model model, HttpServletRequest request) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		List<WebLink> webLinkList = webLinkService.queryWebLink(currentPage);
	    /*计算总的页数和总的记录数*/
	    webLinkService.queryTotalPageAndRecordNumber();
	    /*获取到总的页码数目*/
	    int totalPage = webLinkService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = webLinkService.getRecordNumber();
	    request.setAttribute("webLinkList",  webLinkList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
		return "WebLink/webLink_frontquery_result"; 
	}

     /*前台查询WebLink信息*/
	@RequestMapping(value="/{linkId}/frontshow",method=RequestMethod.GET)
	public String frontshow(@PathVariable Integer linkId,Model model,HttpServletRequest request) throws Exception {
		/*根据主键linkId获取WebLink对象*/
        WebLink webLink = webLinkService.getWebLink(linkId);

        request.setAttribute("webLink",  webLink);
        return "WebLink/webLink_frontshow";
	}

	/*ajax方式显示友情链接修改jsp视图页*/
	@RequestMapping(value="/{linkId}/update",method=RequestMethod.GET)
	public void update(@PathVariable Integer linkId,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
        /*根据主键linkId获取WebLink对象*/
        WebLink webLink = webLinkService.getWebLink(linkId);

        response.setContentType("text/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象 
		JSONObject jsonWebLink = webLink.getJsonObject();
		out.println(jsonWebLink.toString());
		out.flush();
		out.close();
	}

	/*ajax方式更新友情链接信息*/
	@RequestMapping(value = "/{linkId}/update", method = RequestMethod.POST)
	public void update(@Validated WebLink webLink, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
    	boolean success = false;
		if (br.hasErrors()) { 
			message = "输入的信息有错误！";
			writeJsonResponse(response, success, message);
			return;
		}
		String webLogoFileName = this.handlePhotoUpload(request, "webLogoFile");
		if(!webLogoFileName.equals("upload/NoImage.jpg"))webLink.setWebLogo(webLogoFileName); 


		try {
			webLinkService.updateWebLink(webLink);
			message = "友情链接更新成功!";
			success = true;
			writeJsonResponse(response, success, message);
		} catch (Exception e) {
			e.printStackTrace();
			message = "友情链接更新失败!";
			writeJsonResponse(response, success, message); 
		}
	}
    /*删除友情链接信息*/
	@RequestMapping(value="/{linkId}/delete",method=RequestMethod.GET)
	public String delete(@PathVariable Integer linkId,HttpServletRequest request) throws UnsupportedEncodingException {
		  try {
			  webLinkService.deleteWebLink(linkId);
	            request.setAttribute("message", "友情链接删除成功!");
	            return "message";
	        } catch (Exception e) { 
	            e.printStackTrace();
	            request.setAttribute("error", "友情链接删除失败!");
				return "error";

	        }

	}

	/*ajax方式删除多条友情链接记录*/
	@RequestMapping(value="/deletes",method=RequestMethod.POST)
	public void delete(String linkIds,HttpServletRequest request,HttpServletResponse response) throws IOException, JSONException {
		String message = "";
    	boolean success = false;
        try { 
        	int count = webLinkService.deleteWebLinks(linkIds);
        	success = true;
        	message = count + "条记录删除成功";
        	writeJsonResponse(response, success, message);
        } catch (Exception e) { 
            //e.printStackTrace();
            message = "有记录存在外键约束,删除失败";
            writeJsonResponse(response, success, message);
        }
	}

	/*按照查询条件导出友情链接信息到Excel*/
	@RequestMapping(value = { "/OutToExcel" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void OutToExcel( Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
        List<WebLink> webLinkList = webLinkService.queryWebLink();
        ExportExcelUtil ex = new ExportExcelUtil();
        String _title = "WebLink信息记录"; 
        String[] headers = { "记录id","网站名称","网站Logo","网站地址"};
        List<String[]> dataset = new ArrayList<String[]>(); 
        for(int i=0;i<webLinkList.size();i++) {
        	WebLink webLink = webLinkList.get(i); 
        	dataset.add(new String[]{webLink.getLinkId() + "",webLink.getWebName(),webLink.getWebLogo(),webLink.getWebAddress()});
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
			response.setHeader("Content-disposition","attachment; filename="+"WebLink.xls");//filename是下载的xls的名，建议最好用英文 
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
