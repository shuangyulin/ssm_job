<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Job" %>
<%@ page import="com.chengxusheji.po.Company" %>
<%@ page import="com.chengxusheji.po.JobType" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    List<Job> jobList = (List<Job>)request.getAttribute("jobList");
    //获取所有的companyObj信息
    List<Company> companyList = (List<Company>)request.getAttribute("companyList");
    //获取所有的jobTypeObj信息
    List<JobType> jobTypeList = (List<JobType>)request.getAttribute("jobTypeList");
    int currentPage =  (Integer)request.getAttribute("currentPage"); //当前页
    int totalPage =   (Integer)request.getAttribute("totalPage");  //一共多少页
    int recordNumber =   (Integer)request.getAttribute("recordNumber");  //一共多少记录
    JobType jobTypeObj = (JobType)request.getAttribute("jobTypeObj");
    String jobName = (String)request.getAttribute("jobName"); //职位名称查询关键字
    String xlyq = (String)request.getAttribute("xlyq"); //学历要求查询关键字
    String gzqy = (String)request.getAttribute("gzqy"); //工作区域查询关键字
    Company companyObj = (Company)request.getAttribute("companyObj");
    String addTime = (String)request.getAttribute("addTime"); //发布时间查询关键字
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>职位查询</title>
<link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
<link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
<link href="<%=basePath %>plugins/animate.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
</head>
<body style="margin-top:70px;">
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="row"> 
		<div class="col-md-9 wow fadeInDown" data-wow-duration="0.5s">
			<div>
				<!-- Nav tabs -->
				<ul class="nav nav-tabs" role="tablist">
			    	<li><a href="<%=basePath %>index.jsp">首页</a></li>
			    	<li role="presentation" class="active"><a href="#jobListPanel" aria-controls="jobListPanel" role="tab" data-toggle="tab">职位列表</a></li>
			    	<li role="presentation" ><a href="<%=basePath %>Job/job_frontAdd.jsp" style="display:none;">添加职位</a></li>
				</ul>
			  	<!-- Tab panes -->
			  	<div class="tab-content">
				    <div role="tabpanel" class="tab-pane active" id="jobListPanel">
				    		<div class="row">
				    			<div class="col-md-12 top5">
				    				<div class="table-responsive">
				    				<table class="table table-condensed table-hover">
				    					<tr class="success bold"><td>序号</td><td>职位id</td><td>职位类别</td><td>职位名称</td><td>工作薪酬</td><td>招聘人数</td><td>学历要求</td><td>有效期限</td><td>工作区域</td><td>浏览次数</td><td>发布企业</td><td>发布时间</td><td>操作</td></tr>
				    					<% 
				    						/*计算起始序号*/
				    	            		int startIndex = (currentPage -1) * 5;
				    	            		/*遍历记录*/
				    	            		for(int i=0;i<jobList.size();i++) {
					    	            		int currentIndex = startIndex + i + 1; //当前记录的序号
					    	            		Job job = jobList.get(i); //获取到职位对象
 										%>
 										<tr>
 											<td><%=currentIndex %></td>
 											<td><%=job.getJobId() %></td>
 											<td><%=job.getJobTypeObj().getJobTypeName() %></td>
 											<td><%=job.getJobName() %></td>
 											<td><%=job.getSalary() %></td>
 											<td><%=job.getZprs() %></td>
 											<td><%=job.getXlyq() %></td>
 											<td><%=job.getYxqx() %></td>
 											<td><%=job.getGzqy() %></td>
 											<td><%=job.getViewNum() %></td>
 											<td><%=job.getCompanyObj().getCompanyName() %></td>
 											<td><%=job.getAddTime() %></td>
 											<td>
 												<a href="<%=basePath  %>Job/<%=job.getJobId() %>/frontshow"><i class="fa fa-info"></i>&nbsp;查看</a>&nbsp;
 												<a href="#" onclick="jobEdit('<%=job.getJobId() %>');" style="display:none;"><i class="fa fa-pencil fa-fw"></i>编辑</a>&nbsp;
 												<a href="#" onclick="jobDelete('<%=job.getJobId() %>');" style="display:none;"><i class="fa fa-trash-o fa-fw"></i>删除</a>
 											</td> 
 										</tr>
 										<%}%>
				    				</table>
				    				</div>
				    			</div>
				    		</div>

				    		<div class="row">
					            <div class="col-md-12">
						            <nav class="pull-left">
						                <ul class="pagination">
						                    <li><a href="#" onclick="GoToPage(<%=currentPage-1 %>,<%=totalPage %>);" aria-label="Previous"><span aria-hidden="true">&laquo;</span></a></li>
						                     <%
						                    	int startPage = currentPage - 5;
						                    	int endPage = currentPage + 5;
						                    	if(startPage < 1) startPage=1;
						                    	if(endPage > totalPage) endPage = totalPage;
						                    	for(int i=startPage;i<=endPage;i++) {
						                    %>
						                    <li class="<%= currentPage==i?"active":"" %>"><a href="#"  onclick="GoToPage(<%=i %>,<%=totalPage %>);"><%=i %></a></li>
						                    <%  } %> 
						                    <li><a href="#" onclick="GoToPage(<%=currentPage+1 %>,<%=totalPage %>);"><span aria-hidden="true">&raquo;</span></a></li>
						                </ul>
						            </nav>
						            <div class="pull-right" style="line-height:75px;" >共有<%=recordNumber %>条记录，当前第 <%=currentPage %>/<%=totalPage %> 页</div>
					            </div>
				            </div> 
				    </div>
				</div>
			</div>
		</div>
	<div class="col-md-3 wow fadeInRight">
		<div class="page-header">
    		<h1>职位查询</h1>
		</div>
		<form name="jobQueryForm" id="jobQueryForm" action="<%=basePath %>Job/frontlist" class="mar_t15" method="post">
            <div class="form-group">
            	<label for="jobTypeObj_jobTypeId">职位类别：</label>
                <select id="jobTypeObj_jobTypeId" name="jobTypeObj.jobTypeId" class="form-control">
                	<option value="0">不限制</option>
	 				<%
	 				for(JobType jobTypeTemp:jobTypeList) {
	 					String selected = "";
 					if(jobTypeObj!=null && jobTypeObj.getJobTypeId()!=null && jobTypeObj.getJobTypeId().intValue()==jobTypeTemp.getJobTypeId().intValue())
 						selected = "selected";
	 				%>
 				 <option value="<%=jobTypeTemp.getJobTypeId() %>" <%=selected %>><%=jobTypeTemp.getJobTypeName() %></option>
	 				<%
	 				}
	 				%>
 			</select>
            </div>
			<div class="form-group">
				<label for="jobName">职位名称:</label>
				<input type="text" id="jobName" name="jobName" value="<%=jobName %>" class="form-control" placeholder="请输入职位名称">
			</div>






			<div class="form-group">
				<label for="xlyq">学历要求:</label>
				<input type="text" id="xlyq" name="xlyq" value="<%=xlyq %>" class="form-control" placeholder="请输入学历要求">
			</div>






			<div class="form-group">
				<label for="gzqy">工作区域:</label>
				<input type="text" id="gzqy" name="gzqy" value="<%=gzqy %>" class="form-control" placeholder="请输入工作区域">
			</div>






            <div class="form-group">
            	<label for="companyObj_companyUserName">发布企业：</label>
                <select id="companyObj_companyUserName" name="companyObj.companyUserName" class="form-control">
                	<option value="">不限制</option>
	 				<%
	 				for(Company companyTemp:companyList) {
	 					String selected = "";
 					if(companyObj!=null && companyObj.getCompanyUserName()!=null && companyObj.getCompanyUserName().equals(companyTemp.getCompanyUserName()))
 						selected = "selected";
	 				%>
 				 <option value="<%=companyTemp.getCompanyUserName() %>" <%=selected %>><%=companyTemp.getCompanyName() %></option>
	 				<%
	 				}
	 				%>
 			</select>
            </div>
			<div class="form-group">
				<label for="addTime">发布时间:</label>
				<input type="text" id="addTime" name="addTime" class="form-control"  placeholder="请选择发布时间" value="<%=addTime %>" onclick="SelectDate(this,'yyyy-MM-dd')" />
			</div>
            <input type=hidden name=currentPage value="<%=currentPage %>" />
            <button type="submit" class="btn btn-primary">查询</button>
        </form>
	</div>

		</div>
	</div> 
