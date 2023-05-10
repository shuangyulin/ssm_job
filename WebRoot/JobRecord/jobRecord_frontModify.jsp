<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.JobRecord" %>
<%@ page import="com.chengxusheji.po.UserInfo" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    //获取所有的userObj信息
    List<UserInfo> userInfoList = (List<UserInfo>)request.getAttribute("userInfoList");
    JobRecord jobRecord = (JobRecord)request.getAttribute("jobRecord");

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <TITLE>修改兼职记录信息</TITLE>
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
  		<li class="active">兼职记录信息修改</li>
	</ul>
		<div class="row"> 
      	<form class="form-horizontal" name="jobRecordEditForm" id="jobRecordEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="jobRecord_recordId_edit" class="col-md-3 text-right">记录id:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="jobRecord_recordId_edit" name="jobRecord.recordId" class="form-control" placeholder="请输入记录id" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="jobRecord_title_edit" class="col-md-3 text-right">标题:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="jobRecord_title_edit" name="jobRecord.title" class="form-control" placeholder="请输入标题">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="jobRecord_content_edit" class="col-md-3 text-right">内容:</label>
		  	 <div class="col-md-9">
			    <script name="jobRecord.content" id="jobRecord_content_edit" type="text/plain"   style="width:100%;height:500px;"></script>
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="jobRecord_userObj_user_name_edit" class="col-md-3 text-right">记录人:</label>
		  	 <div class="col-md-9">
			    <select id="jobRecord_userObj_user_name_edit" name="jobRecord.userObj.user_name" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="jobRecord_recordDate_edit" class="col-md-3 text-right">记录时间:</label>
		  	 <div class="col-md-9">
                <div class="input-group date jobRecord_recordDate_edit col-md-12" data-link-field="jobRecord_recordDate_edit">
                    <input class="form-control" id="jobRecord_recordDate_edit" name="jobRecord.recordDate" size="16" type="text" value="" placeholder="请选择记录时间" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
		  	 </div>
		  </div>
			  <div class="form-group">
			  	<span class="col-md-3""></span>
			  	<span onclick="ajaxJobRecordModify();" class="btn btn-primary bottom5 top5">修改</span>
			  </div>
		</form> 
	    <style>#jobRecordEditForm .form-group {margin-bottom:5px;}  </style>
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
var jobRecord_content_editor = UE.getEditor('jobRecord_content_edit'); //内容编辑框
var basePath = "<%=basePath%>";
/*弹出修改兼职记录界面并初始化数据*/
function jobRecordEdit(recordId) {
  jobRecord_content_editor.addListener("ready", function () {
    // editor准备好之后才可以使用 
    ajaxModifyQuery(recordId);
  });
}
 function ajaxModifyQuery(recordId) {
	$.ajax({
		url :  basePath + "JobRecord/" + recordId + "/update",
		type : "get",
		dataType: "json",
		success : function (jobRecord, response, status) {
			if (jobRecord) {
				$("#jobRecord_recordId_edit").val(jobRecord.recordId);
				$("#jobRecord_title_edit").val(jobRecord.title);
				jobRecord_content_editor.setContent(jobRecord.content, false);
				$.ajax({
					url: basePath + "UserInfo/listAll",
					type: "get",
					success: function(userInfos,response,status) { 
						$("#jobRecord_userObj_user_name_edit").empty();
						var html="";
		        		$(userInfos).each(function(i,userInfo){
		        			html += "<option value='" + userInfo.user_name + "'>" + userInfo.name + "</option>";
		        		});
		        		$("#jobRecord_userObj_user_name_edit").html(html);
		        		$("#jobRecord_userObj_user_name_edit").val(jobRecord.userObjPri);
					}
				});
				$("#jobRecord_recordDate_edit").val(jobRecord.recordDate);
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*ajax方式提交兼职记录信息表单给服务器端修改*/
function ajaxJobRecordModify() {
	$.ajax({
		url :  basePath + "JobRecord/" + $("#jobRecord_recordId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#jobRecordEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                location.reload(true);
                $("#jobRecordQueryForm").submit();
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
    /*记录时间组件*/
    $('.jobRecord_recordDate_edit').datetimepicker({
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
    jobRecordEdit("<%=request.getParameter("recordId")%>");
 })
 </script> 
</body>
</html>

