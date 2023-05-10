var webLink_manage_tool = null; 
$(function () { 
	initWebLinkManageTool(); //建立WebLink管理对象
	webLink_manage_tool.init(); //如果需要通过下拉框查询，首先初始化下拉框的值
	$("#webLink_manage").datagrid({
		url : 'WebLink/list',
		fit : true,
		fitColumns : true,
		striped : true,
		rownumbers : true,
		border : false,
		pagination : true,
		pageSize : 5,
		pageList : [5, 10, 15, 20, 25],
		pageNumber : 1,
		sortName : "linkId",
		sortOrder : "desc",
		toolbar : "#webLink_manage_tool",
		columns : [[
			{
				field : "linkId",
				title : "记录id",
				width : 70,
			},
			{
				field : "webName",
				title : "网站名称",
				width : 140,
			},
			{
				field : "webLogo",
				title : "网站Logo",
				width : "70px",
				height: "65px",
				formatter: function(val,row) {
					return "<img src='" + val + "' width='65px' height='55px' />";
				}
 			},
			{
				field : "webAddress",
				title : "网站地址",
				width : 140,
			},
		]],
	});

	$("#webLinkEditDiv").dialog({
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
				if ($("#webLinkEditForm").form("validate")) {
					//验证表单 
					if(!$("#webLinkEditForm").form("validate")) {
						$.messager.alert("错误提示","你输入的信息还有错误！","warning");
					} else {
						$("#webLinkEditForm").form({
						    url:"WebLink/" + $("#webLink_linkId_edit").val() + "/update",
						    onSubmit: function(){
								if($("#webLinkEditForm").form("validate"))  {
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
			                        $("#webLinkEditDiv").dialog("close");
			                        webLink_manage_tool.reload();
			                    }else{
			                        $.messager.alert("消息",obj.message);
			                    } 
						    }
						});
						//提交表单
						$("#webLinkEditForm").submit();
					}
				}
			},
		},{
			text : "取消",
			iconCls : "icon-redo",
			handler : function () {
				$("#webLinkEditDiv").dialog("close");
				$("#webLinkEditForm").form("reset"); 
			},
		}],
	});
});

function initWebLinkManageTool() {
	webLink_manage_tool = {
		init: function() {
		},
		reload : function () {
			$("#webLink_manage").datagrid("reload");
		},
		redo : function () {
			$("#webLink_manage").datagrid("unselectAll");
		},
		search: function() {
			$("#webLink_manage").datagrid("load");
		},
		exportExcel: function() {
			$("#webLinkQueryForm").form({
			    url:"WebLink/OutToExcel",
			});
			//提交表单
			$("#webLinkQueryForm").submit();
		},
		remove : function () {
			var rows = $("#webLink_manage").datagrid("getSelections");
			if (rows.length > 0) {
				$.messager.confirm("确定操作", "您正在要删除所选的记录吗？", function (flag) {
					if (flag) {
						var linkIds = [];
						for (var i = 0; i < rows.length; i ++) {
							linkIds.push(rows[i].linkId);
						}
						$.ajax({
							type : "POST",
							url : "WebLink/deletes",
							data : {
								linkIds : linkIds.join(","),
							},
							beforeSend : function () {
								$("#webLink_manage").datagrid("loading");
							},
							success : function (data) {
								if (data.success) {
									$("#webLink_manage").datagrid("loaded");
									$("#webLink_manage").datagrid("load");
									$("#webLink_manage").datagrid("unselectAll");
									$.messager.show({
										title : "提示",
										msg : data.message
									});
								} else {
									$("#webLink_manage").datagrid("loaded");
									$("#webLink_manage").datagrid("load");
									$("#webLink_manage").datagrid("unselectAll");
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
			var rows = $("#webLink_manage").datagrid("getSelections");
			if (rows.length > 1) {
				$.messager.alert("警告操作！", "编辑记录只能选定一条数据！", "warning");
			} else if (rows.length == 1) {
				$.ajax({
					url : "WebLink/" + rows[0].linkId +  "/update",
					type : "get",
					data : {
						//linkId : rows[0].linkId,
					},
					beforeSend : function () {
						$.messager.progress({
							text : "正在获取中...",
						});
					},
					success : function (webLink, response, status) {
						$.messager.progress("close");
						if (webLink) { 
							$("#webLinkEditDiv").dialog("open");
							$("#webLink_linkId_edit").val(webLink.linkId);
							$("#webLink_linkId_edit").validatebox({
								required : true,
								missingMessage : "请输入记录id",
								editable: false
							});
							$("#webLink_webName_edit").val(webLink.webName);
							$("#webLink_webName_edit").validatebox({
								required : true,
								missingMessage : "请输入网站名称",
							});
							$("#webLink_webLogo").val(webLink.webLogo);
							$("#webLink_webLogoImg").attr("src", webLink.webLogo);
							$("#webLink_webAddress_edit").val(webLink.webAddress);
							$("#webLink_webAddress_edit").validatebox({
								required : true,
								missingMessage : "请输入网站地址",
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
