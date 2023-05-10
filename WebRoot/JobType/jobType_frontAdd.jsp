<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
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
<title>职位类别添加</title>
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
			    	<li role="presentation" ><a href="<%=basePath %>JobType/frontlist">职位类别列表</a></li>
			    	<li role="presentation" class="active"><a href="#jobTypeAdd" aria-controls="jobTypeAdd" role="tab" data-toggle="tab">添加职位类别</a></li>
				</ul>
				<!-- Tab panes -->
				<div class="tab-content">
				    <div role="tabpanel" class="tab-pane" id="jobTypeList">
				    </div>
				    <div role="tabpanel" class="tab-pane active" id="jobTypeAdd"> 
				      	<form class="form-horizontal" name="jobTypeAddForm" id="jobTypeAddForm" enctype="multipart/form-data" method="post"  class="mar_t15">
						  <div class="form-group">
						  	 <label for="jobType_jobTypeName" class="col-md-2 text-right">职位类别名称:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="jobType_jobTypeName" name="jobType.jobTypeName" class="form-control" placeholder="请输入职位类别名称">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="jobType_jobTypeDesc" class="col-md-2 text-right">职位类别描述:</label>
						  	 <div class="col-md-8">
							    <textarea id="jobType_jobTypeDesc" name="jobType.jobTypeDesc" rows="8" class="form-control" placeholder="请输入职位类别描述"></textarea>
							 </div>
						  </div>
				          <div class="form-group">
				             <span class="col-md-2""></span>
				             <span onclick="ajaxJobTypeAdd();" class="btn btn-primary bottom5 top5">添加</span>
				          </div>
						</form> 
				        <style>#jobTypeAddForm .form-group {margin:10px;}  </style>
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
	//提交添加职位类别信息
	function ajaxJobTypeAdd() { 
		//提交之前先验证表单
		$("#jobTypeAddForm").data('bootstrapValidator').validate();
		if(!$("#jobTypeAddForm").data('bootstrapValidator').isValid()){
			return;
		}
		jQuery.ajax({
			type : "post",
			url : basePath + "JobType/add",
			dataType : "json" , 
			data: new FormData($("#jobTypeAddForm")[0]),
			success : function(obj) {
				if(obj.success){ 
					alert("保存成功！");
					$("#jobTypeAddForm").find("input").val("");
					$("#jobTypeAddForm").find("textarea").val("");
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
	//验证职位类别添加表单字段
	$('#jobTypeAddForm').bootstrapValidator({
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
			"jobType.jobTypeName": {
				validators: {
					notEmpty: {
						message: "职位类别名称不能为空",
					}
				}
			},
			"jobType.jobTypeDesc": {
				validators: {
					notEmpty: {
						message: "职位类别描述不能为空",
					}
				}
			},
		}
	}); 
})
</script>
</body>
</html>
