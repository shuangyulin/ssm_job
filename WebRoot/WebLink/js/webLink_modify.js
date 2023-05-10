$(function () {
	$.ajax({
		url : "WebLink/" + $("#webLink_linkId_edit").val() + "/update",
		type : "get",
		data : {
			//linkId : $("#webLink_linkId_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在获取中...",
			});
		},
		success : function (webLink, response, status) {
			$.messager.progress("close");
			if (webLink) { 
				$("#webLink_linkId_edit").val(webLink.linkId);
				$("#webLink_linkId_edit").validatebox({
					required : true,
					missingMessage : "请输入记录id",
					editable: false
				});
				$("#webLink_webName_edit").val(webLink.webName);
				$("#webLink_webName_edit").validatebox({
					required : true,
					missingMessage : "请输入网站名称",
				});
				$("#webLink_webLogo").val(webLink.webLogo);
				$("#webLink_webLogoImg").attr("src", webLink.webLogo);
				$("#webLink_webAddress_edit").val(webLink.webAddress);
				$("#webLink_webAddress_edit").validatebox({
					required : true,
					missingMessage : "请输入网站地址",
				});
			} else {
				$.messager.alert("获取失败！", "未知错误导致失败，请重试！", "warning");
				$(".messager-window").css("z-index",10000);
			}
		}
	});

	$("#webLinkModifyButton").click(function(){ 
		if ($("#webLinkEditForm").form("validate")) {
			$("#webLinkEditForm").form({
			    url:"WebLink/" +  $("#webLink_linkId_edit").val() + "/update",
			    onSubmit: function(){
					if($("#webLinkEditForm").form("validate"))  {
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
			$("#webLinkEditForm").submit();
		} else {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		}
	});
});
