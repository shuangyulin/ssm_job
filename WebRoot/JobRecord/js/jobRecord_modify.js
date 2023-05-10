$(function () {
	//实例化编辑器
	//建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例
	UE.delEditor('jobRecord_content_edit');
	var jobRecord_content_edit = UE.getEditor('jobRecord_content_edit'); //内容编辑器
	jobRecord_content_edit.addListener("ready", function () {
		 // editor准备好之后才可以使用 
		 ajaxModifyQuery();
	}); 
  function ajaxModifyQuery() {	
	$.ajax({
		url : "JobRecord/" + $("#jobRecord_recordId_edit").val() + "/update",
		type : "get",
		data : {
			//recordId : $("#jobRecord_recordId_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在获取中...",
			});
		},
		success : function (jobRecord, response, status) {
			$.messager.progress("close");
			if (jobRecord) { 
				$("#jobRecord_recordId_edit").val(jobRecord.recordId);
				$("#jobRecord_recordId_edit").validatebox({
					required : true,
					missingMessage : "请输入记录id",
					editable: false
				});
				$("#jobRecord_title_edit").val(jobRecord.title);
				$("#jobRecord_title_edit").validatebox({
					required : true,
					missingMessage : "请输入标题",
				});
				jobRecord_content_edit.setContent(jobRecord.content);
				$("#jobRecord_userObj_user_name_edit").combobox({
					url:"UserInfo/listAll",
					valueField:"user_name",
					textField:"name",
					panelHeight: "auto",
					editable: false, //不允许手动输入 
					onLoadSuccess: function () { //数据加载完毕事件
						$("#jobRecord_userObj_user_name_edit").combobox("select", jobRecord.userObjPri);
						//var data = $("#jobRecord_userObj_user_name_edit").combobox("getData"); 
						//if (data.length > 0) {
							//$("#jobRecord_userObj_user_name_edit").combobox("select", data[0].user_name);
						//}
					}
				});
				$("#jobRecord_recordDate_edit").datetimebox({
					value: jobRecord.recordDate,
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

	$("#jobRecordModifyButton").click(function(){ 
		if ($("#jobRecordEditForm").form("validate")) {
			$("#jobRecordEditForm").form({
			    url:"JobRecord/" +  $("#jobRecord_recordId_edit").val() + "/update",
			    onSubmit: function(){
					if($("#jobRecordEditForm").form("validate"))  {
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
			$("#jobRecordEditForm").submit();
		} else {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		}
	});
});
