<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>小区列表</title>

<!-- Bootstrap Core CSS -->
<link href="<%=basePath%>css/bootstrap.min.css" rel="stylesheet">

<!-- MetisMenu CSS -->
<link href="<%=basePath%>css/metisMenu.min.css" rel="stylesheet">

<!-- DataTables CSS -->
<link href="<%=basePath%>css/dataTables.bootstrap.css" rel="stylesheet">

<!-- Custom CSS -->
<link href="<%=basePath%>css/sb-admin-2.css" rel="stylesheet">

<!-- Custom Fonts -->
<link href="<%=basePath%>css/font-awesome.min.css" rel="stylesheet"
	type="text/css">
<link href="<%=basePath%>css/boot-crm.css" rel="stylesheet"
	type="text/css">
	
<style type="text/css">
	
	#qrcode-wrapper{
		position:absolut;
        left:1250px;
        top:10px;
	}
		
	.cd-top {
	    display: inline-block;
	    height: 40px;
	    width: 40px;
	    position: fixed;
	    bottom: 40px;
	    right: 10px;
	    box-shadow: 0 0 10px rgba(0, 0, 0, 0.05);
	    overflow: hidden;
	    text-indent: 100%;
	    white-space: nowrap;
	    background: rgba(232, 98, 86, 0.8)
	        url(http://www.100sucai.com/img/demo/1335.svg) no-repeat center 50%;
	    visibility: hidden;
	    opacity: 0;
	    -webkit-transition: opacity .3s 0s, visibility 0s .3s;
	    -moz-transition: opacity .3s 0s, visibility 0s .3s;
	    transition: opacity .3s 0s, visibility 0s .3s;
	}

	.cd-top.cd-is-visible,.cd-top.cd-fade-out,.no-touch .cd-top:hover {
	    -webkit-transition: opacity .3s 0s, visibility 0s 0s;
	    -moz-transition: opacity .3s 0s, visibility 0s 0s;
	    transition: opacity .3s 0s, visibility 0s 0s;
	}

	.cd-top.cd-is-visible {
	    visibility: visible;
	    opacity: 1;
	}

	.cd-top.cd-fade-out {
	    opacity: .5;
	}

	.no-touch .cd-top:hover {
	    background-color:red;
	    opacity: 1;
	}

</style>

</head>
<body>
<div id="wrapper">
	<div class="panel-heading"><h2>小区信息列表</h2>
		<div id="xinzeng" class="btn btn-primary" data-toggle="modal" data-target="#commInsert" onclick="editcomm(${row.xq_id})">添加小区信息</div>
		<div id="xinzeng" class="btn btn-primary" onclick="window.open('http://localhost:8081/cunity/index2.html')">回到主页</div>
		<div id="qrcode-wrapper">
			<div id="qrcodeCanvas"></div>
			了解苏州小区
		</div>
	</div>
	<div class="panel panel-default">
		<div class="panel-body">
			<form class="form-inline" action="${pageContext.request.contextPath }/unity/list.action" method="get">
				<!--  <div class="form-group">
					<label for="xqmc">查询小区:</label>
					<input type="text" class="form-control" id="xqmc" value="${cunityName}" name="cunityName"></input>
				</div>
				<button type="submit" class="btn btn-primary">查询</button>-->
			</form>
		</div>
	</div>
	<div class="row">
		<div class="col-lg-12">
			<div class="panel panel-default">
				<!-- /.panel-heading -->
						<table class="table table-bordered table-hover">
							<thead>
								<tr>
									<th>ID</th>
									<th>小区名称</th>
									<th>小区地址</th>
									<th>小区经度</th>
									<th>小区纬度</th>
									<th>医院得分</th>
									<th>交通得分</th>
									<th>学校得分</th>
									<th>商场得分</th>
									<th>综合得分</th>
									<th>操作</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${page.rows}" var="row">
									<tr>
										<td>${row.xq_id}</td>
										<td>${row.xq_mc}</td>
										<td>${row.xq_dz}</td>
										<td>${row.xq_long}</td>
										<td>${row.xq_lat}</td>
										<td>${row.hospital_s}</td>
										<td>${row.subway_s}</td>
										<td>${row.school_s}</td>
										<td>${row.mart_s}</td>
										<td>${row.total_s}</td>
										<td>
											<a href="#" class="btn btn-primary btn-xs" data-toggle="modal" data-target="#commUpdate" onclick="editcomm(${row.xq_id})">修改</a>
											<a href="#" class="btn btn-danger btn-xs" onclick="commDelete(${row.xq_id})">删除</a>
										</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
				<div class="col-md-12 text-right">
					<itcast:page url="${pageContext.request.contextPath }/unity/list.action"/>
				</div>
				<!-- /.panel-body -->
			</div>
			<!-- /.panel -->
		</div>
	<!--/.col-lg-12 -->
</div>

<!--  <div style="height: 0px;"></div>-->
<div class="cd-top">Top</div>

<!-- 修改小区信息对话框-->
<div class="modal fade" id="commUpdate" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<!-- 对话框头部信息 -->
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="myModalLabel">修改小区信息</h4>
			</div>
			<!-- 对话框字段 -->
			<div class="modal-body">
				<form class="form-horizontal" id="edit_unity_form">
				<input type="hidden" id="edit_xqid" name="xq_id"/>
					<div class="form-group">
						<label for="edit_xqmc" class="col-sm-2 control-label">小区名称</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" id="edit_xqmc" placeholder="小区名称" name="xq_mc">
						</div>
					</div>
					<div class="form-group">
						<label for="edit_xqdz" class="col-sm-2 control-label">小区地址</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" id="edit_xqdz" placeholder="小区地址" name="xq_dz">
						</div>
					</div>
					<div class="form-group">
						<label for="edit_xqlong" class="col-sm-2 control-label">小区经度</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" id="edit_xqlong" placeholder="小区经度" name="xq_long">
						</div>
					</div>
					<div class="form-group">
						<label for="edit_xqlat" class="col-sm-2 control-label">小区纬度</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" id="edit_xqlat" placeholder="小区纬度" name="xq_lat">
						</div>
					</div>
					<div class="form-group">
						<label for="edit_hospitals" class="col-sm-2 control-label">医院得分</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" id="edit_hospitals" placeholder="医院得分" name="hospital_s">
						</div>
					</div>
					<div class="form-group">
						<label for="edit_subways" class="col-sm-2 control-label">交通得分</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" id="edit_subways" placeholder="交通得分" name="subway_s">
						</div>
					</div>
					<div class="form-group">
						<label for="edit_schools" class="col-sm-2 control-label">学校得分</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" id="edit_schools" placeholder="学校得分" name="school_s">
						</div>
					</div>
					<div class="form-group">
						<label for="edit_marts" class="col-sm-2 control-label">商场得分</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" id="edit_marts" placeholder="商场得分" name="mart_s">
						</div>
					</div>
					<div class="form-group">
						<label for="edit_totals" class="col-sm-2 control-label">综合得分</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" id="edit_totals" placeholder="综合得分" name="total_s">
						</div>
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				<button type="button" class="btn btn-primary" onclick="updateCommunityById()">确定修改小区信息</button>
			</div>
		</div>
	</div>
</div> 
<!-- /#wrapper -->

<!-- 添加小区信息对话框 -->
<div class="modal fade" id="commInsert" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<!-- 对话框头部信息 -->
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="myModalLabel">增加小区信息</h4>
			</div>
			<!-- 对话框字段 -->
			<div class="modal-body">
				<form class="form-horizontal" id="edit_comm_zeng">
				<input type="hidden" id="edit_xqid" name="xq_id"/>
					<div class="form-group">
						<label for="edit_xqmc" class="col-sm-2 control-label">小区名称</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" id="edit_xq_mc" placeholder="小区名称" name="xq_mc">
						</div>
					</div>
					<div class="form-group">
						<label for="edit_xqdz" class="col-sm-2 control-label">小区地址</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" id="edit_xq_dz" placeholder="小区地址" name="xq_dz">
						</div>
					</div>
					<div class="form-group">
						<label for="edit_xqlong" class="col-sm-2 control-label">小区经度</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" id="edit_xq_long" placeholder="小区经度" name="xq_long">
						</div>
					</div>
					<div class="form-group">
						<label for="edit_xqlat" class="col-sm-2 control-label">小区纬度</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" id="edit_xq_lat" placeholder="小区纬度" name="xq_lat">
						</div>
					</div>
					<div class="form-group">
						<label for="edit_hospitals" class="col-sm-2 control-label">医院得分</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" id="edit_hospital_s" placeholder="医院得分" name="hospital_s">
						</div>
					</div>
					<div class="form-group">
						<label for="edit_subways" class="col-sm-2 control-label">交通得分</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" id="edit_subway_s" placeholder="交通得分" name="subway_s">
						</div>
					</div>
					<div class="form-group">
						<label for="edit_schools" class="col-sm-2 control-label">学校得分</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" id="edit_school_s" placeholder="学校得分" name="school_s">
						</div>
					</div>
					<div class="form-group">
						<label for="edit_marts" class="col-sm-2 control-label">商场得分</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" id="edit_mart_s" placeholder="商场得分" name="mart_s">
						</div>
					</div>
					<div class="form-group">
						<label for="edit_totals" class="col-sm-2 control-label">综合得分</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" id="edit_total_s" placeholder="综合得分" name="total_s">
						</div>
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				<button type="button" class="btn btn-primary" onclick="insertcommById()">确定增加小区信息</button>
			</div>
		</div>
	</div>
</div>
<!-- /#wrapper -->

<!-- jQuery -->
<script src="<%=basePath%>js/jquery.min.js"></script>
<script src="<%=basePath%>js/jquery-1.12.4.js"></script>

<!-- QRCode -->
<script src="<%=basePath%>js/jquery-1.11.1.js"></script>
<script src="<%=basePath%>js/jquery.qrcode.js"></script>
<script src="<%=basePath%>js/qrcode.js"></script> 
<script src="<%=basePath%>js/utf.js"></script>

<!-- Bootstrap Core JavaScript -->
<script src="<%=basePath%>js/bootstrap.min.js"></script>

<!-- Metis Menu Plugin JavaScript -->
<script src="<%=basePath%>js/metisMenu.min.js"></script>

<!-- DataTables JavaScript -->
<script src="<%=basePath%>js/jquery.dataTables.min.js"></script>
<script src="<%=basePath%>js/dataTables.bootstrap.min.js"></script>

<!-- Custom Theme JavaScript -->
<script src="<%=basePath%>js/sb-admin-2.js"></script>

<script type="text/javascript">
	
		//查询表
		function editcomm(id) {
			$.ajax({
				type:"get",
				url:"<%=basePath%>unity/detail.action",
				data:{"id":id},
				success:function(data) {
					$("#edit_xqid").val(data.xq_id);
					$("#edit_xqmc").val(data.xq_mc);
					$("#edit_xqdz").val(data.xq_dz)
					$("#edit_xqlong").val(data.xq_long);
					$("#edit_xqlat").val(data.xq_lat);
					$("#edit_hospitals").val(data.hospital_s);
					$("#edit_subways").val(data.subway_s);
					$("#edit_schools").val(data.school_s);
					$("#edit_marts").val(data.mart_s);
					$("#edit_totals").val(data.total_s);
				}
			});
		}
		
		//增加
		function insertcommById(){
			$.post("<%=basePath%>unity/insert.action",$("#edit_comm_zeng").serialize(),function(data){
				alert("增加小区信息成功");
				window.location.reload();
			});
		}
		
		//修改
		function updateCommunityById(){
			$.post("<%=basePath%>unity/update.action",$("#edit_unity_form").serialize(),function(data){
				alert("修改小区信息成功");
				window.location.reload();
			});
		}
		
		//删除
		function commDelete(id) {
			if(confirm('确实要删除该小区信息吗?')) {
				$.post("<%=basePath%>unity/delete.action",{"id":id},function(data){
					alert("小区信息列表更新成功！");
					window.location.reload();
				});
			}
		}
		
		//回顶部
		jQuery(document).ready(function($){
	        var offset = 300,
	        offset_opacity = 1200,
	        scroll_top_duration = 700,
	        $back_to_top = $('.cd-top');
	    $(window).scroll(function(){
	        ( $(this).scrollTop() > offset ) ? $back_to_top.addClass('cd-is-visible') : $back_to_top.removeClass('cd-is-visible cd-fade-out');
	        if( $(this).scrollTop() > offset_opacity ) { 
	            $back_to_top.addClass('cd-fade-out');
	        }
	    });
	    $back_to_top.on('click', function(event){
	        event.preventDefault();
	        $('body,html').animate({
	            scrollTop: 0 ,
	            }, scroll_top_duration
	        );
	    });

	});
		
		//二维码
		//第一个
		jQuery('#qrcodeCanvas').qrcode({
	        text: "http://www.youabc.cn/ditu/suzhou.html",
	        width: "80",               //二维码的宽度
	        height: "80",              //二维码的高度
	        background: "#ffffff",      //二维码的后景色
	        foreground: "#000000",      //二维码的前景色
	        src: "<%=basePath%>image/suzhou.jpg" 	//二维码中间的图片
		});
	

</script>

</body>
</html>