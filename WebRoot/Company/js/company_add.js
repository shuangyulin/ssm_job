$(function () {
	//实例化编辑器
	//建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例
	UE.delEditor('company_companyDesc');
	var company_companyDesc_editor = UE.getEditor('company_companyDesc'); //公司介绍编辑框
	$("#company_companyUserName").validatebox({
		required : true, 
		missingMessage : '请输入企业用户名',
	});

	$("#company_password").validatebox({
		required : true, 
		missingMessage : '请输入登录密码',
	});

	$("#company_qyjb").validatebox({
		required : true, 
		missingMessage : '请输入信用级别',
	});

	$("#company_companyName").validatebox({
		required : true, 
		missingMessage : '请输入企业名称',
	});

	$("#company_gszch").validatebox({
		required : true, 
		missingMessage : '请输入工商注册号',
	});

	$("#company_gsxz").validatebox({
		required : true, 
		missingMessage : '请输入公司性质',
	});

	$("#company_gsgm").validatebox({
		required : true, 
		missingMessage : '请输入公司规模',
	});

	$("#company_gghy").validatebox({
		required : true, 
		missingMessage : '请输入公司行业',
	});

	$("#company_lxr").validatebox({
		required : true, 
		missingMessage : '请输入联系人',
	});

	$("#company_lxdh").validatebox({
		required : true, 
		missingMessage : '请输入联系电话',
	});

	$("#company_address").validatebox({
		required : true, 
		missingMessage : '请输入公司地址',
	});

	$("#company_shzt").validatebox({
		required : true, 
		missingMessage : '请输入审核状态',
	});

	//单击添加按钮
	$("#companyAddButton").click(function () {
		if(company_companyDesc_editor.getContent() == "") {
			alert("请输入公司介绍");
			return;
		}
		//验证表单 
		if(!$("#companyAddForm").form("validate")) {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		} else {
			$("#companyAddForm").form({
			    url:"Company/add",
			    onSubmit: function(){
					if($("#companyAddForm").form("validate"))  { 
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
                        $("#companyAddForm").form("clear");
                        company_companyDesc_editor.setContent("");
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    }
			    }
			});
			//提交表单
			$("#companyAddForm").submit();
		}
	});

	//单击清空按钮
	$("#companyClearButton").click(function () { 
		$("#companyAddForm").form("clear"); 
	});
});
