<%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/job.css" /> 

<div id="job_manage"></div>
<div id="job_manage_tool" style="padding:5px;">
	<div style="margin-bottom:5px;">
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit-new" plain="true" onclick="job_manage_tool.edit();">修改</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-delete-new" plain="true" onclick="job_manage_tool.remove();">删除</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-reload" plain="true"  onclick="job_manage_tool.reload();">刷新</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-redo" plain="true" onclick="job_manage_tool.redo();">取消选择</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-export" plain="true" onclick="job_manage_tool.exportExcel();">导出到excel</a>
	</div>
	<div style="padding:0 0 0 7px;color:#333;">
		<form id="jobQueryForm" method="post">
			职位类别：<input class="textbox" type="text" id="jobTypeObj_jobTypeId_query" name="jobTypeObj.jobTypeId" style="width: auto"/>
			职位名称：<input type="text" class="textbox" id="jobName" name="jobName" style="width:110px" />
			学历要求：<input type="text" class="textbox" id="xlyq" name="xlyq" style="width:110px" />
			工作区域：<input type="text" class="textbox" id="gzqy" name="gzqy" style="width:110px" />
			发布企业：<input class="textbox" type="text" id="companyObj_companyUserName_query" name="companyObj.companyUserName" style="width: auto"/>
			发布时间：<input type="text" id="addTime" name="addTime" class="easyui-datebox" editable="false" style="width:100px">
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="job_manage_tool.search();">查询</a>
		</form>	
	</div>
</div>

<div id="jobEditDiv">
	<form id="jobEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">职位id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="job_jobId_edit" name="job.jobId" style="width:200px" />
			</span>
		</div>
		<div>
			<span class="label">职位类别:</span>
			<span class="inputControl">
				<input class="textbox"  id="job_jobTypeObj_jobTypeId_edit" name="job.jobTypeObj.jobTypeId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">职位名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="job_jobName_edit" name="job.jobName" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">职位描述:</span>
			<span class="inputControl">
				<script name="job.jobDesc" id="job_jobDesc_edit" type="text/plain"   style="width:100%;height:500px;"></script>

			</span>

		</div>
		<div>
			<span class="label">工作薪酬:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="job_salary_edit" name="job.salary" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">招聘人数:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="job_zprs_edit" name="job.zprs" style="width:80px" />

			</span>

		</div>
		<div>
			<span class="label">学历要求:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="job_xlyq_edit" name="job.xlyq" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">有效期限:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="job_yxqx_edit" name="job.yxqx" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">工作区域:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="job_gzqy_edit" name="job.gzqy" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">工作地址:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="job_gzdz_edit" name="job.gzdz" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">浏览次数:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="job_viewNum_edit" name="job.viewNum" style="width:80px" />

			</span>

		</div>
		<div>
			<span class="label">发布企业:</span>
			<span class="inputControl">
				<input class="textbox"  id="job_companyObj_companyUserName_edit" name="job.companyObj.companyUserName" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">发布时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="job_addTime_edit" name="job.addTime" />

			</span>

		</div>
	</form>
</div>
<script>
//实例化编辑器
//建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例
var job_jobDesc_editor = UE.getEditor('job_jobDesc_edit'); //职位描述编辑器
</script>
<script type="text/javascript" src="Job/js/job_manage.js"></script> 
