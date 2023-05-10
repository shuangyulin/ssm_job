<%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/company.css" /> 

<div id="company_manage"></div>
<div id="company_manage_tool" style="padding:5px;">
	<div style="margin-bottom:5px;">
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit-new" plain="true" onclick="company_manage_tool.edit();">修改</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-delete-new" plain="true" onclick="company_manage_tool.remove();">删除</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-reload" plain="true"  onclick="company_manage_tool.reload();">刷新</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-redo" plain="true" onclick="company_manage_tool.redo();">取消选择</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-export" plain="true" onclick="company_manage_tool.exportExcel();">导出到excel</a>
	</div>
	<div style="padding:0 0 0 7px;color:#333;">
		<form id="companyQueryForm" method="post">
			信用级别：<input type="text" class="textbox" id="qyjb" name="qyjb" style="width:110px" />
			企业名称：<input type="text" class="textbox" id="companyName" name="companyName" style="width:110px" />
			工商注册号：<input type="text" class="textbox" id="gszch" name="gszch" style="width:110px" />
			公司性质：<input type="text" class="textbox" id="gsxz" name="gsxz" style="width:110px" />
			公司规模：<input type="text" class="textbox" id="gsgm" name="gsgm" style="width:110px" />
			公司行业：<input type="text" class="textbox" id="gghy" name="gghy" style="width:110px" />
			联系人：<input type="text" class="textbox" id="lxr" name="lxr" style="width:110px" />
			联系电话：<input type="text" class="textbox" id="lxdh" name="lxdh" style="width:110px" />
			审核状态：<input type="text" class="textbox" id="shzt" name="shzt" style="width:110px" />
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="company_manage_tool.search();">查询</a>
		</form>	
	</div>
</div>

<div id="companyEditDiv">
	<form id="companyEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">企业用户名:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="company_companyUserName_edit" name="company.companyUserName" style="width:200px" />
			</span>
		</div>
		<div>
			<span class="label">登录密码:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="company_password_edit" name="company.password" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">信用级别:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="company_qyjb_edit" name="company.qyjb" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">企业名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="company_companyName_edit" name="company.companyName" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">工商注册号:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="company_gszch_edit" name="company.gszch" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">营业执照:</span>
			<span class="inputControl">
				<img id="company_yyzzImg" width="200px" border="0px"/><br/>
    			<input type="hidden" id="company_yyzz" name="company.yyzz"/>
				<input id="yyzzFile" name="yyzzFile" type="file" size="50" />
			</span>
		</div>
		<div>
			<span class="label">公司性质:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="company_gsxz_edit" name="company.gsxz" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">公司规模:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="company_gsgm_edit" name="company.gsgm" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">公司行业:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="company_gghy_edit" name="company.gghy" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">联系人:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="company_lxr_edit" name="company.lxr" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">联系电话:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="company_lxdh_edit" name="company.lxdh" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">公司介绍:</span>
			<span class="inputControl">
				<script name="company.companyDesc" id="company_companyDesc_edit" type="text/plain"   style="width:100%;height:500px;"></script>

			</span>

		</div>
		<div>
			<span class="label">公司地址:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="company_address_edit" name="company.address" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">审核状态:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="company_shzt_edit" name="company.shzt" style="width:200px" />

			</span>

		</div>
	</form>
</div>
<script>
//实例化编辑器
//建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例
var company_companyDesc_editor = UE.getEditor('company_companyDesc_edit'); //公司介绍编辑器
</script>
<script type="text/javascript" src="Company/js/company_manage.js"></script> 
