<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>book_desc.jsp</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<meta http-equiv="content-type" content="text/html;charset=utf-8">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<link rel="stylesheet" type="text/css" href="<c:url value='/adminjsps/admin/css/book/desc.css'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/jquery/jquery.datepick.css'/>">
<script type="text/javascript" src="<c:url value='/jquery/jquery-1.5.1.js'/>"></script>
<script type="text/javascript" src="<c:url value='/jquery/jquery.datepick.js'/>"></script>
<script type="text/javascript" src="<c:url value='/jquery/jquery.datepick-zh-CN.js'/>"></script>

<script type="text/javascript" src="<c:url value='/adminjsps/admin/js/book/desc.js'/>"></script>

<script type="text/javascript">

$(function() {
	$("#box").attr("checked", false);
	$("#formDiv").css("display", "none");
	$("#show").css("display", "");	
	
	// 操作和显示切换
	$("#box").click(function() {
		if($(this).attr("checked")) {
			$("#show").css("display", "none");
			$("#formDiv").css("display", "");
		} else {
			$("#formDiv").css("display", "none");
			$("#show").css("display", "");		
		}
	});
});

function loadChildren() {
	/*
	1. 获取pid
	2. 发出异步请求，功能之：
	  3. 得到一个数组
	  4. 获取cid元素(<select>)，把内部的<option>全部删除
	  5. 添加一个头（<option>请选择2级分类</option>）
	  6. 循环数组，把数组中每个对象转换成一个<option>添加到cid中
	*/
	// 1. 获取pid
	var pid = $("#pid").val();
	// 2. 发送异步请求
	$.ajax({
		async:true,
		cache:false,
		url:"/admin/AdminBookServlet",
		data:{method:"ajaxFindChildren", pid:pid},
		type:"POST",
		dataType:"json",
		success:function(arr) {
			// 3. 得到cid，删除它的内容
			$("#cid").empty();//删除元素的子元素
			$("#cid").append($("<option>====请选择2级分类====</option>"));//4.添加头
			// 5. 循环遍历数组，把每个对象转换成<option>添加到cid中
			for(var i = 0; i < arr.length; i++) {
				var option = $("<option>").val(arr[i].cid).text(arr[i].cname);
				$("#cid").append(option);
			}
		}
	});
}

/*
 * 点击编辑按钮时执行本函数
 */
function editForm() {
	$("#method").val("edit");
	$("#form").submit();
}
/*
 * 点击删除按钮时执行本函数
 */
 function deleteForm() {
	$("#method").val("delete");
	$("#form").submit();	
}

</script>
  </head>
  
  <body>
    <input type="checkbox" id="box"><label for="box">编辑或删除</label>
    <br/>
    <br/>
  <div id="show">
    <div class="sm">${book.bname }</div>
    <img align="top" src="<c:url value='/${book.image_w }'/>" class="tp"/>
    <div id="book" style="float:left;">
	    <ul>
	    	<li>商品编号： ${book.bid }</li>
	    	<li>优惠价：<span class="price_n">&yen;${book.currPrice }</span></li>
	    	<li>市场价：<span style="text-decoration:line-through;">&yen;${book.price }</span>　折扣：<span style="color: #c30;">${book.discount }</span>折</li>
	    </ul>
		<hr style="margin-left: 50px; height: 1px; color: #dcdcdc"/>
		<table class="tab">
			<tr>
				<td width="180">材料：${book.author }</td>
			</tr>
			<tr>
				<td width="180">包装：${book.press }</td>
			</tr>
			<tr>
				<td width="180">花语：${book.publishtime }</td>
			</tr>
			<tr>
				<td width="180">附送：${book.printtime }</td>
			</tr>
			<tr>
				<td width="180">配送：${book.paper }</td>
			</tr>
		</table>
	</div>
  </div>
  
  
  <div id='formDiv'>
   <div class="sm">&nbsp;</div>
   <form action="<c:url value='/admin/AdminBookServlet'/>" method="post" id="form">
    <input type="hidden" name="method" id="method"/>
   	<input type="hidden" name="bid" value="${book.bid }"/>
    <img align="top" src="<c:url value='/${book.image_w }'/>" class="tp"/>
    <div style="float:left;">
	    <ul>
	    	<li>商品编号： ${book.bid }</li>
	    	<li>商品名：  <input id="bname" type="text" name="bname" value="${book.bname }" style="width:500px;"/></li>
	    	<li>优惠价：  <input id="currPrice" type="text" name="currPrice" value="${book.currPrice }" style="width:50px;"/></li>
	    	<li>市场价：  <input id="price" type="text" name="price" value="${book.price }" style="width:50px;"/>
	    	折扣：<input id="discount" type="text" name="discount" value="${book.discount }" style="width:30px;"/>折</li>
	    </ul>
		<hr style="margin-left: 50px; height: 1px; color: #dcdcdc"/>
		<table class="tab">
			<tr>
				<td colspan="2">
					材料：  <input id="author" type="text" name="author" value="${book.author }" style="min-width:500px; width:auto;"/>
				</td>
			</tr>
			<tr>
				<td colspan="2">
					包装：  <input id="press" type="text" name="press" value="${book.press }" style="min-width:500px; width:auto;"/>
				</td>
			</tr>
			<tr>
				<td colspan="2">
					花语：  <input id="publishtime" type="text" name="publishtime" value="${book.publishtime }" style="min-width:500px; width:auto;"/>
				</td>
			</tr>
			<tr>
				<td colspan="2">
					附送：  <input id="printtime" type="text" name="printtime" value="${book.printtime }" style="min-width:500px; width:auto;"/>
				</td>
			</tr>
			<tr>
				<td colspan="2">
					配送：  <input id="paper" type="text" name="paper" value="${book.paper }" style="min-width:500px; width:auto;"/>
				</td>
			</tr>
			<tr>
				<td>
					一级分类：<select name="pid" id="pid" onchange="loadChildren()">
						<option value="">==请选择1级分类==</option>
<c:forEach items="${parents }" var="parent">
  <option value="${parent.cid }" <c:if test="${book.category.parent.cid eq parent.cid }">selected="selected"</c:if>>${parent.cname }</option>
</c:forEach></select>
				</td>
				<td>
					二级分类：<select name="cid" id="cid">
						<option value="">==请选择2级分类==</option>
<c:forEach items="${children }" var="child">
  <option value="${child.cid }" <c:if test="${book.category.cid eq child.cid }">selected="selected"</c:if>>${child.cname }</option>
</c:forEach>
					</select>
				</td>
				<td></td>
			</tr>
			<tr>
				<td colspan="2">
					<input onclick="editForm()" type="button" name="method" id="editBtn" class="btn" style="background:#F87219" value="编　　辑">
					<input onclick="deleteForm()" type="button" name="method" id="delBtn" class="btn" style="background:#F87219" value="删　　除">
				</td>
				<td></td>
			</tr>
		</table>
	</div>
   </form>
  </div>

  </body>
</html>
