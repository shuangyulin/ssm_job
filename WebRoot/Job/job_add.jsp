<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/job.css" />
<div id="jobAddDiv">
	<form id="jobAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">职位类别:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="job_jobTypeObj_jobTypeId" name="job.jobTypeObj.jobTypeId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">职位名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="job_jobName" name="job.jobName" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">职位描述:</span>
			<span class="inputControl">
				<script name="job.jobDesc" id="job_jobDesc" type="text/plain"   style="width:750px;height:500px;"></script>
			</span>

		</div>
		<div>
			<span class="label">工作薪酬:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="job_salary" name="job.salary" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">招聘人数:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="job_zprs" name="job.zprs" style="width:80px" />

			</span>

		</div>
		<div>
			<span class="label">学历要求:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="job_xlyq" name="job.xlyq" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">有效期限:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="job_yxqx" name="job.yxqx" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">工作区域:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="job_gzqy" name="job.gzqy" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">工作地址:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="job_gzdz" name="job.gzdz" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">浏览次数:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="job_viewNum" name="job.viewNum" style="width:80px" />

			</span>

		</div>
		<div>
			<span class="label">发布企业:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="job_companyObj_companyUserName" name="job.companyObj.companyUserName" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">发布时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="job_addTime" name="job.addTime" />

			</span>

		</div>
		<div class="operation">
			<a id="jobAddButton" class="easyui-linkbutton">添加</a>
			<a id="jobClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/Job/js/job_add.js"></script> 
