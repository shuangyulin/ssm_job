<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Delivery" %>
<%@ page import="com.chengxusheji.po.Job" %>
<%@ page import="com.chengxusheji.po.UserInfo" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    //获取所有的jobObj信息
    List<Job> jobList = (List<Job>)request.getAttribute("jobList");
    //获取所有的userObj信息
    List<UserInfo> userInfoList = (List<UserInfo>)request.getAttribute("userInfoList");
    Delivery delivery = (Delivery)request.getAttribute("delivery");

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <TITLE>修改简历投递信息</TITLE>
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
  		<li class="active">简历投递信息修改</li>
	</ul>
		<div class="row"> 
      	<form class="form-horizontal" name="deliveryEditForm" id="deliveryEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="delivery_deliveryId_edit" class="col-md-3 text-right">投递id:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="delivery_deliveryId_edit" name="delivery.deliveryId" class="form-control" placeholder="请输入投递id" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="delivery_jobObj_jobId_edit" class="col-md-3 text-right">应聘职位:</label>
		  	 <div class="col-md-9">
			    <select id="delivery_jobObj_jobId_edit" name="delivery.jobObj.jobId" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="delivery_userObj_user_name_edit" class="col-md-3 text-right">应聘人:</label>
		  	 <div class="col-md-9">
			    <select id="delivery_userObj_user_name_edit" name="delivery.userObj.user_name" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="delivery_deliveryTime_edit" class="col-md-3 text-right">投递时间:</label>
		  	 <div class="col-md-9">
                <div class="input-group date delivery_deliveryTime_edit col-md-12" data-link-field="delivery_deliveryTime_edit">
                    <input class="form-control" id="delivery_deliveryTime_edit" name="delivery.deliveryTime" size="16" type="text" value="" placeholder="请选择投递时间" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="delivery_handleTime_edit" class="col-md-3 text-right">处理时间:</label>
		  	 <div class="col-md-9">
                <div class="input-group date delivery_handleTime_edit col-md-12" data-link-field="delivery_handleTime_edit">
                    <input class="form-control" id="delivery_handleTime_edit" name="delivery.handleTime" size="16" type="text" value="" placeholder="请选择处理时间" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="delivery_clzt_edit" class="col-md-3 text-right">处理状态:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="delivery_clzt_edit" name="delivery.clzt" class="form-control" placeholder="请输入处理状态">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="delivery_tzxx_edit" class="col-md-3 text-right">通知信息:</label>
		  	 <div class="col-md-9">
			    <textarea id="delivery_tzxx_edit" name="delivery.tzxx" rows="8" class="form-control" placeholder="请输入通知信息"></textarea>
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="delivery_gzpj_edit" class="col-md-3 text-right">工作评价:</label>
		  	 <div class="col-md-9">
			    <textarea id="delivery_gzpj_edit" name="delivery.gzpj" rows="8" class="form-control" placeholder="请输入工作评价"></textarea>
			 </div>
		  </div>
			  <div class="form-group">
			  	<span class="col-md-3""></span>
			  	<span onclick="ajaxDeliveryModify();" class="btn btn-primary bottom5 top5">修改</span>
			  </div>
		</form> 
	    <style>#deliveryEditForm .form-group {margin-bottom:5px;}  </style>
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
<script>
var basePath = "<%=basePath%>";
/*弹出修改简历投递界面并初始化数据*/
function deliveryEdit(deliveryId) {
	$.ajax({
		url :  basePath + "Delivery/" + deliveryId + "/update",
		type : "get",
		dataType: "json",
		success : function (delivery, response, status) {
			if (delivery) {
				$("#delivery_deliveryId_edit").val(delivery.deliveryId);
				$.ajax({
					url: basePath + "Job/listAll",
					type: "get",
					success: function(jobs,response,status) { 
						$("#delivery_jobObj_jobId_edit").empty();
						var html="";
		        		$(jobs).each(function(i,job){
		        			html += "<option value='" + job.jobId + "'>" + job.jobName + "</option>";
		        		});
		        		$("#delivery_jobObj_jobId_edit").html(html);
		        		$("#delivery_jobObj_jobId_edit").val(delivery.jobObjPri);
					}
				});
				$.ajax({
					url: basePath + "UserInfo/listAll",
					type: "get",
					success: function(userInfos,response,status) { 
						$("#delivery_userObj_user_name_edit").empty();
						var html="";
		        		$(userInfos).each(function(i,userInfo){
		        			html += "<option value='" + userInfo.user_name + "'>" + userInfo.name + "</option>";
		        		});
		        		$("#delivery_userObj_user_name_edit").html(html);
		        		$("#delivery_userObj_user_name_edit").val(delivery.userObjPri);
					}
				});
				$("#delivery_deliveryTime_edit").val(delivery.deliveryTime);
				$("#delivery_handleTime_edit").val(delivery.handleTime);
				$("#delivery_clzt_edit").val(delivery.clzt);
				$("#delivery_tzxx_edit").val(delivery.tzxx);
				$("#delivery_gzpj_edit").val(delivery.gzpj);
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*ajax方式提交简历投递信息表单给服务器端修改*/
function ajaxDeliveryModify() {
	$.ajax({
		url :  basePath + "Delivery/" + $("#delivery_deliveryId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#deliveryEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                location.reload(true);
                $("#deliveryQueryForm").submit();
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
    /*投递时间组件*/
    $('.delivery_deliveryTime_edit').datetimepicker({
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
    /*处理时间组件*/
    $('.delivery_handleTime_edit').datetimepicker({
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
    deliveryEdit("<%=request.getParameter("deliveryId")%>");
 })
 </script> 
</body>
</html>

