$(function () {
	//实例化编辑器
	//建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例
	UE.delEditor('job_jobDesc');
	var job_jobDesc_editor = UE.getEditor('job_jobDesc'); //职位描述编辑框
	$("#job_jobTypeObj_jobTypeId").combobox({
	    url:'JobType/listAll',
	    valueField: "jobTypeId",
	    textField: "jobTypeName",
	    panelHeight: "auto",
        editable: false, //不允许手动输入
        required : true,
        onLoadSuccess: function () { //数据加载完毕事件
            var data = $("#job_jobTypeObj_jobTypeId").combobox("getData"); 
            if (data.length > 0) {
                $("#job_jobTypeObj_jobTypeId").combobox("select", data[0].jobTypeId);
            }
        }
	});
	$("#job_jobName").validatebox({
		required : true, 
		missingMessage : '请输入职位名称',
	});

	$("#job_salary").validatebox({
		required : true, 
		missingMessage : '请输入工作薪酬',
	});

	$("#job_zprs").validatebox({
		required : true,
		validType : "integer",
		missingMessage : '请输入招聘人数',
		invalidMessage : '招聘人数输入不对',
	});

	$("#job_xlyq").validatebox({
		required : true, 
		missingMessage : '请输入学历要求',
	});

	$("#job_yxqx").validatebox({
		required : true, 
		missingMessage : '请输入有效期限',
	});

	$("#job_gzqy").validatebox({
		required : true, 
		missingMessage : '请输入工作区域',
	});

	$("#job_gzdz").validatebox({
		required : true, 
		missingMessage : '请输入工作地址',
	});

	$("#job_viewNum").validatebox({
		required : true,
		validType : "integer",
		missingMessage : '请输入浏览次数',
		invalidMessage : '浏览次数输入不对',
	});

	$("#job_companyObj_companyUserName").combobox({
	    url:'Company/listAll',
	    valueField: "companyUserName",
	    textField: "companyName",
	    panelHeight: "auto",
        editable: false, //不允许手动输入
        required : true,
        onLoadSuccess: function () { //数据加载完毕事件
            var data = $("#job_companyObj_companyUserName").combobox("getData"); 
            if (data.length > 0) {
                $("#job_companyObj_companyUserName").combobox("select", data[0].companyUserName);
            }
        }
	});
	$("#job_addTime").datetimebox({
	    required : true, 
	    showSeconds: true,
	    editable: false
	});

	//单击添加按钮
	$("#jobAddButton").click(function () {
		if(job_jobDesc_editor.getContent() == "") {
			alert("请输入职位描述");
			return;
		}
		//验证表单 
		if(!$("#jobAddForm").form("validate")) {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		} else {
			$("#jobAddForm").form({
			    url:"Job/add",
			    onSubmit: function(){
					if($("#jobAddForm").form("validate"))  { 
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
                        $("#jobAddForm").form("clear");
                        job_jobDesc_editor.setContent("");
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    }
			    }
			});
			//提交表单
			$("#jobAddForm").submit();
		}
	});

	//单击清空按钮
	$("#jobClearButton").click(function () { 
		$("#jobAddForm").form("clear"); 
	});
});
