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
<title>企业添加</title>
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
  			<li><a href="<%=basePath %>Company/frontlist">企业管理</a></li>
  			<li class="active">添加企业</li>
		</ul>
		<div class="row">
			<div class="col-md-10">
		      	<form class="form-horizontal" name="companyAddForm" id="companyAddForm" enctype="multipart/form-data" method="post"  class="mar_t15">
				  <div class="form-group">
					 <label for="company_companyUserName" class="col-md-2 text-right">企业用户名:</label>
					 <div class="col-md-8"> 
					 	<input type="text" id="company_companyUserName" name="company.companyUserName" class="form-control" placeholder="请输入企业用户名">
					 </div>
				  </div> 
				  <div class="form-group">
				  	 <label for="company_password" class="col-md-2 text-right">登录密码:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="company_password" name="company.password" class="form-control" placeholder="请输入登录密码">
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="company_qyjb" class="col-md-2 text-right">信用级别:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="company_qyjb" name="company.qyjb" class="form-control" placeholder="请输入信用级别">
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="company_companyName" class="col-md-2 text-right">企业名称:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="company_companyName" name="company.companyName" class="form-control" placeholder="请输入企业名称">
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="company_gszch" class="col-md-2 text-right">工商注册号:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="company_gszch" name="company.gszch" class="form-control" placeholder="请输入工商注册号">
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="company_yyzz" class="col-md-2 text-right">营业执照:</label>
				  	 <div class="col-md-8">
					    <img  class="img-responsive" id="company_yyzzImg" border="0px"/><br/>
					    <input type="hidden" id="company_yyzz" name="company.yyzz"/>
					    <input id="yyzzFile" name="yyzzFile" type="file" size="50" />
				  	 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="company_gsxz" class="col-md-2 text-right">公司性质:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="company_gsxz" name="company.gsxz" class="form-control" placeholder="请输入公司性质">
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="company_gsgm" class="col-md-2 text-right">公司规模:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="company_gsgm" name="company.gsgm" class="form-control" placeholder="请输入公司规模">
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="company_gghy" class="col-md-2 text-right">公司行业:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="company_gghy" name="company.gghy" class="form-control" placeholder="请输入公司行业">
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="company_lxr" class="col-md-2 text-right">联系人:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="company_lxr" name="company.lxr" class="form-control" placeholder="请输入联系人">
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="company_lxdh" class="col-md-2 text-right">联系电话:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="company_lxdh" name="company.lxdh" class="form-control" placeholder="请输入联系电话">
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="company_companyDesc" class="col-md-2 text-right">公司介绍:</label>
				  	 <div class="col-md-8">
							    <textarea name="company.companyDesc" id="company_companyDesc" style="width:100%;height:500px;"></textarea>
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="company_address" class="col-md-2 text-right">公司地址:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="company_address" name="company.address" class="form-control" placeholder="请输入公司地址">
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="company_shzt" class="col-md-2 text-right">审核状态:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="company_shzt" name="company.shzt" class="form-control" placeholder="请输入审核状态">
					 </div>
				  </div>
		          <div class="form-group">
		             <span class="col-md-2""></span>
		             <span onclick="ajaxCompanyAdd();" class="btn btn-primary bottom5 top5">添加</span>
		          </div> 
		          <style>#companyAddForm .form-group {margin:5px;}  </style>  
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
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/ueditor.all.min.js"> </script>
<!--建议手动加在语言，避免在ie下有时因为加载语言失败导致编辑器加载失败-->
<!--这里加载的语言文件会覆盖你在配置项目里添加的语言类型，比如你在配置项目里配置的是英文，这里加载的中文，那最后就是中文-->
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/lang/zh-cn/zh-cn.js"></script>
<script>
//实例化编辑器
var company_companyDesc_editor = UE.getEditor('company_companyDesc'); //公司介绍编辑器
var basePath = "<%=basePath%>";
	//提交添加企业信息
	function ajaxCompanyAdd() { 
		//提交之前先验证表单
		$("#companyAddForm").data('bootstrapValidator').validate();
		if(!$("#companyAddForm").data('bootstrapValidator').isValid()){
			return;
		}
		if(company_companyDesc_editor.getContent() == "") {
			alert('公司介绍不能为空');
			return;
		}
		jQuery.ajax({
			type : "post",
			url : basePath + "Company/add",
			dataType : "json" , 
			data: new FormData($("#companyAddForm")[0]),
			success : function(obj) {
				if(obj.success){ 
					alert("保存成功！");
					$("#companyAddForm").find("input").val("");
					$("#companyAddForm").find("textarea").val("");
					company_companyDesc_editor.setContent("");
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
	//验证企业添加表单字段
	$('#companyAddForm').bootstrapValidator({
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
			"company.companyUserName": {
				validators: {
					notEmpty: {
						message: "企业用户名不能为空",
					}
				}
			},
			"company.password": {
				validators: {
					notEmpty: {
						message: "登录密码不能为空",
					}
				}
			},
			"company.qyjb": {
				validators: {
					notEmpty: {
						message: "信用级别不能为空",
					}
				}
			},
			"company.companyName": {
				validators: {
					notEmpty: {
						message: "企业名称不能为空",
					}
				}
			},
			"company.gszch": {
				validators: {
					notEmpty: {
						message: "工商注册号不能为空",
					}
				}
			},
			"company.gsxz": {
				validators: {
					notEmpty: {
						message: "公司性质不能为空",
					}
				}
			},
			"company.gsgm": {
				validators: {
					notEmpty: {
						message: "公司规模不能为空",
					}
				}
			},
			"company.gghy": {
				validators: {
					notEmpty: {
						message: "公司行业不能为空",
					}
				}
			},
			"company.lxr": {
				validators: {
					notEmpty: {
						message: "联系人不能为空",
					}
				}
			},
			"company.lxdh": {
				validators: {
					notEmpty: {
						message: "联系电话不能为空",
					}
				}
			},
			"company.address": {
				validators: {
					notEmpty: {
						message: "公司地址不能为空",
					}
				}
			},
			"company.shzt": {
				validators: {
					notEmpty: {
						message: "审核状态不能为空",
					}
				}
			},
		}
	}); 
})
</script>
</body>
</html>