<div id="jobEditDialog" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog" style="width:900px;" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title"><i class="fa fa-edit"></i>&nbsp;职位信息编辑</h4>
      </div>
      <div class="modal-body" style="height:450px; overflow: scroll;">
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
			 	<textarea name="job.jobDesc" id="job_jobDesc_edit" style="width:100%;height:500px;"></textarea>
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
		</form> 
	    <style>#jobEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
      <div class="modal-footer"> 
      	<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
      	<button type="button" class="btn btn-primary" onclick="ajaxJobModify();">提交</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
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
//实例化编辑器
var job_jobDesc_edit = UE.getEditor('job_jobDesc_edit'); //职位描述编辑器
var basePath = "<%=basePath%>";
/*跳转到查询结果的某页*/
function GoToPage(currentPage,totalPage) {
    if(currentPage==0) return;
    if(currentPage>totalPage) return;
    document.jobQueryForm.currentPage.value = currentPage;
    document.jobQueryForm.submit();
}

/*可以直接跳转到某页*/
function changepage(totalPage)
{
    var pageValue=document.jobQueryForm.pageValue.value;
    if(pageValue>totalPage) {
        alert('你输入的页码超出了总页数!');
        return ;
    }
    document.jobQueryForm.currentPage.value = pageValue;
    documentjobQueryForm.submit();
}

/*弹出修改职位界面并初始化数据*/
function jobEdit(jobId) {
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
				job_jobDesc_edit.setContent(job.jobDesc, false);
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
				$('#jobEditDialog').modal('show');
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*删除职位信息*/
function jobDelete(jobId) {
	if(confirm("确认删除这个记录")) {
		$.ajax({
			type : "POST",
			url : basePath + "Job/deletes",
			data : {
				jobIds : jobId,
			},
			success : function (obj) {
				if (obj.success) {
					alert("删除成功");
					$("#jobQueryForm").submit();
					//location.href= basePath + "Job/frontlist";
				}
				else 
					alert(obj.message);
			},
		});
	}
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
})
</script>
</body>
</html>

