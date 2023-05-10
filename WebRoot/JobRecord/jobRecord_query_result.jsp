<%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/jobRecord.css" /> 

<div id="jobRecord_manage"></div>
<div id="jobRecord_manage_tool" style="padding:5px;">
	<div style="margin-bottom:5px;">
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit-new" plain="true" onclick="jobRecord_manage_tool.edit();">修改</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-delete-new" plain="true" onclick="jobRecord_manage_tool.remove();">删除</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-reload" plain="true"  onclick="jobRecord_manage_tool.reload();">刷新</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-redo" plain="true" onclick="jobRecord_manage_tool.redo();">取消选择</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-export" plain="true" onclick="jobRecord_manage_tool.exportExcel();">导出到excel</a>
	</div>
	<div style="padding:0 0 0 7px;color:#333;">
		<form id="jobRecordQueryForm" method="post">
			标题：<input type="text" class="textbox" id="title" name="title" style="width:110px" />
			记录人：<input class="textbox" type="text" id="userObj_user_name_query" name="userObj.user_name" style="width: auto"/>
			记录时间：<input type="text" id="recordDate" name="recordDate" class="easyui-datebox" editable="false" style="width:100px">
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="jobRecord_manage_tool.search();">查询</a>
		</form>	
	</div>
</div>

<div id="jobRecordEditDiv">
	<form id="jobRecordEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">记录id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="jobRecord_recordId_edit" name="jobRecord.recordId" style="width:200px" />
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
				<script name="jobRecord.content" id="jobRecord_content_edit" type="text/plain"   style="width:100%;height:500px;"></script>

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
	</form>
</div>
<script>
//实例化编辑器
//建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例
var jobRecord_content_editor = UE.getEditor('jobRecord_content_edit'); //内容编辑器
</script>
<script type="text/javascript" src="JobRecord/js/jobRecord_manage.js"></script> 
