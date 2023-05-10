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
<title>友情链接添加</title>
<link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
<link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
<link href="<%=basePath %>plugins/animate.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
</head>
<body style="margin-top:70px;">
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="col-md-12 wow fadeInLeft">
		<ul class="breadcrumb">
  			<li><a href="<%=basePath %>index.jsp">首页</a></li>
  			<li><a href="<%=basePath %>WebLink/frontlist">友情链接管理</a></li>
  			<li class="active">添加友情链接</li>
		</ul>
		<div class="row">
			<div class="col-md-10">
		      	<form class="form-horizontal" name="webLinkAddForm" id="webLinkAddForm" enctype="multipart/form-data" method="post"  class="mar_t15">
				  <div class="form-group">
				  	 <label for="webLink_webName" class="col-md-2 text-right">网站名称:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="webLink_webName" name="webLink.webName" class="form-control" placeholder="请输入网站名称">
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="webLink_webLogo" class="col-md-2 text-right">网站Logo:</label>
				  	 <div class="col-md-8">
					    <img  class="img-responsive" id="webLink_webLogoImg" border="0px"/><br/>
					    <input type="hidden" id="webLink_webLogo" name="webLink.webLogo"/>
					    <input id="webLogoFile" name="webLogoFile" type="file" size="50" />
				  	 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="webLink_webAddress" class="col-md-2 text-right">网站地址:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="webLink_webAddress" name="webLink.webAddress" class="form-control" placeholder="请输入网站地址">
					 </div>
				  </div>
		          <div class="form-group">
		             <span class="col-md-2""></span>
		             <span onclick="ajaxWebLinkAdd();" class="btn btn-primary bottom5 top5">添加</span>
		          </div> 
		          <style>#webLinkAddForm .form-group {margin:5px;}  </style>  
				</form> 
			</div>
			<div class="col-md-2"></div> 
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
	//提交添加友情链接信息
	function ajaxWebLinkAdd() { 
		//提交之前先验证表单
		$("#webLinkAddForm").data('bootstrapValidator').validate();
		if(!$("#webLinkAddForm").data('bootstrapValidator').isValid()){
			return;
		}
		jQuery.ajax({
			type : "post",
			url : basePath + "WebLink/add",
			dataType : "json" , 
			data: new FormData($("#webLinkAddForm")[0]),
			success : function(obj) {
				if(obj.success){ 
					alert("保存成功！");
					$("#webLinkAddForm").find("input").val("");
					$("#webLinkAddForm").find("textarea").val("");
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
	//验证友情链接添加表单字段
	$('#webLinkAddForm').bootstrapValidator({
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
			"webLink.webName": {
				validators: {
					notEmpty: {
						message: "网站名称不能为空",
					}
				}
			},
			"webLink.webAddress": {
				validators: {
					notEmpty: {
						message: "网站地址不能为空",
					}
				}
			},
		}
	}); 
})
</script>
</body>
</html>
