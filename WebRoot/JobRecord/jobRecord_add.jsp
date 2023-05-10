<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/jobRecord.css" />
<div id="jobRecordAddDiv">
	<form id="jobRecordAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">标题:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="jobRecord_title" name="jobRecord.title" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">内容:</span>
			<span class="inputControl">
				<script name="jobRecord.content" id="jobRecord_content" type="text/plain"   style="width:750px;height:500px;"></script>
			</span>

		</div>
		<div>
			<span class="label">记录人:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="jobRecord_userObj_user_name" name="jobRecord.userObj.user_name" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">记录时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="jobRecord_recordDate" name="jobRecord.recordDate" />

			</span>

		</div>
		<div class="operation">
			<a id="jobRecordAddButton" class="easyui-linkbutton">添加</a>
			<a id="jobRecordClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/JobRecord/js/jobRecord_add.js"></script> 
