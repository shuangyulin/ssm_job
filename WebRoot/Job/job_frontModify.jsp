<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Job" %>
<%@ page import="com.chengxusheji.po.Company" %>
<%@ page import="com.chengxusheji.po.JobType" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    //获取所有的companyObj信息
    List<Company> companyList = (List<Company>)request.getAttribute("companyList");
    //获取所有的jobTypeObj信息
    List<JobType> jobTypeList = (List<JobType>)request.getAttribute("jobTypeList");
    Job job = (Job)request.getAttribute("job");

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <TITLE>修改职位信息</TITLE>
  <link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/animate.css" rel="stylesheet"> 
</head>
<body style="margin-top:70px;"> 
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="col-md-9 wow fadeInLeft">
	<ul class="breadcrumb">
  		<li><a href="<%=basePath %>index.jsp">首页</a></li>
  		<li class="active">职位信息修改</li>
	</ul>
		<div class="row"> 
      	<form class="form-horizontal" name="jobEditForm" id="jobEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="job_jobId_edit" class="col-md-3 text-right">职位id:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="job_jobId_edit" name="job.jobId" class="form-control" placeholder="请输入职位id" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="job_jobTypeObj_jobTypeId_edit" class="col-md-3 text-right">职位类别:</label>
		  	 <div class="col-md-9">
			    <select id="job_jobTypeObj_jobTypeId_edit" name="job.jobTypeObj.jobTypeId" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="job_jobName_edit" class="col-md-3 text-right">职位名称:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="job_jobName_edit" name="job.jobName" class="form-control" placeholder="请输入职位名称">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="job_jobDesc_edit" class="col-md-3 text-right">职位描述:</label>
		  	 <div class="col-md-9">
			    <script name="job.jobDesc" id="job_jobDesc_edit" type="text/plain"   style="width:100%;height:500px;"></script>
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="job_salary_edit" class="col-md-3 text-right">工作薪酬:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="job_salary_edit" name="job.salary" class="form-control" placeholder="请输入工作薪酬">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="job_zprs_edit" class="col-md-3 text-right">招聘人数:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="job_zprs_edit" name="job.zprs" class="form-control" placeholder="请输入招聘人数">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="job_xlyq_edit" class="col-md-3 text-right">学历要求:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="job_xlyq_edit" name="job.xlyq" class="form-control" placeholder="请输入学历要求">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="job_yxqx_edit" class="col-md-3 text-right">有效期限:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="job_yxqx_edit" name="job.yxqx" class="form-control" placeholder="请输入有效期限">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="job_gzqy_edit" class="col-md-3 text-right">工作区域:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="job_gzqy_edit" name="job.gzqy" class="form-control" placeholder="请输入工作区域">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="job_gzdz_edit" class="col-md-3 text-right">工作地址:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="job_gzdz_edit" name="job.gzdz" class="form-control" placeholder="请输入工作地址">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="job_viewNum_edit" class="col-md-3 text-right">浏览次数:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="job_viewNum_edit" name="job.viewNum" class="form-control" placeholder="请输入浏览次数">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="job_companyObj_companyUserName_edit" class="col-md-3 text-right">发布企业:</label>
		  	 <div class="col-md-9">
			    <select id="job_companyObj_companyUserName_edit" name="job.companyObj.companyUserName" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="job_addTime_edit" class="col-md-3 text-right">发布时间:</label>
		  	 <div class="col-md-9">
                <div class="input-group date job_addTime_edit col-md-12" data-link-field="job_addTime_edit">
                    <input class="form-control" id="job_addTime_edit" name="job.addTime" size="16" type="text" value="" placeholder="请选择发布时间" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
		  	 </div>
		  </div>
			  <div class="form-group">
			  	<span class="col-md-3""></span>
			  	<span onclick="ajaxJobModify();" class="btn btn-primary bottom5 top5">修改</span>
			  </div>
		</form> 
	    <style>#jobEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
   </div>
