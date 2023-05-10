var delivery_manage_tool = null; 
$(function () { 
	initDeliveryManageTool(); //建立Delivery管理对象
	delivery_manage_tool.init(); //如果需要通过下拉框查询，首先初始化下拉框的值
	$("#delivery_manage").datagrid({
		url : 'Delivery/list',
		fit : true,
		fitColumns : true,
		striped : true,
		rownumbers : true,
		border : false,
		pagination : true,
		pageSize : 5,
		pageList : [5, 10, 15, 20, 25],
		pageNumber : 1,
		sortName : "deliveryId",
		sortOrder : "desc",
		toolbar : "#delivery_manage_tool",
		columns : [[
			{
				field : "deliveryId",
				title : "投递id",
				width : 70,
			},
			{
				field : "jobObj",
				title : "应聘职位",
				width : 140,
			},
			{
				field : "userObj",
				title : "应聘人",
				width : 140,
			},
			{
				field : "deliveryTime",
				title : "投递时间",
				width : 140,
			},
			{
				field : "handleTime",
				title : "处理时间",
				width : 140,
			},
			{
				field : "clzt",
				title : "处理状态",
				width : 140,
			},
			{
				field : "tzxx",
				title : "通知信息",
				width : 140,
			},
			{
				field : "gzpj",
				title : "工作评价",
				width : 140,
			},
		]],
	});

	$("#deliveryEditDiv").dialog({
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
				if ($("#deliveryEditForm").form("validate")) {
					//验证表单 
					if(!$("#deliveryEditForm").form("validate")) {
						$.messager.alert("错误提示","你输入的信息还有错误！","warning");
					} else {
						$("#deliveryEditForm").form({
						    url:"Delivery/" + $("#delivery_deliveryId_edit").val() + "/update",
						    onSubmit: function(){
								if($("#deliveryEditForm").form("validate"))  {
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
			                        $("#deliveryEditDiv").dialog("close");
			                        delivery_manage_tool.reload();
			                    }else{
			                        $.messager.alert("消息",obj.message);
			                    } 
						    }
						});
						//提交表单
						$("#deliveryEditForm").submit();
					}
				}
			},
		},{
			text : "取消",
			iconCls : "icon-redo",
			handler : function () {
				$("#deliveryEditDiv").dialog("close");
				$("#deliveryEditForm").form("reset"); 
			},
		}],
	});
});

