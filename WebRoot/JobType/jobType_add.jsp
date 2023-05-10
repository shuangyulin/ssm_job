<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/jobType.css" />
<div id="jobTypeAddDiv">
	<form id="jobTypeAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">职位类别名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="jobType_jobTypeName" name="jobType.jobTypeName" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">职位类别描述:</span>
			<span class="inputControl">
				<textarea id="jobType_jobTypeDesc" name="jobType.jobTypeDesc" rows="6" cols="80"></textarea>

			</span>

		</div>
		<div class="operation">
			<a id="jobTypeAddButton" class="easyui-linkbutton">添加</a>
			<a id="jobTypeClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/JobType/js/jobType_add.js"></script> 
