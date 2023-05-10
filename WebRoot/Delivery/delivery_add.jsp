<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/delivery.css" />
<div id="deliveryAddDiv">
	<form id="deliveryAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">应聘职位:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="delivery_jobObj_jobId" name="delivery.jobObj.jobId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">应聘人:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="delivery_userObj_user_name" name="delivery.userObj.user_name" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">投递时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="delivery_deliveryTime" name="delivery.deliveryTime" />

			</span>

		</div>
		<div>
			<span class="label">处理时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="delivery_handleTime" name="delivery.handleTime" />

			</span>

		</div>
		<div>
			<span class="label">处理状态:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="delivery_clzt" name="delivery.clzt" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">通知信息:</span>
			<span class="inputControl">
				<textarea id="delivery_tzxx" name="delivery.tzxx" rows="6" cols="80"></textarea>

			</span>

		</div>
		<div>
			<span class="label">工作评价:</span>
			<span class="inputControl">
				<textarea id="delivery_gzpj" name="delivery.gzpj" rows="6" cols="80"></textarea>

			</span>

		</div>
		<div class="operation">
			<a id="deliveryAddButton" class="easyui-linkbutton">添加</a>
			<a id="deliveryClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/Delivery/js/delivery_add.js"></script> 
