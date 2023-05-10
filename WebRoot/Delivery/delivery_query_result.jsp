<%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/delivery.css" /> 

<div id="delivery_manage"></div>
<div id="delivery_manage_tool" style="padding:5px;">
	<div style="margin-bottom:5px;">
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit-new" plain="true" onclick="delivery_manage_tool.edit();">修改</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-delete-new" plain="true" onclick="delivery_manage_tool.remove();">删除</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-reload" plain="true"  onclick="delivery_manage_tool.reload();">刷新</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-redo" plain="true" onclick="delivery_manage_tool.redo();">取消选择</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-export" plain="true" onclick="delivery_manage_tool.exportExcel();">导出到excel</a>
	</div>
	<div style="padding:0 0 0 7px;color:#333;">
		<form id="deliveryQueryForm" method="post">
			应聘职位：<input class="textbox" type="text" id="jobObj_jobId_query" name="jobObj.jobId" style="width: auto"/>
			应聘人：<input class="textbox" type="text" id="userObj_user_name_query" name="userObj.user_name" style="width: auto"/>
			投递时间：<input type="text" id="deliveryTime" name="deliveryTime" class="easyui-datebox" editable="false" style="width:100px">
			处理时间：<input type="text" id="handleTime" name="handleTime" class="easyui-datebox" editable="false" style="width:100px">
			处理状态：<input type="text" class="textbox" id="clzt" name="clzt" style="width:110px" />
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="delivery_manage_tool.search();">查询</a>
		</form>	
	</div>
</div>

<div id="deliveryEditDiv">
	<form id="deliveryEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">投递id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="delivery_deliveryId_edit" name="delivery.deliveryId" style="width:200px" />
			</span>
		</div>
		<div>
			<span class="label">应聘职位:</span>
			<span class="inputControl">
				<input class="textbox"  id="delivery_jobObj_jobId_edit" name="delivery.jobObj.jobId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">应聘人:</span>
			<span class="inputControl">
				<input class="textbox"  id="delivery_userObj_user_name_edit" name="delivery.userObj.user_name" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">投递时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="delivery_deliveryTime_edit" name="delivery.deliveryTime" />

			</span>

		</div>
		<div>
			<span class="label">处理时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="delivery_handleTime_edit" name="delivery.handleTime" />

			</span>

		</div>
		<div>
			<span class="label">处理状态:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="delivery_clzt_edit" name="delivery.clzt" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">通知信息:</span>
			<span class="inputControl">
				<textarea id="delivery_tzxx_edit" name="delivery.tzxx" rows="8" cols="60"></textarea>

			</span>

		</div>
		<div>
			<span class="label">工作评价:</span>
			<span class="inputControl">
				<textarea id="delivery_gzpj_edit" name="delivery.gzpj" rows="8" cols="60"></textarea>

			</span>

		</div>
	</form>
</div>
<script type="text/javascript" src="Delivery/js/delivery_manage.js"></script> 
