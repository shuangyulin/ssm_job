<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Company" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    List<Company> companyList = (List<Company>)request.getAttribute("companyList");
    int currentPage =  (Integer)request.getAttribute("currentPage"); //当前页
    int totalPage =   (Integer)request.getAttribute("totalPage");  //一共多少页
    int recordNumber =   (Integer)request.getAttribute("recordNumber");  //一共多少记录
    String qyjb = (String)request.getAttribute("qyjb"); //信用级别查询关键字
    String companyName = (String)request.getAttribute("companyName"); //企业名称查询关键字
    String gszch = (String)request.getAttribute("gszch"); //工商注册号查询关键字
    String gsxz = (String)request.getAttribute("gsxz"); //公司性质查询关键字
    String gsgm = (String)request.getAttribute("gsgm"); //公司规模查询关键字
    String gghy = (String)request.getAttribute("gghy"); //公司行业查询关键字
    String lxr = (String)request.getAttribute("lxr"); //联系人查询关键字
    String lxdh = (String)request.getAttribute("lxdh"); //联系电话查询关键字
    String shzt = (String)request.getAttribute("shzt"); //审核状态查询关键字
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>企业查询</title>
<link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
<link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
<link href="<%=basePath %>plugins/animate.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
</head>
<body style="margin-top:70px;">
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="col-md-9 wow fadeInLeft">
		<ul class="breadcrumb">
  			<li><a href="<%=basePath %>index.jsp">首页</a></li>
  			<li><a href="<%=basePath %>Company/frontlist">企业信息列表</a></li>
  			<li class="active">查询结果显示</li>
  			<a class="pull-right" href="<%=basePath %>Company/company_frontAdd.jsp" style="display:none;">添加企业</a>
		</ul>
		<div class="row">
			<%
				/*计算起始序号*/
				int startIndex = (currentPage -1) * 5;
				/*遍历记录*/
				for(int i=0;i<companyList.size();i++) {
            		int currentIndex = startIndex + i + 1; //当前记录的序号
            		Company company = companyList.get(i); //获取到企业对象
            		String clearLeft = "";
            		if(i%4 == 0) clearLeft = "style=\"clear:left;\"";
			%>
			<div class="col-md-3 bottom15" <%=clearLeft %>>
			  <a  href="<%=basePath  %>Company/<%=company.getCompanyUserName() %>/frontshow"><img class="img-responsive" src="<%=basePath%><%=company.getYyzz()%>" /></a>
			     <div class="showFields">
			     	<div class="field">
	            		企业用户名:<%=company.getCompanyUserName() %>
			     	</div>
			     	<div class="field">
	            		信用级别:<%=company.getQyjb() %>
			     	</div>
			     	<div class="field">
	            		企业名称:<%=company.getCompanyName() %>
			     	</div>
			     	<div class="field">
	            		工商注册号:<%=company.getGszch() %>
			     	</div>
			     	<div class="field">
	            		公司性质:<%=company.getGsxz() %>
			     	</div>
			     	<div class="field">
	            		公司规模:<%=company.getGsgm() %>
			     	</div>
			     	<div class="field">
	            		公司行业:<%=company.getGghy() %>
			     	</div>
			     	<div class="field">
	            		联系人:<%=company.getLxr() %>
			     	</div>
			     	<div class="field">
	            		联系电话:<%=company.getLxdh() %>
			     	</div>
			     	<div class="field">
	            		审核状态:<%=company.getShzt() %>
			     	</div>
			        <a class="btn btn-primary top5" href="<%=basePath %>Company/<%=company.getCompanyUserName() %>/frontshow">详情</a>
			        <a class="btn btn-primary top5" onclick="companyEdit('<%=company.getCompanyUserName() %>');" style="display:none;">修改</a>
			        <a class="btn btn-primary top5" onclick="companyDelete('<%=company.getCompanyUserName() %>');" style="display:none;">删除</a>
			     </div>
			</div>
			<%  } %>

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

	<div class="col-md-3 wow fadeInRight">
		<div class="page-header">
    		<h1>企业查询</h1>
		</div>
		<form name="companyQueryForm" id="companyQueryForm" action="<%=basePath %>Company/frontlist" class="mar_t15" method="post">
			<div class="form-group">
				<label for="qyjb">信用级别:</label>
				<input type="text" id="qyjb" name="qyjb" value="<%=qyjb %>" class="form-control" placeholder="请输入信用级别">
			</div>
			<div class="form-group">
				<label for="companyName">企业名称:</label>
				<input type="text" id="companyName" name="companyName" value="<%=companyName %>" class="form-control" placeholder="请输入企业名称">
			</div>
			<div class="form-group">
				<label for="gszch">工商注册号:</label>
				<input type="text" id="gszch" name="gszch" value="<%=gszch %>" class="form-control" placeholder="请输入工商注册号">
			</div>
			<div class="form-group">
				<label for="gsxz">公司性质:</label>
				<input type="text" id="gsxz" name="gsxz" value="<%=gsxz %>" class="form-control" placeholder="请输入公司性质">
			</div>
			<div class="form-group">
				<label for="gsgm">公司规模:</label>
				<input type="text" id="gsgm" name="gsgm" value="<%=gsgm %>" class="form-control" placeholder="请输入公司规模">
			</div>
			<div class="form-group">
				<label for="gghy">公司行业:</label>
				<input type="text" id="gghy" name="gghy" value="<%=gghy %>" class="form-control" placeholder="请输入公司行业">
			</div>
			<div class="form-group">
				<label for="lxr">联系人:</label>
				<input type="text" id="lxr" name="lxr" value="<%=lxr %>" class="form-control" placeholder="请输入联系人">
			</div>
			<div class="form-group">
				<label for="lxdh">联系电话:</label>
				<input type="text" id="lxdh" name="lxdh" value="<%=lxdh %>" class="form-control" placeholder="请输入联系电话">
			</div>
			<div class="form-group">
				<label for="shzt">审核状态:</label>
				<input type="text" id="shzt" name="shzt" value="<%=shzt %>" class="form-control" placeholder="请输入审核状态">
			</div>
            <input type=hidden name=currentPage value="<%=currentPage %>" />
            <button type="submit" class="btn btn-primary">查询</button>
        </form>
	</div>

		</div>
