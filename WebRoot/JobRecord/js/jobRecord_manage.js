var jobRecord_manage_tool = null; 
$(function () { 
	initJobRecordManageTool(); //建立JobRecord管理对象
	jobRecord_manage_tool.init(); //如果需要通过下拉框查询，首先初始化下拉框的值
	$("#jobRecord_manage").datagrid({
		url : 'JobRecord/list',
		fit : true,
		fitColumns : true,
		striped : true,
		rownumbers : true,
		border : false,
		pagination : true,
		pageSize : 5,
		pageList : [5, 10, 15, 20, 25],
		pageNumber : 1,
		sortName : "recordId",
		sortOrder : "desc",
		toolbar : "#jobRecord_manage_tool",
		columns : [[
			{
				field : "recordId",
				title : "记录id",
				width : 70,
			},
			{
				field : "title",
				title : "标题",
				width : 140,
			},
			{
				field : "userObj",
				title : "记录人",
				width : 140,
			},
			{
				field : "recordDate",
				title : "记录时间",
				width : 140,
			},
		]],
	});

	$("#jobRecordEditDiv").dialog({
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
				if ($("#jobRecordEditForm").form("validate")) {
					//验证表单 
					if(!$("#jobRecordEditForm").form("validate")) {
						$.messager.alert("错误提示","你输入的信息还有错误！","warning");
					} else {
						$("#jobRecordEditForm").form({
						    url:"JobRecord/" + $("#jobRecord_recordId_edit").val() + "/update",
						    onSubmit: function(){
								if($("#jobRecordEditForm").form("validate"))  {
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
			                        $("#jobRecordEditDiv").dialog("close");
			                        jobRecord_manage_tool.reload();
			                    }else{
			                        $.messager.alert("消息",obj.message);
			                    } 
						    }
						});
						//提交表单
						$("#jobRecordEditForm").submit();
					}
				}
			},
		},{
			text : "取消",
			iconCls : "icon-redo",
			handler : function () {
				$("#jobRecordEditDiv").dialog("close");
				$("#jobRecordEditForm").form("reset"); 
			},
		}],
	});
});

function initJobRecordManageTool() {
	jobRecord_manage_tool = {
		init: function() {
			$.ajax({
				url : "UserInfo/listAll",
				type : "post",
				success : function (data, response, status) {
					$("#userObj_user_name_query").combobox({ 
					    valueField:"user_name",
					    textField:"name",
					    panelHeight: "200px",
				        editable: false, //不允许手动输入 
					});
					data.splice(0,0,{user_name:"",name:"不限制"});
					$("#userObj_user_name_query").combobox("loadData",data); 
				}
			});
		},
		reload : function () {
			$("#jobRecord_manage").datagrid("reload");
		},
		redo : function () {
			$("#jobRecord_manage").datagrid("unselectAll");
		},
		search: function() {
			var queryParams = $("#jobRecord_manage").datagrid("options").queryParams;
			queryParams["title"] = $("#title").val();
			queryParams["userObj.user_name"] = $("#userObj_user_name_query").combobox("getValue");
			queryParams["recordDate"] = $("#recordDate").datebox("getValue"); 
			$("#jobRecord_manage").datagrid("options").queryParams=queryParams; 
			$("#jobRecord_manage").datagrid("load");
		},
		exportExcel: function() {
			$("#jobRecordQueryForm").form({
			    url:"JobRecord/OutToExcel",
			});
			//提交表单
			$("#jobRecordQueryForm").submit();
		},
		remove : function () {
			var rows = $("#jobRecord_manage").datagrid("getSelections");
			if (rows.length > 0) {
				$.messager.confirm("确定操作", "您正在要删除所选的记录吗？", function (flag) {
					if (flag) {
						var recordIds = [];
						for (var i = 0; i < rows.length; i ++) {
							recordIds.push(rows[i].recordId);
						}
						$.ajax({
							type : "POST",
							url : "JobRecord/deletes",
							data : {
								recordIds : recordIds.join(","),
							},
							beforeSend : function () {
								$("#jobRecord_manage").datagrid("loading");
							},
							success : function (data) {
								if (data.success) {
									$("#jobRecord_manage").datagrid("loaded");
									$("#jobRecord_manage").datagrid("load");
									$("#jobRecord_manage").datagrid("unselectAll");
									$.messager.show({
										title : "提示",
										msg : data.message
									});
								} else {
									$("#jobRecord_manage").datagrid("loaded");
									$("#jobRecord_manage").datagrid("load");
									$("#jobRecord_manage").datagrid("unselectAll");
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
			var rows = $("#jobRecord_manage").datagrid("getSelections");
			if (rows.length > 1) {
				$.messager.alert("警告操作！", "编辑记录只能选定一条数据！", "warning");
			} else if (rows.length == 1) {
				$.ajax({
					url : "JobRecord/" + rows[0].recordId +  "/update",
					type : "get",
					data : {
						//recordId : rows[0].recordId,
					},
					beforeSend : function () {
						$.messager.progress({
							text : "正在获取中...",
						});
					},
					success : function (jobRecord, response, status) {
						$.messager.progress("close");
						if (jobRecord) { 
							$("#jobRecordEditDiv").dialog("open");
							$("#jobRecord_recordId_edit").val(jobRecord.recordId);
							$("#jobRecord_recordId_edit").validatebox({
								required : true,
								missingMessage : "请输入记录id",
								editable: false
							});
							$("#jobRecord_title_edit").val(jobRecord.title);
							$("#jobRecord_title_edit").validatebox({
								required : true,
								missingMessage : "请输入标题",
							});
							jobRecord_content_editor.setContent(jobRecord.content, false);
							$("#jobRecord_userObj_user_name_edit").combobox({
								url:"UserInfo/listAll",
							    valueField:"user_name",
							    textField:"name",
							    panelHeight: "auto",
						        editable: false, //不允许手动输入 
						        onLoadSuccess: function () { //数据加载完毕事件
									$("#jobRecord_userObj_user_name_edit").combobox("select", jobRecord.userObjPri);
									//var data = $("#jobRecord_userObj_user_name_edit").combobox("getData"); 
						            //if (data.length > 0) {
						                //$("#jobRecord_userObj_user_name_edit").combobox("select", data[0].user_name);
						            //}
								}
							});
							$("#jobRecord_recordDate_edit").datetimebox({
								value: jobRecord.recordDate,
							    required: true,
							    showSeconds: true,
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
