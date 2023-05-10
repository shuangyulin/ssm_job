<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/company.css" />
<div id="company_editDiv">
	<form id="companyEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">企业用户名:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="company_companyUserName_edit" name="company.companyUserName" value="<%=request.getParameter("companyUserName") %>" style="width:200px" />
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
				<script id="company_companyDesc_edit" name="company.companyDesc" type="text/plain"   style="width:750px;height:500px;"></script>

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
		<div class="operation">
			<a id="companyModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/Company/js/company_modify.js"></script> 
