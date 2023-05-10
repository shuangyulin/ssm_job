<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
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
<title>兼职记录添加</title>
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
			    	<li role="presentation" ><a href="<%=basePath %>JobRecord/frontlist">兼职记录列表</a></li>
			    	<li role="presentation" class="active"><a href="#jobRecordAdd" aria-controls="jobRecordAdd" role="tab" data-toggle="tab">添加兼职记录</a></li>
				</ul>
				<!-- Tab panes -->
				<div class="tab-content">
				    <div role="tabpanel" class="tab-pane" id="jobRecordList">
				    </div>
				    <div role="tabpanel" class="tab-pane active" id="jobRecordAdd"> 
				      	<form class="form-horizontal" name="jobRecordAddForm" id="jobRecordAddForm" enctype="multipart/form-data" method="post"  class="mar_t15">
						  <div class="form-group">
						  	 <label for="jobRecord_title" class="col-md-2 text-right">标题:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="jobRecord_title" name="jobRecord.title" class="form-control" placeholder="请输入标题">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="jobRecord_content" class="col-md-2 text-right">内容:</label>
						  	 <div class="col-md-8">
							    <textarea name="jobRecord.content" id="jobRecord_content" style="width:100%;height:500px;"></textarea>
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="jobRecord_userObj_user_name" class="col-md-2 text-right">记录人:</label>
						  	 <div class="col-md-8">
							    <select id="jobRecord_userObj_user_name" name="jobRecord.userObj.user_name" class="form-control">
							    </select>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="jobRecord_recordDateDiv" class="col-md-2 text-right">记录时间:</label>
						  	 <div class="col-md-8">
				                <div id="jobRecord_recordDateDiv" class="input-group date jobRecord_recordDate col-md-12" data-link-field="jobRecord_recordDate">
				                    <input class="form-control" id="jobRecord_recordDate" name="jobRecord.recordDate" size="16" type="text" value="" placeholder="请选择记录时间" readonly>
				                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
				                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
				                </div>
						  	 </div>
						  </div>
				          <div class="form-group">
				             <span class="col-md-2""></span>
				             <span onclick="ajaxJobRecordAdd();" class="btn btn-primary bottom5 top5">添加</span>
				          </div>
						</form> 
				        <style>#jobRecordAddForm .form-group {margin:10px;}  </style>
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
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/ueditor.all.min.js"> </script>
<!--建议手动加在语言，避免在ie下有时因为加载语言失败导致编辑器加载失败-->
<!--这里加载的语言文件会覆盖你在配置项目里添加的语言类型，比如你在配置项目里配置的是英文，这里加载的中文，那最后就是中文-->
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/lang/zh-cn/zh-cn.js"></script>
<script>
//实例化编辑器
var jobRecord_content_editor = UE.getEditor('jobRecord_content'); //内容编辑器
var basePath = "<%=basePath%>";
	//提交添加兼职记录信息
	function ajaxJobRecordAdd() { 
		//提交之前先验证表单
		$("#jobRecordAddForm").data('bootstrapValidator').validate();
		if(!$("#jobRecordAddForm").data('bootstrapValidator').isValid()){
			return;
		}
		if(jobRecord_content_editor.getContent() == "") {
			alert('内容不能为空');
			return;
		}
		jQuery.ajax({
			type : "post",
			url : basePath + "JobRecord/add",
			dataType : "json" , 
			data: new FormData($("#jobRecordAddForm")[0]),
			success : function(obj) {
				if(obj.success){ 
					alert("保存成功！");
					$("#jobRecordAddForm").find("input").val("");
					$("#jobRecordAddForm").find("textarea").val("");
					jobRecord_content_editor.setContent("");
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
	//验证兼职记录添加表单字段
	$('#jobRecordAddForm').bootstrapValidator({
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
			"jobRecord.title": {
				validators: {
					notEmpty: {
						message: "标题不能为空",
					}
				}
			},
			"jobRecord.recordDate": {
				validators: {
					notEmpty: {
						message: "记录时间不能为空",
					}
				}
			},
		}
	}); 
	//初始化记录人下拉框值 
	$.ajax({
		url: basePath + "UserInfo/listAll",
		type: "get",
		success: function(userInfos,response,status) { 
			$("#jobRecord_userObj_user_name").empty();
			var html="";
    		$(userInfos).each(function(i,userInfo){
    			html += "<option value='" + userInfo.user_name + "'>" + userInfo.name + "</option>";
    		});
    		$("#jobRecord_userObj_user_name").html(html);
    	}
	});
	//记录时间组件
	$('#jobRecord_recordDateDiv').datetimepicker({
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
		$('#jobRecordAddForm').data('bootstrapValidator').updateStatus('jobRecord.recordDate', 'NOT_VALIDATED',null).validateField('jobRecord.recordDate');
	});
})
</script>
</body>
</html>
