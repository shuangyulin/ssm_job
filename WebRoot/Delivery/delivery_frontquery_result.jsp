<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Delivery" %>
<%@ page import="com.chengxusheji.po.Job" %>
<%@ page import="com.chengxusheji.po.UserInfo" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    List<Delivery> deliveryList = (List<Delivery>)request.getAttribute("deliveryList");
    //获取所有的jobObj信息
    List<Job> jobList = (List<Job>)request.getAttribute("jobList");
    //获取所有的userObj信息
    List<UserInfo> userInfoList = (List<UserInfo>)request.getAttribute("userInfoList");
    int currentPage =  (Integer)request.getAttribute("currentPage"); //当前页
    int totalPage =   (Integer)request.getAttribute("totalPage");  //一共多少页
    int recordNumber =   (Integer)request.getAttribute("recordNumber");  //一共多少记录
    Job jobObj = (Job)request.getAttribute("jobObj");
    UserInfo userObj = (UserInfo)request.getAttribute("userObj");
    String deliveryTime = (String)request.getAttribute("deliveryTime"); //投递时间查询关键字
    String handleTime = (String)request.getAttribute("handleTime"); //处理时间查询关键字
    String clzt = (String)request.getAttribute("clzt"); //处理状态查询关键字
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>简历投递查询</title>
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
			    	<li role="presentation" class="active"><a href="#deliveryListPanel" aria-controls="deliveryListPanel" role="tab" data-toggle="tab">简历投递列表</a></li>
			    	<li role="presentation" ><a href="<%=basePath %>Delivery/delivery_frontAdd.jsp" style="display:none;">添加简历投递</a></li>
				</ul>
			  	<!-- Tab panes -->
			  	<div class="tab-content">
				    <div role="tabpanel" class="tab-pane active" id="deliveryListPanel">
				    		<div class="row">
				    			<div class="col-md-12 top5">
				    				<div class="table-responsive">
				    				<table class="table table-condensed table-hover">
				    					<tr class="success bold"><td>序号</td><td>投递id</td><td>应聘职位</td><td>应聘人</td><td>投递时间</td><td>处理时间</td><td>处理状态</td><td>通知信息</td><td>工作评价</td><td>操作</td></tr>
				    					<% 
				    						/*计算起始序号*/
				    	            		int startIndex = (currentPage -1) * 5;
				    	            		/*遍历记录*/
				    	            		for(int i=0;i<deliveryList.size();i++) {
					    	            		int currentIndex = startIndex + i + 1; //当前记录的序号
					    	            		Delivery delivery = deliveryList.get(i); //获取到简历投递对象
 										%>
 										<tr>
 											<td><%=currentIndex %></td>
 											<td><%=delivery.getDeliveryId() %></td>
 											<td><%=delivery.getJobObj().getJobName() %></td>
 											<td><%=delivery.getUserObj().getName() %></td>
 											<td><%=delivery.getDeliveryTime() %></td>
 											<td><%=delivery.getHandleTime() %></td>
 											<td><%=delivery.getClzt() %></td>
 											<td><%=delivery.getTzxx() %></td>
 											<td><%=delivery.getGzpj() %></td>
 											<td>
 												<a href="<%=basePath  %>Delivery/<%=delivery.getDeliveryId() %>/frontshow"><i class="fa fa-info"></i>&nbsp;查看</a>&nbsp;
 												<a href="#" onclick="deliveryEdit('<%=delivery.getDeliveryId() %>');" style="display:none;"><i class="fa fa-pencil fa-fw"></i>编辑</a>&nbsp;
 												<a href="#" onclick="deliveryDelete('<%=delivery.getDeliveryId() %>');" style="display:none;"><i class="fa fa-trash-o fa-fw"></i>删除</a>
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
    		<h1>简历投递查询</h1>
		</div>
		<form name="deliveryQueryForm" id="deliveryQueryForm" action="<%=basePath %>Delivery/frontlist" class="mar_t15" method="post">
            <div class="form-group">
            	<label for="jobObj_jobId">应聘职位：</label>
                <select id="jobObj_jobId" name="jobObj.jobId" class="form-control">
                	<option value="0">不限制</option>
	 				<%
	 				for(Job jobTemp:jobList) {
	 					String selected = "";
 					if(jobObj!=null && jobObj.getJobId()!=null && jobObj.getJobId().intValue()==jobTemp.getJobId().intValue())
 						selected = "selected";
	 				%>
 				 <option value="<%=jobTemp.getJobId() %>" <%=selected %>><%=jobTemp.getJobName() %></option>
	 				<%
	 				}
	 				%>
 			</select>
            </div>
            <div class="form-group">
            	<label for="userObj_user_name">应聘人：</label>
                <select id="userObj_user_name" name="userObj.user_name" class="form-control">
                	<option value="">不限制</option>
	 				<%
	 				for(UserInfo userInfoTemp:userInfoList) {
	 					String selected = "";
 					if(userObj!=null && userObj.getUser_name()!=null && userObj.getUser_name().equals(userInfoTemp.getUser_name()))
 						selected = "selected";
	 				%>
 				 <option value="<%=userInfoTemp.getUser_name() %>" <%=selected %>><%=userInfoTemp.getName() %></option>
	 				<%
	 				}
	 				%>
 			</select>
            </div>
			<div class="form-group">
				<label for="deliveryTime">投递时间:</label>
				<input type="text" id="deliveryTime" name="deliveryTime" class="form-control"  placeholder="请选择投递时间" value="<%=deliveryTime %>" onclick="SelectDate(this,'yyyy-MM-dd')" />
			</div>
			<div class="form-group">
				<label for="handleTime">处理时间:</label>
				<input type="text" id="handleTime" name="handleTime" class="form-control"  placeholder="请选择处理时间" value="<%=handleTime %>" onclick="SelectDate(this,'yyyy-MM-dd')" />
			</div>
			<div class="form-group">
				<label for="clzt">处理状态:</label>
				<input type="text" id="clzt" name="clzt" value="<%=clzt %>" class="form-control" placeholder="请输入处理状态">
			</div>






            <input type=hidden name=currentPage value="<%=currentPage %>" />
            <button type="submit" class="btn btn-primary">查询</button>
        </form>
	</div>

		</div>
	</div> 
<div id="deliveryEditDialog" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title"><i class="fa fa-edit"></i>&nbsp;简历投递信息编辑</h4>
      </div>
      <div class="modal-body" style="height:450px; overflow: scroll;">
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
		</form> 
	    <style>#deliveryEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
      <div class="modal-footer"> 
      	<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
      	<button type="button" class="btn btn-primary" onclick="ajaxDeliveryModify();">提交</button>
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
    document.deliveryQueryForm.currentPage.value = currentPage;
    document.deliveryQueryForm.submit();
}

/*可以直接跳转到某页*/
function changepage(totalPage)
{
    var pageValue=document.deliveryQueryForm.pageValue.value;
    if(pageValue>totalPage) {
        alert('你输入的页码超出了总页数!');
        return ;
    }
    document.deliveryQueryForm.currentPage.value = pageValue;
    documentdeliveryQueryForm.submit();
}

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
				$('#deliveryEditDialog').modal('show');
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*删除简历投递信息*/
function deliveryDelete(deliveryId) {
	if(confirm("确认删除这个记录")) {
		$.ajax({
			type : "POST",
			url : basePath + "Delivery/deletes",
			data : {
				deliveryIds : deliveryId,
			},
			success : function (obj) {
				if (obj.success) {
					alert("删除成功");
					$("#deliveryQueryForm").submit();
					//location.href= basePath + "Delivery/frontlist";
				}
				else 
					alert(obj.message);
			},
		});
	}
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
})
</script>
</body>
</html>

