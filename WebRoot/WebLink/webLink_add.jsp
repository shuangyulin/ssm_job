<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/webLink.css" />
<div id="webLinkAddDiv">
	<form id="webLinkAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">网站名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="webLink_webName" name="webLink.webName" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">网站Logo:</span>
			<span class="inputControl">
				<input id="webLogoFile" name="webLogoFile" type="file" size="50" />
			</span>
		</div>
		<div>
			<span class="label">网站地址:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="webLink_webAddress" name="webLink.webAddress" style="width:200px" />

			</span>

		</div>
		<div class="operation">
			<a id="webLinkAddButton" class="easyui-linkbutton">添加</a>
			<a id="webLinkClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/WebLink/js/webLink_add.js"></script> 
