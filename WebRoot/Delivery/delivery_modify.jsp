<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/delivery.css" />
<div id="delivery_editDiv">
	<form id="deliveryEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">投递id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="delivery_deliveryId_edit" name="delivery.deliveryId" value="<%=request.getParameter("deliveryId") %>" style="width:200px" />
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
		<div class="operation">
			<a id="deliveryModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/Delivery/js/delivery_modify.js"></script> 
