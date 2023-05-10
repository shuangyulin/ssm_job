<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/job.css" />
<div id="job_editDiv">
	<form id="jobEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">职位id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="job_jobId_edit" name="job.jobId" value="<%=request.getParameter("jobId") %>" style="width:200px" />
			</span>
		</div>

		<div>
			<span class="label">职位类别:</span>
			<span class="inputControl">
				<input class="textbox"  id="job_jobTypeObj_jobTypeId_edit" name="job.jobTypeObj.jobTypeId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">职位名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="job_jobName_edit" name="job.jobName" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">职位描述:</span>
			<span class="inputControl">
				<script id="job_jobDesc_edit" name="job.jobDesc" type="text/plain"   style="width:750px;height:500px;"></script>

			</span>

		</div>
		<div>
			<span class="label">工作薪酬:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="job_salary_edit" name="job.salary" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">招聘人数:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="job_zprs_edit" name="job.zprs" style="width:80px" />

			</span>

		</div>
		<div>
			<span class="label">学历要求:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="job_xlyq_edit" name="job.xlyq" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">有效期限:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="job_yxqx_edit" name="job.yxqx" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">工作区域:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="job_gzqy_edit" name="job.gzqy" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">工作地址:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="job_gzdz_edit" name="job.gzdz" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">浏览次数:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="job_viewNum_edit" name="job.viewNum" style="width:80px" />

			</span>

		</div>
		<div>
			<span class="label">发布企业:</span>
			<span class="inputControl">
				<input class="textbox"  id="job_companyObj_companyUserName_edit" name="job.companyObj.companyUserName" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">发布时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="job_addTime_edit" name="job.addTime" />

			</span>

		</div>
		<div class="operation">
			<a id="jobModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/Job/js/job_modify.js"></script> 
