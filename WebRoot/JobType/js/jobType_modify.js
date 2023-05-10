$(function () {
	$.ajax({
		url : "JobType/" + $("#jobType_jobTypeId_edit").val() + "/update",
		type : "get",
		data : {
			//jobTypeId : $("#jobType_jobTypeId_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在获取中...",
			});
		},
		success : function (jobType, response, status) {
			$.messager.progress("close");
			if (jobType) { 
				$("#jobType_jobTypeId_edit").val(jobType.jobTypeId);
				$("#jobType_jobTypeId_edit").validatebox({
					required : true,
					missingMessage : "请输入职位类型id",
					editable: false
				});
				$("#jobType_jobTypeName_edit").val(jobType.jobTypeName);
				$("#jobType_jobTypeName_edit").validatebox({
					required : true,
					missingMessage : "请输入职位类别名称",
				});
				$("#jobType_jobTypeDesc_edit").val(jobType.jobTypeDesc);
				$("#jobType_jobTypeDesc_edit").validatebox({
					required : true,
					missingMessage : "请输入职位类别描述",
				});
			} else {
				$.messager.alert("获取失败！", "未知错误导致失败，请重试！", "warning");
				$(".messager-window").css("z-index",10000);
			}
		}
	});

	$("#jobTypeModifyButton").click(function(){ 
		if ($("#jobTypeEditForm").form("validate")) {
			$("#jobTypeEditForm").form({
			    url:"JobType/" +  $("#jobType_jobTypeId_edit").val() + "/update",
			    onSubmit: function(){
					if($("#jobTypeEditForm").form("validate"))  {
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
			$("#jobTypeEditForm").submit();
		} else {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		}
	});
});
