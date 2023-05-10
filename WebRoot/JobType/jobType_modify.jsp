<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/jobType.css" />
<div id="jobType_editDiv">
	<form id="jobTypeEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">职位类型id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="jobType_jobTypeId_edit" name="jobType.jobTypeId" value="<%=request.getParameter("jobTypeId") %>" style="width:200px" />
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
		<div class="operation">
			<a id="jobTypeModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/JobType/js/jobType_modify.js"></script> 