</div>
<div id="companyEditDialog" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog" style="width:900px;" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title"><i class="fa fa-edit"></i>&nbsp;企业信息编辑</h4>
      </div>
      <div class="modal-body" style="height:450px; overflow: scroll;">
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
			 	<textarea name="company.companyDesc" id="company_companyDesc_edit" style="width:100%;height:500px;"></textarea>
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
		</form> 
	    <style>#companyEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
      <div class="modal-footer"> 
      	<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
      	<button type="button" class="btn btn-primary" onclick="ajaxCompanyModify();">提交</button>
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
var company_companyDesc_edit = UE.getEditor('company_companyDesc_edit'); //公司介绍编辑器
var basePath = "<%=basePath%>";
/*跳转到查询结果的某页*/
function GoToPage(currentPage,totalPage) {
    if(currentPage==0) return;
    if(currentPage>totalPage) return;
    document.companyQueryForm.currentPage.value = currentPage;
    document.companyQueryForm.submit();
}

/*可以直接跳转到某页*/
function changepage(totalPage)
{
    var pageValue=document.companyQueryForm.pageValue.value;
    if(pageValue>totalPage) {
        alert('你输入的页码超出了总页数!');
        return ;
    }
    document.companyQueryForm.currentPage.value = pageValue;
    documentcompanyQueryForm.submit();
}

/*弹出修改企业界面并初始化数据*/
function companyEdit(companyUserName) {
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
				company_companyDesc_edit.setContent(company.companyDesc, false);
				$("#company_address_edit").val(company.address);
				$("#company_shzt_edit").val(company.shzt);
				$('#companyEditDialog').modal('show');
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*删除企业信息*/
function companyDelete(companyUserName) {
	if(confirm("确认删除这个记录")) {
		$.ajax({
			type : "POST",
			url : basePath + "Company/deletes",
			data : {
				companyUserNames : companyUserName,
			},
			success : function (obj) {
				if (obj.success) {
					alert("删除成功");
					$("#companyQueryForm").submit();
					//location.href= basePath + "Company/frontlist";
				}
				else 
					alert(obj.message);
			},
		});
	}
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

})
</script>
</body>
</html>