function initDeliveryManageTool() {
	delivery_manage_tool = {
		init: function() {
			$.ajax({
				url : "Job/listAll",
				type : "post",
				success : function (data, response, status) {
					$("#jobObj_jobId_query").combobox({ 
					    valueField:"jobId",
					    textField:"jobName",
					    panelHeight: "200px",
				        editable: false, //不允许手动输入 
					});
					data.splice(0,0,{jobId:0,jobName:"不限制"});
					$("#jobObj_jobId_query").combobox("loadData",data); 
				}
			});
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
			$("#delivery_manage").datagrid("reload");
		},
		redo : function () {
			$("#delivery_manage").datagrid("unselectAll");
		},
		search: function() {
			var queryParams = $("#delivery_manage").datagrid("options").queryParams;
			queryParams["jobObj.jobId"] = $("#jobObj_jobId_query").combobox("getValue");
			queryParams["userObj.user_name"] = $("#userObj_user_name_query").combobox("getValue");
			queryParams["deliveryTime"] = $("#deliveryTime").datebox("getValue"); 
			queryParams["handleTime"] = $("#handleTime").datebox("getValue"); 
			queryParams["clzt"] = $("#clzt").val();
			$("#delivery_manage").datagrid("options").queryParams=queryParams; 
			$("#delivery_manage").datagrid("load");
		},
		exportExcel: function() {
			$("#deliveryQueryForm").form({
			    url:"Delivery/OutToExcel",
			});
			//提交表单
			$("#deliveryQueryForm").submit();
		},
		remove : function () {
			var rows = $("#delivery_manage").datagrid("getSelections");
			if (rows.length > 0) {
				$.messager.confirm("确定操作", "您正在要删除所选的记录吗？", function (flag) {
					if (flag) {
						var deliveryIds = [];
						for (var i = 0; i < rows.length; i ++) {
							deliveryIds.push(rows[i].deliveryId);
						}
						$.ajax({
							type : "POST",
							url : "Delivery/deletes",
							data : {
								deliveryIds : deliveryIds.join(","),
							},
							beforeSend : function () {
								$("#delivery_manage").datagrid("loading");
							},
							success : function (data) {
								if (data.success) {
									$("#delivery_manage").datagrid("loaded");
									$("#delivery_manage").datagrid("load");
									$("#delivery_manage").datagrid("unselectAll");
									$.messager.show({
										title : "提示",
										msg : data.message
									});
								} else {
									$("#delivery_manage").datagrid("loaded");
									$("#delivery_manage").datagrid("load");
									$("#delivery_manage").datagrid("unselectAll");
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
			var rows = $("#delivery_manage").datagrid("getSelections");
			if (rows.length > 1) {
				$.messager.alert("警告操作！", "编辑记录只能选定一条数据！", "warning");
			} else if (rows.length == 1) {
				$.ajax({
					url : "Delivery/" + rows[0].deliveryId +  "/update",
					type : "get",
					data : {
						//deliveryId : rows[0].deliveryId,
					},
					beforeSend : function () {
						$.messager.progress({
							text : "正在获取中...",
						});
					},
					success : function (delivery, response, status) {
						$.messager.progress("close");
						if (delivery) { 
							$("#deliveryEditDiv").dialog("open");
							$("#delivery_deliveryId_edit").val(delivery.deliveryId);
							$("#delivery_deliveryId_edit").validatebox({
								required : true,
								missingMessage : "请输入投递id",
								editable: false
							});
							$("#delivery_jobObj_jobId_edit").combobox({
								url:"Job/listAll",
							    valueField:"jobId",
							    textField:"jobName",
							    panelHeight: "auto",
						        editable: false, //不允许手动输入 
						        onLoadSuccess: function () { //数据加载完毕事件
									$("#delivery_jobObj_jobId_edit").combobox("select", delivery.jobObjPri);
									//var data = $("#delivery_jobObj_jobId_edit").combobox("getData"); 
						            //if (data.length > 0) {
						                //$("#delivery_jobObj_jobId_edit").combobox("select", data[0].jobId);
						            //}
								}
							});
							$("#delivery_userObj_user_name_edit").combobox({
								url:"UserInfo/listAll",
							    valueField:"user_name",
							    textField:"name",
							    panelHeight: "auto",
						        editable: false, //不允许手动输入 
						        onLoadSuccess: function () { //数据加载完毕事件
									$("#delivery_userObj_user_name_edit").combobox("select", delivery.userObjPri);
									//var data = $("#delivery_userObj_user_name_edit").combobox("getData"); 
						            //if (data.length > 0) {
						                //$("#delivery_userObj_user_name_edit").combobox("select", data[0].user_name);
						            //}
								}
							});
							$("#delivery_deliveryTime_edit").datetimebox({
								value: delivery.deliveryTime,
							    required: true,
							    showSeconds: true,
							});
							$("#delivery_handleTime_edit").datetimebox({
								value: delivery.handleTime,
							    required: true,
							    showSeconds: true,
							});
							$("#delivery_clzt_edit").val(delivery.clzt);
							$("#delivery_clzt_edit").validatebox({
								required : true,
								missingMessage : "请输入处理状态",
							});
							$("#delivery_tzxx_edit").val(delivery.tzxx);
							$("#delivery_tzxx_edit").validatebox({
								required : true,
								missingMessage : "请输入通知信息",
							});
							$("#delivery_gzpj_edit").val(delivery.gzpj);
							$("#delivery_gzpj_edit").validatebox({
								required : true,
								missingMessage : "请输入工作评价",
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
