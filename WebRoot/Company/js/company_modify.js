$(function () {
	//实例化编辑器
	//建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例
	UE.delEditor('company_companyDesc_edit');
	var company_companyDesc_edit = UE.getEditor('company_companyDesc_edit'); //公司介绍编辑器
	company_companyDesc_edit.addListener("ready", function () {
		 // editor准备好之后才可以使用 
		 ajaxModifyQuery();
	}); 
  function ajaxModifyQuery() {	
	$.ajax({
		url : "Company/" + $("#company_companyUserName_edit").val() + "/update",
		type : "get",
		data : {
			//companyUserName : $("#company_companyUserName_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在获取中...",
			});
		},
		success : function (company, response, status) {
			$.messager.progress("close");
			if (company) { 
				$("#company_companyUserName_edit").val(company.companyUserName);
				$("#company_companyUserName_edit").validatebox({
					required : true,
					missingMessage : "请输入企业用户名",
					editable: false
				});
				$("#company_password_edit").val(company.password);
				$("#company_password_edit").validatebox({
					required : true,
					missingMessage : "请输入登录密码",
				});
				$("#company_qyjb_edit").val(company.qyjb);
				$("#company_qyjb_edit").validatebox({
					required : true,
					missingMessage : "请输入信用级别",
				});
				$("#company_companyName_edit").val(company.companyName);
				$("#company_companyName_edit").validatebox({
					required : true,
					missingMessage : "请输入企业名称",
				});
				$("#company_gszch_edit").val(company.gszch);
				$("#company_gszch_edit").validatebox({
					required : true,
					missingMessage : "请输入工商注册号",
				});
				$("#company_yyzz").val(company.yyzz);
				$("#company_yyzzImg").attr("src", company.yyzz);
				$("#company_gsxz_edit").val(company.gsxz);
				$("#company_gsxz_edit").validatebox({
					required : true,
					missingMessage : "请输入公司性质",
				});
				$("#company_gsgm_edit").val(company.gsgm);
				$("#company_gsgm_edit").validatebox({
					required : true,
					missingMessage : "请输入公司规模",
				});
				$("#company_gghy_edit").val(company.gghy);
				$("#company_gghy_edit").validatebox({
					required : true,
					missingMessage : "请输入公司行业",
				});
				$("#company_lxr_edit").val(company.lxr);
				$("#company_lxr_edit").validatebox({
					required : true,
					missingMessage : "请输入联系人",
				});
				$("#company_lxdh_edit").val(company.lxdh);
				$("#company_lxdh_edit").validatebox({
					required : true,
					missingMessage : "请输入联系电话",
				});
				company_companyDesc_edit.setContent(company.companyDesc);
				$("#company_address_edit").val(company.address);
				$("#company_address_edit").validatebox({
					required : true,
					missingMessage : "请输入公司地址",
				});
				$("#company_shzt_edit").val(company.shzt);
				$("#company_shzt_edit").validatebox({
					required : true,
					missingMessage : "请输入审核状态",
				});
			} else {
				$.messager.alert("获取失败！", "未知错误导致失败，请重试！", "warning");
				$(".messager-window").css("z-index",10000);
			}
		}
	});

  }

	$("#companyModifyButton").click(function(){ 
		if ($("#companyEditForm").form("validate")) {
			$("#companyEditForm").form({
			    url:"Company/" +  $("#company_companyUserName_edit").val() + "/update",
			    onSubmit: function(){
					if($("#companyEditForm").form("validate"))  {
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
			$("#companyEditForm").submit();
		} else {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		}
	});
});
