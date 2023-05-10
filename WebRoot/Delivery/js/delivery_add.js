$(function () {
	$("#delivery_jobObj_jobId").combobox({
	    url:'Job/listAll',
	    valueField: "jobId",
	    textField: "jobName",
	    panelHeight: "auto",
        editable: false, //不允许手动输入
        required : true,
        onLoadSuccess: function () { //数据加载完毕事件
            var data = $("#delivery_jobObj_jobId").combobox("getData"); 
            if (data.length > 0) {
                $("#delivery_jobObj_jobId").combobox("select", data[0].jobId);
            }
        }
	});
	$("#delivery_userObj_user_name").combobox({
	    url:'UserInfo/listAll',
	    valueField: "user_name",
	    textField: "name",
	    panelHeight: "auto",
        editable: false, //不允许手动输入
        required : true,
        onLoadSuccess: function () { //数据加载完毕事件
            var data = $("#delivery_userObj_user_name").combobox("getData"); 
            if (data.length > 0) {
                $("#delivery_userObj_user_name").combobox("select", data[0].user_name);
            }
        }
	});
	$("#delivery_deliveryTime").datetimebox({
	    required : true, 
	    showSeconds: true,
	    editable: false
	});

	$("#delivery_handleTime").datetimebox({
	    required : true, 
	    showSeconds: true,
	    editable: false
	});

	$("#delivery_clzt").validatebox({
		required : true, 
		missingMessage : '请输入处理状态',
	});

	$("#delivery_tzxx").validatebox({
		required : true, 
		missingMessage : '请输入通知信息',
	});

	$("#delivery_gzpj").validatebox({
		required : true, 
		missingMessage : '请输入工作评价',
	});

	//单击添加按钮
	$("#deliveryAddButton").click(function () {
		//验证表单 
		if(!$("#deliveryAddForm").form("validate")) {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		} else {
			$("#deliveryAddForm").form({
			    url:"Delivery/add",
			    onSubmit: function(){
					if($("#deliveryAddForm").form("validate"))  { 
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
                        $("#deliveryAddForm").form("clear");
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    }
			    }
			});
			//提交表单
			$("#deliveryAddForm").submit();
		}
	});

	//单击清空按钮
	$("#deliveryClearButton").click(function () { 
		$("#deliveryAddForm").form("clear"); 
	});
});
