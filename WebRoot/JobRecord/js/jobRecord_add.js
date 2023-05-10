$(function () {
	//实例化编辑器
	//建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例
	UE.delEditor('jobRecord_content');
	var jobRecord_content_editor = UE.getEditor('jobRecord_content'); //内容编辑框
	$("#jobRecord_title").validatebox({
		required : true, 
		missingMessage : '请输入标题',
	});

	$("#jobRecord_userObj_user_name").combobox({
	    url:'UserInfo/listAll',
	    valueField: "user_name",
	    textField: "name",
	    panelHeight: "auto",
        editable: false, //不允许手动输入
        required : true,
        onLoadSuccess: function () { //数据加载完毕事件
            var data = $("#jobRecord_userObj_user_name").combobox("getData"); 
            if (data.length > 0) {
                $("#jobRecord_userObj_user_name").combobox("select", data[0].user_name);
            }
        }
	});
	$("#jobRecord_recordDate").datetimebox({
	    required : true, 
	    showSeconds: true,
	    editable: false
	});

	//单击添加按钮
	$("#jobRecordAddButton").click(function () {
		if(jobRecord_content_editor.getContent() == "") {
			alert("请输入内容");
			return;
		}
		//验证表单 
		if(!$("#jobRecordAddForm").form("validate")) {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		} else {
			$("#jobRecordAddForm").form({
			    url:"JobRecord/add",
			    onSubmit: function(){
					if($("#jobRecordAddForm").form("validate"))  { 
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
                        $("#jobRecordAddForm").form("clear");
                        jobRecord_content_editor.setContent("");
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    }
			    }
			});
			//提交表单
			$("#jobRecordAddForm").submit();
		}
	});

	//单击清空按钮
	$("#jobRecordClearButton").click(function () { 
		$("#jobRecordAddForm").form("clear"); 
	});
});
