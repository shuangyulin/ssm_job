<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.WebLink" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    List<WebLink> webLinkList = (List<WebLink>)request.getAttribute("webLinkList");
    int currentPage =  (Integer)request.getAttribute("currentPage"); //当前页
    int totalPage =   (Integer)request.getAttribute("totalPage");  //一共多少页
    int recordNumber =   (Integer)request.getAttribute("recordNumber");  //一共多少记录
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>友情链接查询</title>
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
  			<li><a href="<%=basePath %>WebLink/frontlist">友情链接信息列表</a></li>
  			<li class="active">查询结果显示</li>
  			<a class="pull-right" href="<%=basePath %>WebLink/webLink_frontAdd.jsp" style="display:none;">添加友情链接</a>
		</ul>
		<div class="row">
			<%
				/*计算起始序号*/
				int startIndex = (currentPage -1) * 5;
				/*遍历记录*/
				for(int i=0;i<webLinkList.size();i++) {
            		int currentIndex = startIndex + i + 1; //当前记录的序号
            		WebLink webLink = webLinkList.get(i); //获取到友情链接对象
            		String clearLeft = "";
            		if(i%4 == 0) clearLeft = "style=\"clear:left;\"";
			%>
			<div class="col-md-3 bottom15" <%=clearLeft %>>
			  <a  href="<%=basePath  %>WebLink/<%=webLink.getLinkId() %>/frontshow"><img class="img-responsive" src="<%=basePath%><%=webLink.getWebLogo()%>" /></a>
			     <div class="showFields">
			     	<div class="field">
	            		记录id:<%=webLink.getLinkId() %>
			     	</div>
			     	<div class="field">
	            		网站名称:<%=webLink.getWebName() %>
			     	</div>
			     	<div class="field">
	            		网站地址:<%=webLink.getWebAddress() %>
			     	</div>
			        <a class="btn btn-primary top5" href="<%=basePath %>WebLink/<%=webLink.getLinkId() %>/frontshow">详情</a>
			        <a class="btn btn-primary top5" onclick="webLinkEdit('<%=webLink.getLinkId() %>');" style="display:none;">修改</a>
			        <a class="btn btn-primary top5" onclick="webLinkDelete('<%=webLink.getLinkId() %>');" style="display:none;">删除</a>
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

</div>
<div id="webLinkEditDialog" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title"><i class="fa fa-edit"></i>&nbsp;友情链接信息编辑</h4>
      </div>
      <div class="modal-body" style="height:450px; overflow: scroll;">
      	<form class="form-horizontal" name="webLinkEditForm" id="webLinkEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="webLink_linkId_edit" class="col-md-3 text-right">记录id:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="webLink_linkId_edit" name="webLink.linkId" class="form-control" placeholder="请输入记录id" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="webLink_webName_edit" class="col-md-3 text-right">网站名称:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="webLink_webName_edit" name="webLink.webName" class="form-control" placeholder="请输入网站名称">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="webLink_webLogo_edit" class="col-md-3 text-right">网站Logo:</label>
		  	 <div class="col-md-9">
			    <img  class="img-responsive" id="webLink_webLogoImg" border="0px"/><br/>
			    <input type="hidden" id="webLink_webLogo" name="webLink.webLogo"/>
			    <input id="webLogoFile" name="webLogoFile" type="file" size="50" />
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="webLink_webAddress_edit" class="col-md-3 text-right">网站地址:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="webLink_webAddress_edit" name="webLink.webAddress" class="form-control" placeholder="请输入网站地址">
			 </div>
		  </div>
		</form> 
	    <style>#webLinkEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
      <div class="modal-footer"> 
      	<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
      	<button type="button" class="btn btn-primary" onclick="ajaxWebLinkModify();">提交</button>
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
<script>
var basePath = "<%=basePath%>";
/*跳转到查询结果的某页*/
function GoToPage(currentPage,totalPage) {
    if(currentPage==0) return;
    if(currentPage>totalPage) return;
    document.webLinkQueryForm.currentPage.value = currentPage;
    document.webLinkQueryForm.submit();
}

/*可以直接跳转到某页*/
function changepage(totalPage)
{
    var pageValue=document.webLinkQueryForm.pageValue.value;
    if(pageValue>totalPage) {
        alert('你输入的页码超出了总页数!');
        return ;
    }
    document.webLinkQueryForm.currentPage.value = pageValue;
    documentwebLinkQueryForm.submit();
}

/*弹出修改友情链接界面并初始化数据*/
function webLinkEdit(linkId) {
	$.ajax({
		url :  basePath + "WebLink/" + linkId + "/update",
		type : "get",
		dataType: "json",
		success : function (webLink, response, status) {
			if (webLink) {
				$("#webLink_linkId_edit").val(webLink.linkId);
				$("#webLink_webName_edit").val(webLink.webName);
				$("#webLink_webLogo").val(webLink.webLogo);
				$("#webLink_webLogoImg").attr("src", basePath +　webLink.webLogo);
				$("#webLink_webAddress_edit").val(webLink.webAddress);
				$('#webLinkEditDialog').modal('show');
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*删除友情链接信息*/
function webLinkDelete(linkId) {
	if(confirm("确认删除这个记录")) {
		$.ajax({
			type : "POST",
			url : basePath + "WebLink/deletes",
			data : {
				linkIds : linkId,
			},
			success : function (obj) {
				if (obj.success) {
					alert("删除成功");
					$("#webLinkQueryForm").submit();
					//location.href= basePath + "WebLink/frontlist";
				}
				else 
					alert(obj.message);
			},
		});
	}
}

/*ajax方式提交友情链接信息表单给服务器端修改*/
function ajaxWebLinkModify() {
	$.ajax({
		url :  basePath + "WebLink/" + $("#webLink_linkId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#webLinkEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                location.href= basePath + "WebLink/frontlist";
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

