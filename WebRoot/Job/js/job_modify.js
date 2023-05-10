$(function () {
	//实例化编辑器
	//建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例
	UE.delEditor('job_jobDesc_edit');
	var job_jobDesc_edit = UE.getEditor('job_jobDesc_edit'); //职位描述编辑器
	job_jobDesc_edit.addListener("ready", function () {
		 // editor准备好之后才可以使用 
		 ajaxModifyQuery();
	}); 
  function ajaxModifyQuery() {	
	$.ajax({
		url : "Job/" + $("#job_jobId_edit").val() + "/update",
		type : "get",
		data : {
			//jobId : $("#job_jobId_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在获取中...",
			});
		},
		success : function (job, response, status) {
			$.messager.progress("close");
			if (job) { 
				$("#job_jobId_edit").val(job.jobId);
				$("#job_jobId_edit").validatebox({
					required : true,
					missingMessage : "请输入职位id",
					editable: false
				});
				$("#job_jobTypeObj_jobTypeId_edit").combobox({
					url:"JobType/listAll",
					valueField:"jobTypeId",
					textField:"jobTypeName",
					panelHeight: "auto",
					editable: false, //不允许手动输入 
					onLoadSuccess: function () { //数据加载完毕事件
						$("#job_jobTypeObj_jobTypeId_edit").combobox("select", job.jobTypeObjPri);
						//var data = $("#job_jobTypeObj_jobTypeId_edit").combobox("getData"); 
						//if (data.length > 0) {
							//$("#job_jobTypeObj_jobTypeId_edit").combobox("select", data[0].jobTypeId);
						//}
					}
				});
				$("#job_jobName_edit").val(job.jobName);
				$("#job_jobName_edit").validatebox({
					required : true,
					missingMessage : "请输入职位名称",
				});
				job_jobDesc_edit.setContent(job.jobDesc);
				$("#job_salary_edit").val(job.salary);
				$("#job_salary_edit").validatebox({
					required : true,
					missingMessage : "请输入工作薪酬",
				});
				$("#job_zprs_edit").val(job.zprs);
				$("#job_zprs_edit").validatebox({
					required : true,
					validType : "integer",
					missingMessage : "请输入招聘人数",
					invalidMessage : "招聘人数输入不对",
				});
				$("#job_xlyq_edit").val(job.xlyq);
				$("#job_xlyq_edit").validatebox({
					required : true,
					missingMessage : "请输入学历要求",
				});
				$("#job_yxqx_edit").val(job.yxqx);
				$("#job_yxqx_edit").validatebox({
					required : true,
					missingMessage : "请输入有效期限",
				});
				$("#job_gzqy_edit").val(job.gzqy);
				$("#job_gzqy_edit").validatebox({
					required : true,
					missingMessage : "请输入工作区域",
				});
				$("#job_gzdz_edit").val(job.gzdz);
				$("#job_gzdz_edit").validatebox({
					required : true,
					missingMessage : "请输入工作地址",
				});
				$("#job_viewNum_edit").val(job.viewNum);
				$("#job_viewNum_edit").validatebox({
					required : true,
					validType : "integer",
					missingMessage : "请输入浏览次数",
					invalidMessage : "浏览次数输入不对",
				});
				$("#job_companyObj_companyUserName_edit").combobox({
					url:"Company/listAll",
					valueField:"companyUserName",
					textField:"companyName",
					panelHeight: "auto",
					editable: false, //不允许手动输入 
					onLoadSuccess: function () { //数据加载完毕事件
						$("#job_companyObj_companyUserName_edit").combobox("select", job.companyObjPri);
						//var data = $("#job_companyObj_companyUserName_edit").combobox("getData"); 
						//if (data.length > 0) {
							//$("#job_companyObj_companyUserName_edit").combobox("select", data[0].companyUserName);
						//}
					}
				});
				$("#job_addTime_edit").datetimebox({
					value: job.addTime,
					required: true,
					showSeconds: true,
				});
			} else {
				$.messager.alert("获取失败！", "未知错误导致失败，请重试！", "warning");
				$(".messager-window").css("z-index",10000);
			}
		}
	});

  }

	$("#jobModifyButton").click(function(){ 
		if ($("#jobEditForm").form("validate")) {
			$("#jobEditForm").form({
			    url:"Job/" +  $("#job_jobId_edit").val() + "/update",
			    onSubmit: function(){
					if($("#jobEditForm").form("validate"))  {
	                	$.messager.progress({
							text : "正在提交数据中...",
						});
	                	return true;
	                } else {
	                    return false;
	                }
			    },
			    success:function(data){
			    	$.messager.progress("close");
                	var obj = jQuery.parseJSON(data);
                    if(obj.success){
                        $.messager.alert("消息","信息修改成功！");
                        $(".messager-window").css("z-index",10000);
                        //location.href="frontlist";
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    } 
			    }
			});
			//提交表单
			$("#jobEditForm").submit();
		} else {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		}
	});
});
