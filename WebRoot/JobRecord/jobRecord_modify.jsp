<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/jobRecord.css" />
<div id="jobRecord_editDiv">
	<form id="jobRecordEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">记录id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="jobRecord_recordId_edit" name="jobRecord.recordId" value="<%=request.getParameter("recordId") %>" style="width:200px" />
			</span>
		</div>

		<div>
			<span class="label">标题:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="jobRecord_title_edit" name="jobRecord.title" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">内容:</span>
			<span class="inputControl">
				<script id="jobRecord_content_edit" name="jobRecord.content" type="text/plain"   style="width:750px;height:500px;"></script>

			</span>

		</div>
		<div>
			<span class="label">记录人:</span>
			<span class="inputControl">
				<input class="textbox"  id="jobRecord_userObj_user_name_edit" name="jobRecord.userObj.user_name" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">记录时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="jobRecord_recordDate_edit" name="jobRecord.recordDate" />

			</span>

		</div>
		<div class="operation">
			<a id="jobRecordModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/JobRecord/js/jobRecord_modify.js"></script> 
