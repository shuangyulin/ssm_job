$(function () {
	$.ajax({
		url : "Delivery/" + $("#delivery_deliveryId_edit").val() + "/update",
		type : "get",
		data : {
			//deliveryId : $("#delivery_deliveryId_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在获取中...",
			});
		},
		success : function (delivery, response, status) {
			$.messager.progress("close");
			if (delivery) { 
				$("#delivery_deliveryId_edit").val(delivery.deliveryId);
				$("#delivery_deliveryId_edit").validatebox({
					required : true,
					missingMessage : "请输入投递id",
					editable: false
				});
				$("#delivery_jobObj_jobId_edit").combobox({
					url:"Job/listAll",
					valueField:"jobId",
					textField:"jobName",
					panelHeight: "auto",
					editable: false, //不允许手动输入 
					onLoadSuccess: function () { //数据加载完毕事件
						$("#delivery_jobObj_jobId_edit").combobox("select", delivery.jobObjPri);
						//var data = $("#delivery_jobObj_jobId_edit").combobox("getData"); 
						//if (data.length > 0) {
							//$("#delivery_jobObj_jobId_edit").combobox("select", data[0].jobId);
						//}
					}
				});
				$("#delivery_userObj_user_name_edit").combobox({
					url:"UserInfo/listAll",
					valueField:"user_name",
					textField:"name",
					panelHeight: "auto",
					editable: false, //不允许手动输入 
					onLoadSuccess: function () { //数据加载完毕事件
						$("#delivery_userObj_user_name_edit").combobox("select", delivery.userObjPri);
						//var data = $("#delivery_userObj_user_name_edit").combobox("getData"); 
						//if (data.length > 0) {
							//$("#delivery_userObj_user_name_edit").combobox("select", data[0].user_name);
						//}
					}
				});
				$("#delivery_deliveryTime_edit").datetimebox({
					value: delivery.deliveryTime,
					required: true,
					showSeconds: true,
				});
				$("#delivery_handleTime_edit").datetimebox({
					value: delivery.handleTime,
					required: true,
					showSeconds: true,
				});
				$("#delivery_clzt_edit").val(delivery.clzt);
				$("#delivery_clzt_edit").validatebox({
					required : true,
					missingMessage : "请输入处理状态",
				});
				$("#delivery_tzxx_edit").val(delivery.tzxx);
				$("#delivery_tzxx_edit").validatebox({
					required : true,
					missingMessage : "请输入通知信息",
				});
				$("#delivery_gzpj_edit").val(delivery.gzpj);
				$("#delivery_gzpj_edit").validatebox({
					required : true,
					missingMessage : "请输入工作评价",
				});
			} else {
				$.messager.alert("获取失败！", "未知错误导致失败，请重试！", "warning");
				$(".messager-window").css("z-index",10000);
			}
		}
	});

	$("#deliveryModifyButton").click(function(){ 
		if ($("#deliveryEditForm").form("validate")) {
			$("#deliveryEditForm").form({
			    url:"Delivery/" +  $("#delivery_deliveryId_edit").val() + "/update",
			    onSubmit: function(){
					if($("#deliveryEditForm").form("validate"))  {
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
			$("#deliveryEditForm").submit();
		} else {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		}
	});
});
