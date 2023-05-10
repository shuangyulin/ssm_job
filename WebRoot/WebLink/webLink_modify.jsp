<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/webLink.css" />
<div id="webLink_editDiv">
	<form id="webLinkEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">记录id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="webLink_linkId_edit" name="webLink.linkId" value="<%=request.getParameter("linkId") %>" style="width:200px" />
			</span>
		</div>

		<div>
			<span class="label">网站名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="webLink_webName_edit" name="webLink.webName" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">网站Logo:</span>
			<span class="inputControl">
				<img id="webLink_webLogoImg" width="200px" border="0px"/><br/>
    			<input type="hidden" id="webLink_webLogo" name="webLink.webLogo"/>
				<input id="webLogoFile" name="webLogoFile" type="file" size="50" />
			</span>
		</div>
		<div>
			<span class="label">网站地址:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="webLink_webAddress_edit" name="webLink.webAddress" style="width:200px" />

			</span>

		</div>
		<div class="operation">
			<a id="webLinkModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/WebLink/js/webLink_modify.js"></script> 
