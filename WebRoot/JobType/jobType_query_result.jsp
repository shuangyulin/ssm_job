<%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/jobType.css" /> 

<div id="jobType_manage"></div>
<div id="jobType_manage_tool" style="padding:5px;">
	<div style="margin-bottom:5px;">
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit-new" plain="true" onclick="jobType_manage_tool.edit();">修改</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-delete-new" plain="true" onclick="jobType_manage_tool.remove();">删除</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-reload" plain="true"  onclick="jobType_manage_tool.reload();">刷新</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-redo" plain="true" onclick="jobType_manage_tool.redo();">取消选择</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-export" plain="true" onclick="jobType_manage_tool.exportExcel();">导出到excel</a>
	</div>
	<div style="padding:0 0 0 7px;color:#333;">
		<form id="jobTypeQueryForm" method="post">
		</form>	
	</div>
</div>

<div id="jobTypeEditDiv">
	<form id="jobTypeEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">职位类型id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="jobType_jobTypeId_edit" name="jobType.jobTypeId" style="width:200px" />
			</span>
		</div>
		<div>
			<span class="label">职位类别名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="jobType_jobTypeName_edit" name="jobType.jobTypeName" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">职位类别描述:</span>
			<span class="inputControl">
				<textarea id="jobType_jobTypeDesc_edit" name="jobType.jobTypeDesc" rows="8" cols="60"></textarea>

			</span>

		</div>
	</form>
</div>
<script type="text/javascript" src="JobType/js/jobType_manage.js"></script> 
