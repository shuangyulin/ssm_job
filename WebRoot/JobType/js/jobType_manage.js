var jobType_manage_tool = null; 
$(function () { 
	initJobTypeManageTool(); //建立JobType管理对象
	jobType_manage_tool.init(); //如果需要通过下拉框查询，首先初始化下拉框的值
	$("#jobType_manage").datagrid({
		url : 'JobType/list',
		fit : true,
		fitColumns : true,
		striped : true,
		rownumbers : true,
		border : false,
		pagination : true,
		pageSize : 5,
		pageList : [5, 10, 15, 20, 25],
		pageNumber : 1,
		sortName : "jobTypeId",
		sortOrder : "desc",
		toolbar : "#jobType_manage_tool",
		columns : [[
			{
				field : "jobTypeId",
				title : "职位类型id",
				width : 70,
			},
			{
				field : "jobTypeName",
				title : "职位类别名称",
				width : 140,
			},
			{
				field : "jobTypeDesc",
				title : "职位类别描述",
				width : 140,
			},
		]],
	});

	$("#jobTypeEditDiv").dialog({
		title : "修改管理",
		top: "50px",
		width : 700,
		height : 515,
		modal : true,
		closed : true,
		iconCls : "icon-edit-new",
		buttons : [{
			text : "提交",
			iconCls : "icon-edit-new",
			handler : function () {
				if ($("#jobTypeEditForm").form("validate")) {
					//验证表单 
					if(!$("#jobTypeEditForm").form("validate")) {
						$.messager.alert("错误提示","你输入的信息还有错误！","warning");
					} else {
						$("#jobTypeEditForm").form({
						    url:"JobType/" + $("#jobType_jobTypeId_edit").val() + "/update",
						    onSubmit: function(){
								if($("#jobTypeEditForm").form("validate"))  {
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
			                        $("#jobTypeEditDiv").dialog("close");
			                        jobType_manage_tool.reload();
			                    }else{
			                        $.messager.alert("消息",obj.message);
			                    } 
						    }
						});
						//提交表单
						$("#jobTypeEditForm").submit();
					}
				}
			},
		},{
			text : "取消",
			iconCls : "icon-redo",
			handler : function () {
				$("#jobTypeEditDiv").dialog("close");
				$("#jobTypeEditForm").form("reset"); 
			},
		}],
	});
});

function initJobTypeManageTool() {
	jobType_manage_tool = {
		init: function() {
		},
		reload : function () {
			$("#jobType_manage").datagrid("reload");
		},
		redo : function () {
			$("#jobType_manage").datagrid("unselectAll");
		},
		search: function() {
			$("#jobType_manage").datagrid("load");
		},
		exportExcel: function() {
			$("#jobTypeQueryForm").form({
			    url:"JobType/OutToExcel",
			});
			//提交表单
			$("#jobTypeQueryForm").submit();
		},
		remove : function () {
			var rows = $("#jobType_manage").datagrid("getSelections");
			if (rows.length > 0) {
				$.messager.confirm("确定操作", "您正在要删除所选的记录吗？", function (flag) {
					if (flag) {
						var jobTypeIds = [];
						for (var i = 0; i < rows.length; i ++) {
							jobTypeIds.push(rows[i].jobTypeId);
						}
						$.ajax({
							type : "POST",
							url : "JobType/deletes",
							data : {
								jobTypeIds : jobTypeIds.join(","),
							},
							beforeSend : function () {
								$("#jobType_manage").datagrid("loading");
							},
							success : function (data) {
								if (data.success) {
									$("#jobType_manage").datagrid("loaded");
									$("#jobType_manage").datagrid("load");
									$("#jobType_manage").datagrid("unselectAll");
									$.messager.show({
										title : "提示",
										msg : data.message
									});
								} else {
									$("#jobType_manage").datagrid("loaded");
									$("#jobType_manage").datagrid("load");
									$("#jobType_manage").datagrid("unselectAll");
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
			var rows = $("#jobType_manage").datagrid("getSelections");
			if (rows.length > 1) {
				$.messager.alert("警告操作！", "编辑记录只能选定一条数据！", "warning");
			} else if (rows.length == 1) {
				$.ajax({
					url : "JobType/" + rows[0].jobTypeId +  "/update",
					type : "get",
					data : {
						//jobTypeId : rows[0].jobTypeId,
					},
					beforeSend : function () {
						$.messager.progress({
							text : "正在获取中...",
						});
					},
					success : function (jobType, response, status) {
						$.messager.progress("close");
						if (jobType) { 
							$("#jobTypeEditDiv").dialog("open");
							$("#jobType_jobTypeId_edit").val(jobType.jobTypeId);
							$("#jobType_jobTypeId_edit").validatebox({
								required : true,
								missingMessage : "请输入职位类型id",
								editable: false
							});
							$("#jobType_jobTypeName_edit").val(jobType.jobTypeName);
							$("#jobType_jobTypeName_edit").validatebox({
								required : true,
								missingMessage : "请输入职位类别名称",
							});
							$("#jobType_jobTypeDesc_edit").val(jobType.jobTypeDesc);
							$("#jobType_jobTypeDesc_edit").validatebox({
								required : true,
								missingMessage : "请输入职位类别描述",
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
