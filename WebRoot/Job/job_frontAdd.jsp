<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Company" %>
<%@ page import="com.chengxusheji.po.JobType" %>
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
<title>职位添加</title>
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
			    	<li role="presentation" ><a href="<%=basePath %>Job/frontlist">职位列表</a></li>
			    	<li role="presentation" class="active"><a href="#jobAdd" aria-controls="jobAdd" role="tab" data-toggle="tab">添加职位</a></li>
				</ul>
				<!-- Tab panes -->
				<div class="tab-content">
				    <div role="tabpanel" class="tab-pane" id="jobList">
				    </div>
				    <div role="tabpanel" class="tab-pane active" id="jobAdd"> 
				      	<form class="form-horizontal" name="jobAddForm" id="jobAddForm" enctype="multipart/form-data" method="post"  class="mar_t15">
						  <div class="form-group">
						  	 <label for="job_jobTypeObj_jobTypeId" class="col-md-2 text-right">职位类别:</label>
						  	 <div class="col-md-8">
							    <select id="job_jobTypeObj_jobTypeId" name="job.jobTypeObj.jobTypeId" class="form-control">
							    </select>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="job_jobName" class="col-md-2 text-right">职位名称:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="job_jobName" name="job.jobName" class="form-control" placeholder="请输入职位名称">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="job_jobDesc" class="col-md-2 text-right">职位描述:</label>
						  	 <div class="col-md-8">
							    <textarea name="job.jobDesc" id="job_jobDesc" style="width:100%;height:500px;"></textarea>
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="job_salary" class="col-md-2 text-right">工作薪酬:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="job_salary" name="job.salary" class="form-control" placeholder="请输入工作薪酬">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="job_zprs" class="col-md-2 text-right">招聘人数:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="job_zprs" name="job.zprs" class="form-control" placeholder="请输入招聘人数">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="job_xlyq" class="col-md-2 text-right">学历要求:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="job_xlyq" name="job.xlyq" class="form-control" placeholder="请输入学历要求">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="job_yxqx" class="col-md-2 text-right">有效期限:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="job_yxqx" name="job.yxqx" class="form-control" placeholder="请输入有效期限">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="job_gzqy" class="col-md-2 text-right">工作区域:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="job_gzqy" name="job.gzqy" class="form-control" placeholder="请输入工作区域">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="job_gzdz" class="col-md-2 text-right">工作地址:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="job_gzdz" name="job.gzdz" class="form-control" placeholder="请输入工作地址">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="job_viewNum" class="col-md-2 text-right">浏览次数:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="job_viewNum" name="job.viewNum" class="form-control" placeholder="请输入浏览次数">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="job_companyObj_companyUserName" class="col-md-2 text-right">发布企业:</label>
						  	 <div class="col-md-8">
							    <select id="job_companyObj_companyUserName" name="job.companyObj.companyUserName" class="form-control">
							    </select>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="job_addTimeDiv" class="col-md-2 text-right">发布时间:</label>
						  	 <div class="col-md-8">
				                <div id="job_addTimeDiv" class="input-group date job_addTime col-md-12" data-link-field="job_addTime">
				                    <input class="form-control" id="job_addTime" name="job.addTime" size="16" type="text" value="" placeholder="请选择发布时间" readonly>
				                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
				                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
				                </div>
						  	 </div>
						  </div>
				          <div class="form-group">
				             <span class="col-md-2""></span>
				             <span onclick="ajaxJobAdd();" class="btn btn-primary bottom5 top5">添加</span>
				          </div>
						</form> 
				        <style>#jobAddForm .form-group {margin:10px;}  </style>
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
var job_jobDesc_editor = UE.getEditor('job_jobDesc'); //职位描述编辑器
var basePath = "<%=basePath%>";
	//提交添加职位信息
	function ajaxJobAdd() { 
		//提交之前先验证表单
		$("#jobAddForm").data('bootstrapValidator').validate();
		if(!$("#jobAddForm").data('bootstrapValidator').isValid()){
			return;
		}
		if(job_jobDesc_editor.getContent() == "") {
			alert('职位描述不能为空');
			return;
		}
		jQuery.ajax({
			type : "post",
			url : basePath + "Job/add",
			dataType : "json" , 
			data: new FormData($("#jobAddForm")[0]),
			success : function(obj) {
				if(obj.success){ 
					alert("保存成功！");
					$("#jobAddForm").find("input").val("");
					$("#jobAddForm").find("textarea").val("");
					job_jobDesc_editor.setContent("");
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
	//验证职位添加表单字段
	$('#jobAddForm').bootstrapValidator({
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
			"job.jobName": {
				validators: {
					notEmpty: {
						message: "职位名称不能为空",
					}
				}
			},
			"job.salary": {
				validators: {
					notEmpty: {
						message: "工作薪酬不能为空",
					}
				}
			},
			"job.zprs": {
				validators: {
					notEmpty: {
						message: "招聘人数不能为空",
					},
					integer: {
						message: "招聘人数不正确"
					}
				}
			},
			"job.xlyq": {
				validators: {
					notEmpty: {
						message: "学历要求不能为空",
					}
				}
			},
			"job.yxqx": {
				validators: {
					notEmpty: {
						message: "有效期限不能为空",
					}
				}
			},
			"job.gzqy": {
				validators: {
					notEmpty: {
						message: "工作区域不能为空",
					}
				}
			},
			"job.gzdz": {
				validators: {
					notEmpty: {
						message: "工作地址不能为空",
					}
				}
			},
			"job.viewNum": {
				validators: {
					notEmpty: {
						message: "浏览次数不能为空",
					},
					integer: {
						message: "浏览次数不正确"
					}
				}
			},
			"job.addTime": {
				validators: {
					notEmpty: {
						message: "发布时间不能为空",
					}
				}
			},
		}
	}); 
	//初始化职位类别下拉框值 
	$.ajax({
		url: basePath + "JobType/listAll",
		type: "get",
		success: function(jobTypes,response,status) { 
			$("#job_jobTypeObj_jobTypeId").empty();
			var html="";
    		$(jobTypes).each(function(i,jobType){
    			html += "<option value='" + jobType.jobTypeId + "'>" + jobType.jobTypeName + "</option>";
    		});
    		$("#job_jobTypeObj_jobTypeId").html(html);
    	}
	});
	//初始化发布企业下拉框值 
	$.ajax({
		url: basePath + "Company/listAll",
		type: "get",
		success: function(companys,response,status) { 
			$("#job_companyObj_companyUserName").empty();
			var html="";
    		$(companys).each(function(i,company){
    			html += "<option value='" + company.companyUserName + "'>" + company.companyName + "</option>";
    		});
    		$("#job_companyObj_companyUserName").html(html);
    	}
	});
	//发布时间组件
	$('#job_addTimeDiv').datetimepicker({
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
		$('#jobAddForm').data('bootstrapValidator').updateStatus('job.addTime', 'NOT_VALIDATED',null).validateField('job.addTime');
	});
})
</script>
</body>
</html>