</div>


<jsp:include page="../footer.jsp"></jsp:include>
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap.js"></script>
<script src="<%=basePath %>plugins/wow.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap-datetimepicker.min.js"></script>
<script src="<%=basePath %>plugins/locales/bootstrap-datetimepicker.zh-CN.js"></script>
<script type="text/javascript" src="<%=basePath %>js/jsdate.js"></script>
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/ueditor.all.min.js"> </script>
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/lang/zh-cn/zh-cn.js"></script>
<script>
var job_jobDesc_editor = UE.getEditor('job_jobDesc_edit'); //职位描述编辑框
var basePath = "<%=basePath%>";
/*弹出修改职位界面并初始化数据*/
function jobEdit(jobId) {
  job_jobDesc_editor.addListener("ready", function () {
    // editor准备好之后才可以使用 
    ajaxModifyQuery(jobId);
  });
}
 function ajaxModifyQuery(jobId) {
	$.ajax({
		url :  basePath + "Job/" + jobId + "/update",
		type : "get",
		dataType: "json",
		success : function (job, response, status) {
			if (job) {
				$("#job_jobId_edit").val(job.jobId);
				$.ajax({
					url: basePath + "JobType/listAll",
					type: "get",
					success: function(jobTypes,response,status) { 
						$("#job_jobTypeObj_jobTypeId_edit").empty();
						var html="";
		        		$(jobTypes).each(function(i,jobType){
		        			html += "<option value='" + jobType.jobTypeId + "'>" + jobType.jobTypeName + "</option>";
		        		});
		        		$("#job_jobTypeObj_jobTypeId_edit").html(html);
		        		$("#job_jobTypeObj_jobTypeId_edit").val(job.jobTypeObjPri);
					}
				});
				$("#job_jobName_edit").val(job.jobName);
				job_jobDesc_editor.setContent(job.jobDesc, false);
				$("#job_salary_edit").val(job.salary);
				$("#job_zprs_edit").val(job.zprs);
				$("#job_xlyq_edit").val(job.xlyq);
				$("#job_yxqx_edit").val(job.yxqx);
				$("#job_gzqy_edit").val(job.gzqy);
				$("#job_gzdz_edit").val(job.gzdz);
				$("#job_viewNum_edit").val(job.viewNum);
				$.ajax({
					url: basePath + "Company/listAll",
					type: "get",
					success: function(companys,response,status) { 
						$("#job_companyObj_companyUserName_edit").empty();
						var html="";
		        		$(companys).each(function(i,company){
		        			html += "<option value='" + company.companyUserName + "'>" + company.companyName + "</option>";
		        		});
		        		$("#job_companyObj_companyUserName_edit").html(html);
		        		$("#job_companyObj_companyUserName_edit").val(job.companyObjPri);
					}
				});
				$("#job_addTime_edit").val(job.addTime);
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*ajax方式提交职位信息表单给服务器端修改*/
function ajaxJobModify() {
	$.ajax({
		url :  basePath + "Job/" + $("#job_jobId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#jobEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                location.reload(true);
                $("#jobQueryForm").submit();
            }else{
                alert(obj.message);
            } 
		},
		processData: false,
		contentType: false,
	});
}

$(function(){
        /*小屏幕导航点击关闭菜单*/
        $('.navbar-collapse a').click(function(){
            $('.navbar-collapse').collapse('hide');
        });
        new WOW().init();
    /*发布时间组件*/
    $('.job_addTime_edit').datetimepicker({
    	language:  'zh-CN',  //语言
    	format: 'yyyy-mm-dd hh:ii:ss',
    	weekStart: 1,
    	todayBtn:  1,
    	autoclose: 1,
    	minuteStep: 1,
    	todayHighlight: 1,
    	startView: 2,
    	forceParse: 0
    });
    jobEdit("<%=request.getParameter("jobId")%>");
 })
 </script> 
</body>
</html>

