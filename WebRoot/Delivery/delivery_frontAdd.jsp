<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Job" %>
<%@ page import="com.chengxusheji.po.UserInfo" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>简历投递添加</title>
<link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
<link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
<link href="<%=basePath %>plugins/animate.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
</head>
<body style="margin-top:70px;">
<jsp:include page="../header.jsp"></jsp:include>
<div class="container">
	<div class="row">
		<div class="col-md-12 wow fadeInUp" data-wow-duration="0.5s">
			<div>
				<!-- Nav tabs -->
				<ul class="nav nav-tabs" role="tablist">
			    	<li role="presentation" ><a href="<%=basePath %>Delivery/frontlist">简历投递列表</a></li>
			    	<li role="presentation" class="active"><a href="#deliveryAdd" aria-controls="deliveryAdd" role="tab" data-toggle="tab">添加简历投递</a></li>
				</ul>
				<!-- Tab panes -->
				<div class="tab-content">
				    <div role="tabpanel" class="tab-pane" id="deliveryList">
				    </div>
				    <div role="tabpanel" class="tab-pane active" id="deliveryAdd"> 
				      	<form class="form-horizontal" name="deliveryAddForm" id="deliveryAddForm" enctype="multipart/form-data" method="post"  class="mar_t15">
						  <div class="form-group">
						  	 <label for="delivery_jobObj_jobId" class="col-md-2 text-right">应聘职位:</label>
						  	 <div class="col-md-8">
							    <select id="delivery_jobObj_jobId" name="delivery.jobObj.jobId" class="form-control">
							    </select>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="delivery_userObj_user_name" class="col-md-2 text-right">应聘人:</label>
						  	 <div class="col-md-8">
							    <select id="delivery_userObj_user_name" name="delivery.userObj.user_name" class="form-control">
							    </select>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="delivery_deliveryTimeDiv" class="col-md-2 text-right">投递时间:</label>
						  	 <div class="col-md-8">
				                <div id="delivery_deliveryTimeDiv" class="input-group date delivery_deliveryTime col-md-12" data-link-field="delivery_deliveryTime">
				                    <input class="form-control" id="delivery_deliveryTime" name="delivery.deliveryTime" size="16" type="text" value="" placeholder="请选择投递时间" readonly>
				                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
				                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
				                </div>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="delivery_handleTimeDiv" class="col-md-2 text-right">处理时间:</label>
						  	 <div class="col-md-8">
				                <div id="delivery_handleTimeDiv" class="input-group date delivery_handleTime col-md-12" data-link-field="delivery_handleTime">
				                    <input class="form-control" id="delivery_handleTime" name="delivery.handleTime" size="16" type="text" value="" placeholder="请选择处理时间" readonly>
				                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
				                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
				                </div>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="delivery_clzt" class="col-md-2 text-right">处理状态:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="delivery_clzt" name="delivery.clzt" class="form-control" placeholder="请输入处理状态">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="delivery_tzxx" class="col-md-2 text-right">通知信息:</label>
						  	 <div class="col-md-8">
							    <textarea id="delivery_tzxx" name="delivery.tzxx" rows="8" class="form-control" placeholder="请输入通知信息"></textarea>
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="delivery_gzpj" class="col-md-2 text-right">工作评价:</label>
						  	 <div class="col-md-8">
							    <textarea id="delivery_gzpj" name="delivery.gzpj" rows="8" class="form-control" placeholder="请输入工作评价"></textarea>
							 </div>
						  </div>
				          <div class="form-group">
				             <span class="col-md-2""></span>
				             <span onclick="ajaxDeliveryAdd();" class="btn btn-primary bottom5 top5">添加</span>
				          </div>
						</form> 
				        <style>#deliveryAddForm .form-group {margin:10px;}  </style>
					</div>
				</div>
			</div>
		</div>
	</div> 
</div>

