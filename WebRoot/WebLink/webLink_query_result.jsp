<%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/webLink.css" /> 

<div id="webLink_manage"></div>
<div id="webLink_manage_tool" style="padding:5px;">
	<div style="margin-bottom:5px;">
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit-new" plain="true" onclick="webLink_manage_tool.edit();">修改</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-delete-new" plain="true" onclick="webLink_manage_tool.remove();">删除</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-reload" plain="true"  onclick="webLink_manage_tool.reload();">刷新</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-redo" plain="true" onclick="webLink_manage_tool.redo();">取消选择</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-export" plain="true" onclick="webLink_manage_tool.exportExcel();">导出到excel</a>
	</div>
	<div style="padding:0 0 0 7px;color:#333;">
		<form id="webLinkQueryForm" method="post">
		</form>	
	</div>
</div>

<div id="webLinkEditDiv">
	<form id="webLinkEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">记录id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="webLink_linkId_edit" name="webLink.linkId" style="width:200px" />
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
	</form>
</div>
<script type="text/javascript" src="WebLink/js/webLink_manage.js"></script> 
