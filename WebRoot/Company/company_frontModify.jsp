<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Company" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    Company company = (Company)request.getAttribute("company");

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <TITLE>修改企业信息</TITLE>
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
  		<li class="active">企业信息修改</li>
	</ul>
		<div class="row"> 
      	<form class="form-horizontal" name="companyEditForm" id="companyEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="company_companyUserName_edit" class="col-md-3 text-right">企业用户名:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="company_companyUserName_edit" name="company.companyUserName" class="form-control" placeholder="请输入企业用户名" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="company_password_edit" class="col-md-3 text-right">登录密码:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="company_password_edit" name="company.password" class="form-control" placeholder="请输入登录密码">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="company_qyjb_edit" class="col-md-3 text-right">信用级别:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="company_qyjb_edit" name="company.qyjb" class="form-control" placeholder="请输入信用级别">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="company_companyName_edit" class="col-md-3 text-right">企业名称:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="company_companyName_edit" name="company.companyName" class="form-control" placeholder="请输入企业名称">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="company_gszch_edit" class="col-md-3 text-right">工商注册号:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="company_gszch_edit" name="company.gszch" class="form-control" placeholder="请输入工商注册号">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="company_yyzz_edit" class="col-md-3 text-right">营业执照:</label>
		  	 <div class="col-md-9">
			    <img  class="img-responsive" id="company_yyzzImg" border="0px"/><br/>
			    <input type="hidden" id="company_yyzz" name="company.yyzz"/>
			    <input id="yyzzFile" name="yyzzFile" type="file" size="50" />
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="company_gsxz_edit" class="col-md-3 text-right">公司性质:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="company_gsxz_edit" name="company.gsxz" class="form-control" placeholder="请输入公司性质">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="company_gsgm_edit" class="col-md-3 text-right">公司规模:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="company_gsgm_edit" name="company.gsgm" class="form-control" placeholder="请输入公司规模">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="company_gghy_edit" class="col-md-3 text-right">公司行业:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="company_gghy_edit" name="company.gghy" class="form-control" placeholder="请输入公司行业">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="company_lxr_edit" class="col-md-3 text-right">联系人:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="company_lxr_edit" name="company.lxr" class="form-control" placeholder="请输入联系人">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="company_lxdh_edit" class="col-md-3 text-right">联系电话:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="company_lxdh_edit" name="company.lxdh" class="form-control" placeholder="请输入联系电话">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="company_companyDesc_edit" class="col-md-3 text-right">公司介绍:</label>
		  	 <div class="col-md-9">
			    <script name="company.companyDesc" id="company_companyDesc_edit" type="text/plain"   style="width:100%;height:500px;"></script>
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="company_address_edit" class="col-md-3 text-right">公司地址:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="company_address_edit" name="company.address" class="form-control" placeholder="请输入公司地址">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="company_shzt_edit" class="col-md-3 text-right">审核状态:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="company_shzt_edit" name="company.shzt" class="form-control" placeholder="请输入审核状态">
			 </div>
		  </div>
			  <div class="form-group">
			  	<span class="col-md-3""></span>
			  	<span onclick="ajaxCompanyModify();" class="btn btn-primary bottom5 top5">修改</span>
			  </div>
		</form> 
	    <style>#companyEditForm .form-group {margin-bottom:5px;}  </style>
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
var company_companyDesc_editor = UE.getEditor('company_companyDesc_edit'); //公司介绍编辑框
var basePath = "<%=basePath%>";
/*弹出修改企业界面并初始化数据*/
function companyEdit(companyUserName) {
  company_companyDesc_editor.addListener("ready", function () {
    // editor准备好之后才可以使用 
    ajaxModifyQuery(companyUserName);
  });
}
 function ajaxModifyQuery(companyUserName) {
	$.ajax({
		url :  basePath + "Company/" + companyUserName + "/update",
		type : "get",
		dataType: "json",
		success : function (company, response, status) {
			if (company) {
				$("#company_companyUserName_edit").val(company.companyUserName);
				$("#company_password_edit").val(company.password);
				$("#company_qyjb_edit").val(company.qyjb);
				$("#company_companyName_edit").val(company.companyName);
				$("#company_gszch_edit").val(company.gszch);
				$("#company_yyzz").val(company.yyzz);
				$("#company_yyzzImg").attr("src", basePath +　company.yyzz);
				$("#company_gsxz_edit").val(company.gsxz);
				$("#company_gsgm_edit").val(company.gsgm);
				$("#company_gghy_edit").val(company.gghy);
				$("#company_lxr_edit").val(company.lxr);
				$("#company_lxdh_edit").val(company.lxdh);
				company_companyDesc_editor.setContent(company.companyDesc, false);
				$("#company_address_edit").val(company.address);
				$("#company_shzt_edit").val(company.shzt);
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*ajax方式提交企业信息表单给服务器端修改*/
function ajaxCompanyModify() {
	$.ajax({
		url :  basePath + "Company/" + $("#company_companyUserName_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#companyEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                location.reload(true);
                $("#companyQueryForm").submit();
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
    companyEdit("<%=request.getParameter("companyUserName")%>");
 })
 </script> 
</body>
</html>