<jsp:include page="../footer.jsp"></jsp:include> 
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap.js"></script>
<script src="<%=basePath %>plugins/wow.min.js"></script>
<script src="<%=basePath %>plugins/bootstrapvalidator/js/bootstrapValidator.min.js"></script>
<script type="text/javascript" src="<%=basePath %>plugins/bootstrap-datetimepicker.min.js" charset="UTF-8"></script>
<script type="text/javascript" src="<%=basePath %>plugins/locales/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8"></script>
<script>
var basePath = "<%=basePath%>";
	//提交添加简历投递信息
	function ajaxDeliveryAdd() { 
		//提交之前先验证表单
		$("#deliveryAddForm").data('bootstrapValidator').validate();
		if(!$("#deliveryAddForm").data('bootstrapValidator').isValid()){
			return;
		}
		jQuery.ajax({
			type : "post",
			url : basePath + "Delivery/add",
			dataType : "json" , 
			data: new FormData($("#deliveryAddForm")[0]),
			success : function(obj) {
				if(obj.success){ 
					alert("保存成功！");
					$("#deliveryAddForm").find("input").val("");
					$("#deliveryAddForm").find("textarea").val("");
				} else {
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
	//验证简历投递添加表单字段
	$('#deliveryAddForm').bootstrapValidator({
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
			"delivery.deliveryTime": {
				validators: {
					notEmpty: {
						message: "投递时间不能为空",
					}
				}
			},
			"delivery.handleTime": {
				validators: {
					notEmpty: {
						message: "处理时间不能为空",
					}
				}
			},
			"delivery.clzt": {
				validators: {
					notEmpty: {
						message: "处理状态不能为空",
					}
				}
			},
			"delivery.tzxx": {
				validators: {
					notEmpty: {
						message: "通知信息不能为空",
					}
				}
			},
			"delivery.gzpj": {
				validators: {
					notEmpty: {
						message: "工作评价不能为空",
					}
				}
			},
		}
	}); 
	//初始化应聘职位下拉框值 
	$.ajax({
		url: basePath + "Job/listAll",
		type: "get",
		success: function(jobs,response,status) { 
			$("#delivery_jobObj_jobId").empty();
			var html="";
    		$(jobs).each(function(i,job){
    			html += "<option value='" + job.jobId + "'>" + job.jobName + "</option>";
    		});
    		$("#delivery_jobObj_jobId").html(html);
    	}
	});
	//初始化应聘人下拉框值 
	$.ajax({
		url: basePath + "UserInfo/listAll",
		type: "get",
		success: function(userInfos,response,status) { 
			$("#delivery_userObj_user_name").empty();
			var html="";
    		$(userInfos).each(function(i,userInfo){
    			html += "<option value='" + userInfo.user_name + "'>" + userInfo.name + "</option>";
    		});
    		$("#delivery_userObj_user_name").html(html);
    	}
	});
	//投递时间组件
	$('#delivery_deliveryTimeDiv').datetimepicker({
		language:  'zh-CN',  //显示语言
		format: 'yyyy-mm-dd hh:ii:ss',
		weekStart: 1,
		todayBtn:  1,
		autoclose: 1,
		minuteStep: 1,
		todayHighlight: 1,
		startView: 2,
		forceParse: 0
	}).on('hide',function(e) {
		//下面这行代码解决日期组件改变日期后不验证的问题
		$('#deliveryAddForm').data('bootstrapValidator').updateStatus('delivery.deliveryTime', 'NOT_VALIDATED',null).validateField('delivery.deliveryTime');
	});
	//处理时间组件
	$('#delivery_handleTimeDiv').datetimepicker({
		language:  'zh-CN',  //显示语言
		format: 'yyyy-mm-dd hh:ii:ss',
		weekStart: 1,
		todayBtn:  1,
		autoclose: 1,
		minuteStep: 1,
		todayHighlight: 1,
		startView: 2,
		forceParse: 0
	}).on('hide',function(e) {
		//下面这行代码解决日期组件改变日期后不验证的问题
		$('#deliveryAddForm').data('bootstrapValidator').updateStatus('delivery.handleTime', 'NOT_VALIDATED',null).validateField('delivery.handleTime');
	});
})
</script>
</body>
</html>
