<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/company.css" />
<div id="companyAddDiv">
	<form id="companyAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">企业用户名:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="company_companyUserName" name="company.companyUserName" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">登录密码:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="company_password" name="company.password" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">信用级别:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="company_qyjb" name="company.qyjb" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">企业名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="company_companyName" name="company.companyName" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">工商注册号:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="company_gszch" name="company.gszch" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">营业执照:</span>
			<span class="inputControl">
				<input id="yyzzFile" name="yyzzFile" type="file" size="50" />
			</span>
		</div>
		<div>
			<span class="label">公司性质:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="company_gsxz" name="company.gsxz" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">公司规模:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="company_gsgm" name="company.gsgm" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">公司行业:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="company_gghy" name="company.gghy" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">联系人:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="company_lxr" name="company.lxr" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">联系电话:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="company_lxdh" name="company.lxdh" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">公司介绍:</span>
			<span class="inputControl">
				<script name="company.companyDesc" id="company_companyDesc" type="text/plain"   style="width:750px;height:500px;"></script>
			</span>

		</div>
		<div>
			<span class="label">公司地址:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="company_address" name="company.address" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">审核状态:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="company_shzt" name="company.shzt" style="width:200px" />

			</span>

		</div>
		<div class="operation">
			<a id="companyAddButton" class="easyui-linkbutton">添加</a>
			<a id="companyClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/Company/js/company_add.js"></script> 
