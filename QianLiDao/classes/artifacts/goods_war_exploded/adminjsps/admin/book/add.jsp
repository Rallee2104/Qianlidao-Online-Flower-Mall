<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>My JSP 'bookdesc.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<meta http-equiv="content-type" content="text/html;charset=utf-8">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<link rel="stylesheet" type="text/css" href="<c:url value='/adminjsps/admin/css/book/add.css'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/jquery/jquery.datepick.css'/>">
<script type="text/javascript" src="<c:url value='/jquery/jquery-1.5.1.js'/>"></script>
<script type="text/javascript" src="<c:url value='/jquery/jquery.datepick.js'/>"></script>
<script type="text/javascript" src="<c:url value='/jquery/jquery.datepick-zh-CN.js'/>"></script>
<script type="text/javascript">
$(function () {
	$("#btn").addClass("btn1");
	$("#btn").hover(
		function() {
			$("#btn").removeClass("btn1");
			$("#btn").addClass("btn2");
		},
		function() {
			$("#btn").removeClass("btn2");
			$("#btn").addClass("btn1");
		}
	);
	
	$("#btn").click(function() {
		var bname = $("#bname").val();
		var currPrice = $("#currPrice").val();
		var price = $("#price").val();
		var discount = $("#discount").val();
		var author = $("#author").val();
		var press = $("#press").val();
		var pid = $("#pid").val();
		var cid = $("#cid").val();
		var image_w = $("#image_w").val();
		var image_b = $("#image_b").val();
		var publishtime= $("#publishtime").val();
		var printtime= $("#printtime").val();
		
		if(!bname || !currPrice || !price || !discount || !author || !press || !pid || !cid || !image_w || !image_b) {
			alert("商品名、优惠价、商场价、折扣、材料、包装、1级分类、2级分类、大图、小图都不能为空！");
			return false;
		}
		
		if(isNaN(currPrice) || isNaN(price) || isNaN(discount)) {
			alert("优惠价、商场价、折扣必须是合法小数！");
			return false;
		}
		$("#form").submit();
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

</script>
  </head>
  
  <body>
  <div>
   <p style="font-weight: 900; color: red;">${msg }</p>
   <form action="<c:url value='/admin/AdminAddBookServlet'/>" enctype="multipart/form-data" method="post" id="form">
    <div>
	    <ul>
	    	<li>商品名： <input id="bname" type="text" name="bname" value="梦开始的地方" style="width:500px;"/></li>
	    	<li>大图：　 <input id="image_w" type="file" name="image_w"/></li>
	    	<li>小图：　 <input id="image_b" type="file" name="image_b"/></li>
	    	<li>优惠价： <input id="currPrice" type="text" name="currPrice" value="299.0" style="width:50px;"/></li>
	    	<li>市场价： <input id="price" type="text" name="price" value="368.0" style="width:50px;"/>
	    	折扣： <input id="discount" type="text" name="discount" value="7.7" style="width:30px;"/>折</li>
	    </ul>
		<hr style="margin-left: 50px; height: 1px; color: #dcdcdc"/>
		<table>
			<tr>
				<td colspan="2">
					材料： <input type="text" id="author" name="author" value="三朵向日葵，搭配适量绿色雏菊，满天星丰满。" style="min-width:500px; width:auto;"/>
				</td>
			</tr>
			<tr>
				<td colspan="2">
					包装： <input type="text" name="press" id="press" value="森系绿色双色韩素纸精美包装。" style="min-width:500px; width:auto;"/>
				</td>
			</tr>
			<tr>
				<td colspan="2">
					花语： <input type="text" id="publishtime" name="publishtime" value="在心中播种希望，让每个梦想绽放。" style="min-width:500px; width:auto;"/>
				</td>
			</tr>
			<tr>
				<td colspan="2">
					附送： <input type="text" name="printtime" id="printtime" value="免费附送精美贺卡，代写您的祝福。(您下单时可填写留言栏)" style="min-width:500px; width:auto;"/>
				</td>
			</tr>
			<tr>
				<td colspan="2">
					配送： <input type="text" name="paper" id="paper" value="本地区各市县、乡镇、街道（市区内免费配送）" style="min-width:500px; width:auto;"/>
				</td>
			</tr>
			<tr>
				<td>
					一级分类：<select name="pid" id="pid" onchange="loadChildren()">
						<option value="">====请选择1级分类====</option>
<c:forEach items="${parents }" var="parent">
			    		<option value="${parent.cid }">${parent.cname }</option>
</c:forEach></select>
				</td>
				<td>
					二级分类：<select name="cid" id="cid">
						<option value="">====请选择2级分类====</option>
					</select>
				</td>
				<td></td>
			</tr>
			<tr>
				<td>
					<input type="button" id="btn" class="btn" style="background:#F87219" value="商品上架"/>
				</td>
				<td></td>
				<td></td>
			</tr>
		</table>
	</div>
   </form>
  </div>

  </body>
</html>
