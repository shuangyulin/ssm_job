$(function () {
	$("#webLink_webName").validatebox({
		required : true, 
		missingMessage : '请输入网站名称',
	});

	$("#webLink_webAddress").validatebox({
		required : true, 
		missingMessage : '请输入网站地址',
	});

	//单击添加按钮
	$("#webLinkAddButton").click(function () {
		//验证表单 
		if(!$("#webLinkAddForm").form("validate")) {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		} else {
			$("#webLinkAddForm").form({
			    url:"WebLink/add",
			    onSubmit: function(){
					if($("#webLinkAddForm").form("validate"))  { 
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
                    //此处data={"Success":true}是字符串
                	var obj = jQuery.parseJSON(data); 
                    if(obj.success){ 
                        $.messager.alert("消息","保存成功！");
                        $(".messager-window").css("z-index",10000);
                        $("#webLinkAddForm").form("clear");
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    }
			    }
			});
			//提交表单
			$("#webLinkAddForm").submit();
		}
	});

	//单击清空按钮
	$("#webLinkClearButton").click(function () { 
		$("#webLinkAddForm").form("clear"); 
	});
});
