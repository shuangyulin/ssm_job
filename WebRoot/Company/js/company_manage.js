var company_manage_tool = null; 
$(function () { 
	initCompanyManageTool(); //建立Company管理对象
	company_manage_tool.init(); //如果需要通过下拉框查询，首先初始化下拉框的值
	$("#company_manage").datagrid({
		url : 'Company/list',
		fit : true,
		fitColumns : true,
		striped : true,
		rownumbers : true,
		border : false,
		pagination : true,
		pageSize : 5,
		pageList : [5, 10, 15, 20, 25],
		pageNumber : 1,
		sortName : "companyUserName",
		sortOrder : "desc",
		toolbar : "#company_manage_tool",
		columns : [[
			{
				field : "companyUserName",
				title : "企业用户名",
				width : 140,
			},
			{
				field : "qyjb",
				title : "信用级别",
				width : 140,
			},
			{
				field : "companyName",
				title : "企业名称",
				width : 140,
			},
			{
				field : "gszch",
				title : "工商注册号",
				width : 140,
			},
			{
				field : "yyzz",
				title : "营业执照",
				width : "70px",
				height: "65px",
				formatter: function(val,row) {
					return "<img src='" + val + "' width='65px' height='55px' />";
				}
 			},
			{
				field : "gsxz",
				title : "公司性质",
				width : 140,
			},
			{
				field : "gsgm",
				title : "公司规模",
				width : 140,
			},
			{
				field : "gghy",
				title : "公司行业",
				width : 140,
			},
			{
				field : "lxr",
				title : "联系人",
				width : 140,
			},
			{
				field : "lxdh",
				title : "联系电话",
				width : 140,
			},
			{
				field : "shzt",
				title : "审核状态",
				width : 140,
			},
		]],
	});

	$("#companyEditDiv").dialog({
		title : "修改管理",
		top: "10px",
		width : 1000,
		height : 600,
		modal : true,
		closed : true,
		iconCls : "icon-edit-new",
		buttons : [{
			text : "提交",
			iconCls : "icon-edit-new",
			handler : function () {
				if ($("#companyEditForm").form("validate")) {
					//验证表单 
					if(!$("#companyEditForm").form("validate")) {
						$.messager.alert("错误提示","你输入的信息还有错误！","warning");
					} else {
						$("#companyEditForm").form({
						    url:"Company/" + $("#company_companyUserName_edit").val() + "/update",
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
						    	console.log(data);
			                	var obj = jQuery.parseJSON(data);
			                    if(obj.success){
			                        $.messager.alert("消息","信息修改成功！");
			                        $("#companyEditDiv").dialog("close");
			                        company_manage_tool.reload();
			                    }else{
			                        $.messager.alert("消息",obj.message);
			                    } 
						    }
						});
						//提交表单
						$("#companyEditForm").submit();
					}
				}
			},
		},{
			text : "取消",
			iconCls : "icon-redo",
			handler : function () {
				$("#companyEditDiv").dialog("close");
				$("#companyEditForm").form("reset"); 
			},
		}],
	});
});

function initCompanyManageTool() {
	company_manage_tool = {
		init: function() {
		},
		reload : function () {
			$("#company_manage").datagrid("reload");
		},
		redo : function () {
			$("#company_manage").datagrid("unselectAll");
		},
		search: function() {
			var queryParams = $("#company_manage").datagrid("options").queryParams;
			queryParams["qyjb"] = $("#qyjb").val();
			queryParams["companyName"] = $("#companyName").val();
			queryParams["gszch"] = $("#gszch").val();
			queryParams["gsxz"] = $("#gsxz").val();
			queryParams["gsgm"] = $("#gsgm").val();
			queryParams["gghy"] = $("#gghy").val();
			queryParams["lxr"] = $("#lxr").val();
			queryParams["lxdh"] = $("#lxdh").val();
			queryParams["shzt"] = $("#shzt").val();
			$("#company_manage").datagrid("options").queryParams=queryParams; 
			$("#company_manage").datagrid("load");
		},
		exportExcel: function() {
			$("#companyQueryForm").form({
			    url:"Company/OutToExcel",
			});
			//提交表单
			$("#companyQueryForm").submit();
		},
		remove : function () {
			var rows = $("#company_manage").datagrid("getSelections");
			if (rows.length > 0) {
				$.messager.confirm("确定操作", "您正在要删除所选的记录吗？", function (flag) {
					if (flag) {
						var companyUserNames = [];
						for (var i = 0; i < rows.length; i ++) {
							companyUserNames.push(rows[i].companyUserName);
						}
						$.ajax({
							type : "POST",
							url : "Company/deletes",
							data : {
								companyUserNames : companyUserNames.join(","),
							},
							beforeSend : function () {
								$("#company_manage").datagrid("loading");
							},
							success : function (data) {
								if (data.success) {
									$("#company_manage").datagrid("loaded");
									$("#company_manage").datagrid("load");
									$("#company_manage").datagrid("unselectAll");
									$.messager.show({
										title : "提示",
										msg : data.message
									});
								} else {
									$("#company_manage").datagrid("loaded");
									$("#company_manage").datagrid("load");
									$("#company_manage").datagrid("unselectAll");
									$.messager.alert("消息",data.message);
								}
							},
						});
					}
				});
			} else {
				$.messager.alert("提示", "请选择要删除的记录！", "info");
			}
		},
		edit : function () {
			var rows = $("#company_manage").datagrid("getSelections");
			if (rows.length > 1) {
				$.messager.alert("警告操作！", "编辑记录只能选定一条数据！", "warning");
			} else if (rows.length == 1) {
				$.ajax({
					url : "Company/" + rows[0].companyUserName +  "/update",
					type : "get",
					data : {
						//companyUserName : rows[0].companyUserName,
					},
					beforeSend : function () {
						$.messager.progress({
							text : "正在获取中...",
						});
					},
					success : function (company, response, status) {
						$.messager.progress("close");
						if (company) { 
							$("#companyEditDiv").dialog("open");
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
							company_companyDesc_editor.setContent(company.companyDesc, false);
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
						}
					}
				});
			} else if (rows.length == 0) {
				$.messager.alert("警告操作！", "编辑记录至少选定一条数据！", "warning");
			}
		},
	};
}
