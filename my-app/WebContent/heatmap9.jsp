<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="org.json.*"%>

 
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
 





<%
String driver = "com.mysql.jdbc.Driver";
// URL指向要访问的数据库名test1
String url = "jdbc:mysql://127.0.0.1:3306/by";
// MySQL配置时的用户名
String user = "root";
// Java连接MySQL配置时的密码
String password = "123456";
	String lsxiaoqu1 = "";
try {
Class.forName(driver);
Connection conn = DriverManager.getConnection(url, user, password);
Statement statement = conn.createStatement();
String sql = "select xq_id,xq_mc,xq_dz,xq_long,xq_lat,hospital_s,subway_s,school_s,mart_s,total_s from xiaoqunew ";
ResultSet rs = statement.executeQuery(sql);
JSONObject json = new JSONObject();
JSONArray jsonMembers = new JSONArray();
while (rs.next()) {
				JSONObject xiaoqu1 = new JSONObject();
				xiaoqu1.put("xq_id", rs.getString(1));
				xiaoqu1.put("xq_mc", rs.getString(2));
				xiaoqu1.put("xq_dz", rs.getString(3));  
				xiaoqu1.put("xq_long", rs.getString(4));
				xiaoqu1.put("xq_lat", rs.getString(5));
				xiaoqu1.put("hospital_s", rs.getString(6));
				xiaoqu1.put("school_s", rs.getString(7));
				xiaoqu1.put("subway_s", rs.getString(8));
				xiaoqu1.put("mart_s", rs.getString(9));
				xiaoqu1.put("total_s", rs.getString(10));
				jsonMembers.put(xiaoqu1);
			}
			json.put("xiaoqunew", jsonMembers);
			lsxiaoqu1 =jsonMembers.toString();
rs.close();
conn.close();
} catch (ClassNotFoundException e) {
System.out.println("Sorry,can`t find the Driver!");
e.printStackTrace();
} catch (SQLException e) {
e.printStackTrace();
} catch (Exception e) {
e.printStackTrace();
}


%>

<!DOCTYPE html>
<html>
<head>
	<link href="css/bootstrap.css" type="text/css" rel="stylesheet" media="all">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
    <script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=uQQtqikbvFwtFdK9wGKn2RkEUkYkA552"></script>
    <script type="text/javascript" src="http://api.map.baidu.com/library/Heatmap/2.0/src/Heatmap_min.js"></script>
	<script type="application/x-javascript"> addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false); function hideURLbar(){ window.scrollTo(0,1); } </script>

	<title>苏州园区小区生活适宜性分析</title>

	<link href="css/style.css" type="text/css" rel="stylesheet" media="all">
    <style type="text/css">
	
		ul,li{list-style: none;margin:0;padding:0;float:left;}
		html{height:100%}
		body{height:100%;margin:0px;padding:0px;font-family:"微软雅黑";}
		#menu {padding: 5px 0px 0px 0px;position:absolute;width: 100%;height: 5%;top: 0%;background:#FFFFFF;color:#E9967A}
		#container{top:10%;position:absolute;height:775px;width:100%;}		
		#content{width:160px;height:85%;background-color: #FFFFFF;position:absolute;top:15.9%;left:-160px;font-size:16px}
        #tag{width:30px;height:90px;background-color: #FFCC00;text-align: center;position:absolute;left:0px;top:45%;}
		.baidu-maps label {max-width: none;}

    </style>	
</head>
<body>
	<div id="container" class  ="baidu-maps"></div>
	<!--header-->
	<div class="header">
		<div class="container">
			<div class="header-info navbar-left wow fadeInLeft animated" data-wow-delay=".5s" style="visibility: visible; -webkit-animation-delay: .5s;">
				<p><span class="glyphicon glyphicon-earphone" aria-hidden="true"></span>联系电话：18866668686</p>
			</div>				
			<form class="navbar-form navbar-right wow fadeInRight animated" data-wow-delay=".5s" style="visibility: visible; -webkit-animation-delay: .5s;">
				<div class="form-group">
					<input type="text" class="form-control" placeholder="请输入地点" id="suggestId">
					<button type="button" class="btn btn-default" aria-label="Left Align">
						<span class="glyphicon glyphicon-search" aria-hidden="true"></span>
					</button>
					
				</div>
			</form>	
		</div>	
	</div>
	
	<div class="top-nav">
		<nav class="navbar navbar-default">
			<div class="container">
				<div class="navbar-header navbar-left">
					<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
						<span class="sr-only">Toggle navigation</span>
						<span class="icon-bar"></span>
						<span class="icon-bar"></span>
						<span class="icon-bar"></span>
					</button>
					<h1><a class="navbar-brand wow bounceIn animated" data-wow-delay=".5s" style="visibility: visible; -webkit-animation-delay: .5s;">择房助手</a></h1>
				</div>
				<!-- Collect the nav links, forms, and other content for toggling -->
				<div class="collapse navbar-collapse navbar-right" id="bs-example-navbar-collapse-1">
					<ul class="nav navbar-nav navbar-left">
				
						<li class="hvr-bounce-to-bottom"><a onclick="openHeatmap()">显示热力图</a></li>
						<li class="hvr-bounce-to-bottom"><a onclick="closeHeatmap()">关闭热力图</a></li>
						<li class="hvr-bounce-to-bottom"><a onClick="map_tag()">小区得分查询</a></li>
						<li class="hvr-bounce-to-bottom"><a onClick="javascript:history.go(0);">关闭查询</a></li>
						<li class="hvr-bounce-to-bottom"><a href="index2.html">回到主页</a></li>
					</ul>	
					<div class="clearfix"> </div>
				</div>
			</div>	
		</nav>		
	</div>	
	
</body>
</html>
<script type="text/javascript">
    var map = new BMap.Map("container");          // 创建地图实例
    var point = new BMap.Point(120.720685, 31.324685);
    map.centerAndZoom(point, 13);             // 初始化地图，设置中心点坐标和地图级别
    map.enableScrollWheelZoom(); // 允许滚轮缩放
	
	var ls_xiaoqu = '<%=lsxiaoqu1%>';
	//创建和初始化地图
    
    function map_tag() {
    	map.clearOverlays();
        var objRecords = eval("(" + ls_xiaoqu + ")");//后台得到的数据包含经纬度，json格式的
        var points = new Array();//存放标注点经纬信息的数组
        for ( var i = 0; i < objRecords.length; i++) {
            var json = objRecords[i];
            var p0 = json.xq_long;
            var p1 = json.xq_lat;
            var point = new BMap.Point(p0,p1);//循环生成新的地图点
            var marker = new BMap.Marker(point);//按照地图点坐标生成标记
            var iw = createInfoWindow(i);//创建信息窗口对象
            var label = new window.BMap.Label(json.xq_mc, { offset: new window.BMap.Size(20, -10) },);
            marker.setLabel(label);//显示marker的title
            points.push(marker);
            map.addOverlay(points[i]);//把标记的点添加到地图上
          //添加点击事件
            (function(){
    			var _json = json;
    			var _iw = createInfoWindow(_json);
    			var _marker = marker;
    			_marker.addEventListener("mouseover",function(){
    				this.openInfoWindow(_iw);
    			   });
    		})() 
        }         
    }
    
  //创建InfoWindow
    function createInfoWindow(json){
    	var opts1 = {title : '<span style="font-size:20px;color:#0A8021">小区信息</span>'};
        var iw = new BMap.InfoWindow("<div style='line-height:1.8em;font-size:12px;'><b>小区名称: </b>"+ json.xq_mc+ "</br><b>小区地址:</b>"+json.xq_dz+"</br><b>医院得分: </b>"+json.hospital_s+"</br><b>交通得分: </b>"+json.subway_s+"</br><b>商场得分: </b>"+json.mart_s+"</br><b>学校得分: </b>"+json.school_s+"</br><b>综合得分: </b>"+json.total_s+"</br></a></div>", opts1);
        return iw;
    }
 
 //搜索功能
	 function G(id) {
		return document.getElementById(id);
	}


	var ac = new BMap.Autocomplete(    //建立一个自动完成的对象
		{"input" : "suggestId"
		,"location" : map
	});

	var myValue;
	ac.addEventListener("onconfirm", function(e) {    //鼠标点击下拉列表后的事件
	var _value = e.item.value;
		myValue = _value.province +  _value.city +  _value.district +  _value.street +  _value.business;
		G("searchResultPanel").innerHTML ="onconfirm<br />index = " + e.item.index + "<br />myValue = " + myValue;
		setPlace();
	});

	function setPlace(){
		function myFun(){
			var pp = local.getResults().getPoi(0).point;    //获取第一个智能搜索的结果
			map.centerAndZoom(pp, 18);
			//map.addOverlay(new BMap.Marker(pp));    //添加标注
		}
		var local = new BMap.LocalSearch(map, { //智能搜索
		  onSearchComplete: myFun
		});
		local.search(myValue);
	}	 
 
 
 
 //侧边菜单
 function demo1(){
         var content=document.getElementById("content");
         var tag=document.getElementById("tag");
         var ispeed=5;
         timer=null;
         time2=null;
//右移		 
         tag.onmouseover=content.onmouseover=function (ev) {
             clearInterval(timer);
             clearInterval(time2);
          timer=setInterval(function(){
			  
              if(content.offsetLeft>=0){
                  clearInterval(timer);
              }else{
                  content.style.left=content.offsetLeft+ispeed+"px";
                  tag.style.left=tag.offsetLeft+ispeed+"px";
              }
          },30);
         }
//左移回退
         tag.onmouseout=content.onmouseout=function (ev) {
             clearInterval(time2);
             clearInterval(timer);
             time2=setInterval(function(){
              
                 if(tag.offsetLeft<=0){
                     clearInterval(time2);
                 }else{
                    content.style.left=content.offsetLeft-ispeed+"px";
                    tag.style.left=tag.offsetLeft-ispeed+"px";
                 }
             },30);
         }
     }

	
 //热力图 
 
    var points =[
{"lng":120.720795 ,"lat":31.379875 ,"count":60.20 },{"lng":120.772038 ,"lat":31.340324 ,"count":65.24 },{"lng":120.772038 ,"lat":31.340324 ,"count":75.04 },{"lng":120.661313 ,"lat":31.285105 ,"count":60.20 },{"lng":120.760676 ,"lat":31.336604 ,"count":65.24 },{"lng":120.665773 ,"lat":31.354763 ,"count":35.04 },{"lng":120.678806 ,"lat":31.286906 ,"count":70.08 },{"lng":120.760208 ,"lat":31.316209 ,"count":85.16 },{"lng":120.685658 ,"lat":31.322489 ,"count":75.40 },{"lng":120.771720 ,"lat":31.341386 ,"count":65.24 },{"lng":120.763254 ,"lat":31.373244 ,"count":30.12 },{"lng":120.761130 ,"lat":31.318895 ,"count":75.04 },{"lng":120.761103 ,"lat":31.376882 ,"count":35.04 },{"lng":120.756470 ,"lat":31.303180 ,"count":60.24 },{"lng":120.769942 ,"lat":31.314016 ,"count":75.04 },{"lng":120.772518 ,"lat":31.307579 ,"count":65.16 },{"lng":120.771292 ,"lat":31.339111 ,"count":65.24 },{"lng":120.727954 ,"lat":31.320610 ,"count":75.36 },{"lng":120.726475 ,"lat":31.268255 ,"count":55.12 },{"lng":120.844325 ,"lat":31.296234 ,"count":60.20 },{"lng":120.729998 ,"lat":31.270796 ,"count":55.12 },{"lng":120.732830 ,"lat":31.261172 ,"count":75.12 },{"lng":120.728299 ,"lat":31.357577 ,"count":55.32 },{"lng":120.737285 ,"lat":31.337078 ,"count":84.92 },{"lng":120.720341 ,"lat":31.367841 ,"count":65.40 },{"lng":120.752761 ,"lat":31.339468 ,"count":65.24 },{"lng":120.729458 ,"lat":31.336326 ,"count":84.92 },{"lng":120.742501 ,"lat":31.340380 ,"count":69.88 },
{"lng":120.755541 ,"lat":31.279211 ,"count":80.28 },{"lng":120.702709 ,"lat":31.335038 ,"count":65.24 },{"lng":120.716438 ,"lat":31.327501 ,"count":75.40 },{"lng":120.720170 ,"lat":31.383309 ,"count":60.20 },{"lng":120.702720 ,"lat":31.336027 ,"count":70.16 },{"lng":120.687084 ,"lat":31.300856 ,"count":55.04 },{"lng":120.658631 ,"lat":31.312623 ,"count":75.36 },{"lng":120.833187 ,"lat":31.337302 ,"count":30.12 },{"lng":120.678937 ,"lat":31.322735 ,"count":75.40 },{"lng":120.719626 ,"lat":31.369086 ,"count":65.40 },{"lng":120.687550 ,"lat":31.309703 ,"count":65.20 },{"lng":120.740794 ,"lat":31.304499 ,"count":70.36 },{"lng":120.663088 ,"lat":31.296567 ,"count":65.16 },{"lng":120.730589 ,"lat":31.270560 ,"count":55.12 },{"lng":120.728123 ,"lat":31.366145 ,"count":55.28 },{"lng":120.745551 ,"lat":31.377815 ,"count":45.16 },{"lng":120.678358 ,"lat":31.288890 ,"count":65.12 },{"lng":120.685125 ,"lat":31.313415 ,"count":65.24 },{"lng":120.724451 ,"lat":31.330919 ,"count":85.24 },{"lng":120.670397 ,"lat":31.289683 ,"count":70.08 },{"lng":120.826586 ,"lat":31.315628 ,"count":55.28 },{"lng":120.730464 ,"lat":31.296767 ,"count":60.24 },{"lng":120.663088 ,"lat":31.296567 ,"count":70.08 },{"lng":120.742620 ,"lat":31.248364 ,"count":80.24 },{"lng":120.740996 ,"lat":31.310597 ,"count":70.40 },{"lng":120.832619 ,"lat":31.309330 ,"count":75.24 },{"lng":120.723231 ,"lat":31.323456 ,"count":75.36 },{"lng":120.742872 ,"lat":31.379858 ,"count":55.00 },
{"lng":120.690210 ,"lat":31.351579 ,"count":60.24 },{"lng":120.750601 ,"lat":31.255664 ,"count":80.24 },{"lng":120.746449 ,"lat":31.254611 ,"count":75.32 },{"lng":120.719047 ,"lat":31.370430 ,"count":65.40 },{"lng":120.747526 ,"lat":31.251062 ,"count":75.32 },{"lng":120.730464 ,"lat":31.296767 ,"count":60.24 },{"lng":120.733528 ,"lat":31.267139 ,"count":65.00 },{"lng":120.730464 ,"lat":31.296227 ,"count":60.24 },{"lng":120.748549 ,"lat":31.324069 ,"count":75.08 },{"lng":120.688537 ,"lat":31.298346 ,"count":55.04 },{"lng":120.760001 ,"lat":31.339855 ,"count":65.24 },{"lng":120.668488 ,"lat":31.323639 ,"count":70.44 },{"lng":120.659939 ,"lat":31.307536 ,"count":65.48 },{"lng":120.670680 ,"lat":31.324066 ,"count":70.16 },{"lng":120.672119 ,"lat":31.325088 ,"count":75.36 },{"lng":120.656844 ,"lat":31.318764 ,"count":70.16 },{"lng":120.675262 ,"lat":31.323915 ,"count":75.40 },{"lng":120.734592 ,"lat":31.296436 ,"count":50.40 },{"lng":120.737870 ,"lat":31.250599 ,"count":80.28 },{"lng":120.742985 ,"lat":31.295035 ,"count":55.32 },{"lng":120.738255 ,"lat":31.295160 ,"count":55.32 },{"lng":120.742341 ,"lat":31.292008 ,"count":60.28 },{"lng":120.738032 ,"lat":31.247362 ,"count":70.40 },{"lng":120.748218 ,"lat":31.294647 ,"count":60.24 },{"lng":120.737110 ,"lat":31.289307 ,"count":60.28 },{"lng":120.742488 ,"lat":31.252864 ,"count":75.32 },{"lng":120.732342 ,"lat":31.292290 ,"count":55.36 },{"lng":120.721410 ,"lat":31.379001 ,"count":60.20 },
{"lng":120.715027 ,"lat":31.299228 ,"count":55.04 },{"lng":120.756533 ,"lat":31.329319 ,"count":80.28 },{"lng":120.753065 ,"lat":31.319524 ,"count":80.28 },{"lng":120.757049 ,"lat":31.318881 ,"count":80.24 },{"lng":120.722458 ,"lat":31.302807 ,"count":60.24 },{"lng":120.664680 ,"lat":31.338648 ,"count":55.08 },{"lng":120.756331 ,"lat":31.321810 ,"count":75.08 },{"lng":120.752922 ,"lat":31.317224 ,"count":80.24 },{"lng":120.767827 ,"lat":31.342096 ,"count":65.24 },{"lng":120.662344 ,"lat":31.297611 ,"count":65.16 },{"lng":120.720170 ,"lat":31.383309 ,"count":60.20 },{"lng":120.746351 ,"lat":31.304076 ,"count":60.52 },{"lng":120.703189 ,"lat":31.333159 ,"count":70.16 },{"lng":120.755868 ,"lat":31.376373 ,"count":45.16 },{"lng":120.738051 ,"lat":31.377399 ,"count":55.28 },{"lng":120.752932 ,"lat":31.324877 ,"count":70.16 },{"lng":120.756463 ,"lat":31.339876 ,"count":65.24 },{"lng":120.682536 ,"lat":31.318365 ,"count":75.36 },{"lng":120.760379 ,"lat":31.340710 ,"count":65.24 },{"lng":120.752868 ,"lat":31.328206 ,"count":75.12 },{"lng":120.766540 ,"lat":31.271131 ,"count":65.24 },{"lng":120.768133 ,"lat":31.337822 ,"count":65.24 },{"lng":120.740794 ,"lat":31.304499 ,"count":70.36 },{"lng":120.691820 ,"lat":31.345163 ,"count":60.24 },{"lng":120.743802 ,"lat":31.313659 ,"count":65.20 },{"lng":120.810553 ,"lat":31.330198 ,"count":30.12 },{"lng":120.684717 ,"lat":31.318538 ,"count":70.44 },{"lng":120.678185 ,"lat":31.328013 ,"count":70.44 },
{"lng":120.699159 ,"lat":31.354421 ,"count":70.36 },{"lng":120.690787 ,"lat":31.349204 ,"count":60.24 },{"lng":120.770945 ,"lat":31.313554 ,"count":75.04 },{"lng":120.729307 ,"lat":31.313277 ,"count":60.28 },{"lng":120.756784 ,"lat":31.327698 ,"count":80.28 },{"lng":120.661580 ,"lat":31.344569 ,"count":55.04 },{"lng":120.809091 ,"lat":31.368330 ,"count":44.88 },{"lng":120.704484 ,"lat":31.349428 ,"count":75.32 },{"lng":120.750794 ,"lat":31.247476 ,"count":80.24 },{"lng":120.691167 ,"lat":31.347697 ,"count":55.32 },{"lng":120.731927 ,"lat":31.290249 ,"count":50.40 },{"lng":120.800490 ,"lat":31.365160 ,"count":54.72 },{"lng":120.714650 ,"lat":31.333742 ,"count":80.28 },{"lng":120.721598 ,"lat":31.369348 ,"count":65.40 },{"lng":120.657460 ,"lat":31.313012 ,"count":75.36 },{"lng":120.795126 ,"lat":31.377969 ,"count":54.72 },{"lng":120.728523 ,"lat":31.326877 ,"count":80.32 },{"lng":120.727372 ,"lat":31.342032 ,"count":45.20 },{"lng":120.725385 ,"lat":31.323554 ,"count":75.36 },{"lng":120.751048 ,"lat":31.252604 ,"count":75.32 },{"lng":120.744312 ,"lat":31.311505 ,"count":70.40 },{"lng":120.662486 ,"lat":31.283812 ,"count":65.40 },{"lng":120.673439 ,"lat":31.295440 ,"count":79.92 },{"lng":120.660719 ,"lat":31.348143 ,"count":44.92 },{"lng":120.658897 ,"lat":31.305807 ,"count":70.40 },{"lng":120.771022 ,"lat":31.344754 ,"count":50.44 },{"lng":120.656105 ,"lat":31.332600 ,"count":65.20 },{"lng":120.798201 ,"lat":31.347942 ,"count":39.96 },
{"lng":120.742414 ,"lat":31.372678 ,"count":50.08 },{"lng":120.660811 ,"lat":31.310440 ,"count":70.44 },{"lng":120.711145 ,"lat":31.336814 ,"count":75.08 },{"lng":120.832050 ,"lat":31.312040 ,"count":60.20 },{"lng":120.700091 ,"lat":31.350148 ,"count":75.28 },{"lng":120.796181 ,"lat":31.362697 ,"count":54.72 },{"lng":120.829086 ,"lat":31.308399 ,"count":65.12 },{"lng":120.698754 ,"lat":31.346110 ,"count":75.32 },{"lng":120.720820 ,"lat":31.375088 ,"count":60.48 },{"lng":120.769863 ,"lat":31.308862 ,"count":75.04 },{"lng":120.699204 ,"lat":31.345186 ,"count":75.32 },{"lng":120.792614 ,"lat":31.372903 ,"count":49.80 },{"lng":120.734620 ,"lat":31.323061 ,"count":80.28 },{"lng":120.738464 ,"lat":31.317338 ,"count":65.20 },{"lng":120.685125 ,"lat":31.313415 ,"count":70.16 },{"lng":120.759317 ,"lat":31.339910 ,"count":55.40 },{"lng":120.667732 ,"lat":31.326930 ,"count":70.44 },{"lng":120.724440 ,"lat":31.316082 ,"count":65.24 },{"lng":120.830461 ,"lat":31.301148 ,"count":70.32 },{"lng":120.717318 ,"lat":31.333843 ,"count":80.28 },{"lng":120.654330 ,"lat":31.333746 ,"count":55.08 },{"lng":120.659715 ,"lat":31.305328 ,"count":70.40 },{"lng":120.687837 ,"lat":31.318132 ,"count":70.44 },{"lng":120.673454 ,"lat":31.297051 ,"count":64.88 },{"lng":120.729603 ,"lat":31.290093 ,"count":55.32 },{"lng":120.663860 ,"lat":31.294041 ,"count":65.16 },{"lng":120.694280 ,"lat":31.352370 ,"count":60.24 },{"lng":120.676728 ,"lat":31.284676 ,"count":65.16 },
{"lng":120.738693 ,"lat":31.323305 ,"count":80.00 },{"lng":120.670539 ,"lat":31.290869 ,"count":70.08 },{"lng":120.745279 ,"lat":31.300326 ,"count":65.44 },{"lng":120.669567 ,"lat":31.295311 ,"count":70.08 },{"lng":120.661687 ,"lat":31.309474 ,"count":70.44 },{"lng":120.826266 ,"lat":31.307904 ,"count":60.20 },{"lng":120.704484 ,"lat":31.349428 ,"count":75.32 },{"lng":120.704434 ,"lat":31.352397 ,"count":65.44 },{"lng":120.834795 ,"lat":31.301105 ,"count":75.24 },{"lng":120.833760 ,"lat":31.309994 ,"count":75.24 },{"lng":120.672992 ,"lat":31.299296 ,"count":75.04 },{"lng":120.724605 ,"lat":31.380106 ,"count":65.12 },{"lng":120.662344 ,"lat":31.297611 ,"count":75.04 },{"lng":120.662344 ,"lat":31.297611 ,"count":70.08 },{"lng":120.839272 ,"lat":31.300138 ,"count":75.24 },{"lng":120.783902 ,"lat":31.361668 ,"count":44.88 },{"lng":120.661491 ,"lat":31.346461 ,"count":50.12 },{"lng":120.667706 ,"lat":31.297474 ,"count":70.08 },{"lng":120.699471 ,"lat":31.333236 ,"count":70.16 },{"lng":120.686012 ,"lat":31.299440 ,"count":55.04 },{"lng":120.659394 ,"lat":31.314669 ,"count":75.36 },{"lng":120.675718 ,"lat":31.318000 ,"count":85.24 },{"lng":120.677526 ,"lat":31.315421 ,"count":75.08 },{"lng":120.782415 ,"lat":31.369294 ,"count":44.88 },{"lng":120.667656 ,"lat":31.348736 ,"count":55.04 },{"lng":120.670808 ,"lat":31.327661 ,"count":75.36 },{"lng":120.789349 ,"lat":31.368035 ,"count":54.72 },{"lng":120.837825 ,"lat":31.310977 ,"count":70.32 },
{"lng":120.706900 ,"lat":31.348546 ,"count":70.40 },{"lng":120.683266 ,"lat":31.313432 ,"count":70.16 },{"lng":120.666996 ,"lat":31.297971 ,"count":70.12 },{"lng":120.663499 ,"lat":31.298327 ,"count":75.04 },{"lng":120.696741 ,"lat":31.347624 ,"count":65.16 },{"lng":120.663541 ,"lat":31.302758 ,"count":75.32 },{"lng":120.790276 ,"lat":31.363344 ,"count":49.80 },{"lng":120.705454 ,"lat":31.352999 ,"count":65.44 },{"lng":120.698128 ,"lat":31.348793 ,"count":65.16 },{"lng":120.698128 ,"lat":31.348793 ,"count":65.16 },{"lng":120.721791 ,"lat":31.364997 ,"count":60.48 },{"lng":120.654330 ,"lat":31.333746 ,"count":55.08 },{"lng":120.832082 ,"lat":31.310612 ,"count":65.12 },{"lng":120.688678 ,"lat":31.330541 ,"count":65.24 },{"lng":120.668516 ,"lat":31.346632 ,"count":55.04 },{"lng":120.748158 ,"lat":31.302164 ,"count":65.44 },{"lng":120.668166 ,"lat":31.292241 ,"count":70.08 },{"lng":120.661778 ,"lat":31.318623 ,"count":80.28 },{"lng":120.750558 ,"lat":31.284561 ,"count":70.44 },{"lng":120.732528 ,"lat":31.306222 ,"count":60.24 },{"lng":120.678463 ,"lat":31.312857 ,"count":70.16 },{"lng":120.670407 ,"lat":31.291906 ,"count":79.92 },{"lng":120.762176 ,"lat":31.256014 ,"count":80.24 },{"lng":120.659117 ,"lat":31.324409 ,"count":70.16 },{"lng":120.658539 ,"lat":31.320501 ,"count":70.16 },{"lng":120.733966 ,"lat":31.357928 ,"count":45.20 },{"lng":120.697113 ,"lat":31.353614 ,"count":65.16 },{"lng":120.655768 ,"lat":31.326448 ,"count":65.24 },
{"lng":120.676607 ,"lat":31.320336 ,"count":80.32 },{"lng":120.719179 ,"lat":31.333418 ,"count":90.16 },{"lng":120.677506 ,"lat":31.292759 ,"count":79.92 },{"lng":120.679730 ,"lat":31.295458 ,"count":74.72 },{"lng":120.757249 ,"lat":31.324523 ,"count":80.28 },{"lng":120.738218 ,"lat":31.305557 ,"count":70.36 },{"lng":120.661810 ,"lat":31.306878 ,"count":70.40 },{"lng":120.680776 ,"lat":31.291218 ,"count":79.92 },{"lng":120.670941 ,"lat":31.292845 ,"count":70.08 },{"lng":120.687926 ,"lat":31.303849 ,"count":60.00 },{"lng":120.736756 ,"lat":31.301674 ,"count":65.44 },{"lng":120.809319 ,"lat":31.331459 ,"count":30.12 },{"lng":120.745337 ,"lat":31.312547 ,"count":65.20 },{"lng":120.809239 ,"lat":31.331853 ,"count":30.12 },{"lng":120.747458 ,"lat":31.311133 ,"count":80.24 },{"lng":120.836825 ,"lat":31.310213 ,"count":70.32 },{"lng":120.737011 ,"lat":31.354843 ,"count":45.20 },{"lng":120.660239 ,"lat":31.325072 ,"count":65.24 },{"lng":120.764247 ,"lat":31.344619 ,"count":55.40 },{"lng":120.679733 ,"lat":31.327599 ,"count":75.36 },{"lng":120.738364 ,"lat":31.335330 ,"count":84.96 },{"lng":120.667120 ,"lat":31.295883 ,"count":70.08 },{"lng":120.667367 ,"lat":31.299455 ,"count":70.08 },{"lng":120.737236 ,"lat":31.306838 ,"count":70.36 },{"lng":120.726538 ,"lat":31.380743 ,"count":60.20 },{"lng":120.678926 ,"lat":31.314346 ,"count":75.08 },{"lng":120.722185 ,"lat":31.334681 ,"count":90.12 },{"lng":120.718315 ,"lat":31.375163 ,"count":65.40 },
{"lng":120.657733 ,"lat":31.316646 ,"count":75.36 },{"lng":120.835192 ,"lat":31.311357 ,"count":60.20 },{"lng":120.686855 ,"lat":31.304303 ,"count":60.00 },{"lng":120.669504 ,"lat":31.295287 ,"count":70.08 },{"lng":120.673793 ,"lat":31.321771 ,"count":75.40 },{"lng":120.659426 ,"lat":31.308681 ,"count":70.44 },{"lng":120.803797 ,"lat":31.366460 ,"count":44.88 },{"lng":120.679395 ,"lat":31.292934 ,"count":79.92 },{"lng":120.745409 ,"lat":31.317048 ,"count":80.24 },{"lng":120.712084 ,"lat":31.334625 ,"count":75.36 },{"lng":120.665677 ,"lat":31.318392 ,"count":80.32 },{"lng":120.685897 ,"lat":31.297321 ,"count":55.04 },{"lng":120.775002 ,"lat":31.313676 ,"count":64.88 },{"lng":120.661594 ,"lat":31.303448 ,"count":75.32 },{"lng":120.742560 ,"lat":31.318807 ,"count":70.12 },{"lng":120.788989 ,"lat":31.363874 ,"count":54.72 },{"lng":120.749145 ,"lat":31.323730 ,"count":75.08 },{"lng":120.755017 ,"lat":31.253316 ,"count":90.08 },{"lng":120.729283 ,"lat":31.300047 ,"count":60.24 },{"lng":120.744680 ,"lat":31.324048 ,"count":80.00 },{"lng":120.724907 ,"lat":31.330595 ,"count":95.08 },{"lng":120.663197 ,"lat":31.298605 ,"count":70.08 },{"lng":120.705307 ,"lat":31.350366 ,"count":70.36 },{"lng":120.678976 ,"lat":31.325410 ,"count":70.44 },{"lng":120.734391 ,"lat":31.311546 ,"count":60.28 },{"lng":120.662937 ,"lat":31.295327 ,"count":65.16 },{"lng":120.717903 ,"lat":31.333899 ,"count":75.36 },{"lng":120.687743 ,"lat":31.328107 ,"count":70.44 },
{"lng":120.667019 ,"lat":31.296988 ,"count":70.08 },{"lng":120.741463 ,"lat":31.325223 ,"count":80.00 },{"lng":120.729417 ,"lat":31.323724 ,"count":80.28 },{"lng":120.731797 ,"lat":31.304312 ,"count":65.16 },{"lng":120.747119 ,"lat":31.317119 ,"count":75.32 },{"lng":120.675877 ,"lat":31.319418 ,"count":80.32 },{"lng":120.666177 ,"lat":31.299791 ,"count":75.04 },{"lng":120.729167 ,"lat":31.303827 ,"count":65.16 },{"lng":120.682155 ,"lat":31.326218 ,"count":75.36 },{"lng":120.811256 ,"lat":31.380846 ,"count":44.88 },{"lng":120.735008 ,"lat":31.312866 ,"count":65.20 },{"lng":120.732116 ,"lat":31.272155 ,"count":55.12 },{"lng":120.759350 ,"lat":31.326131 ,"count":85.20 },{"lng":120.743552 ,"lat":31.319240 ,"count":80.24 },{"lng":120.667344 ,"lat":31.324895 ,"count":70.44 },{"lng":120.734251 ,"lat":31.337822 ,"count":84.92 },{"lng":120.682683 ,"lat":31.326469 ,"count":70.44 },{"lng":120.727515 ,"lat":31.366076 ,"count":55.28 },{"lng":120.810484 ,"lat":31.356907 ,"count":39.96 },{"lng":120.833708 ,"lat":31.308375 ,"count":70.32 },{"lng":120.825051 ,"lat":31.311383 ,"count":60.20 },{"lng":120.658791 ,"lat":31.337705 ,"count":55.08 },{"lng":120.680618 ,"lat":31.319519 ,"count":75.36 },{"lng":120.665989 ,"lat":31.323295 ,"count":75.40 },{"lng":120.671507 ,"lat":31.299643 ,"count":75.04 },{"lng":120.673882 ,"lat":31.292360 ,"count":79.92 },{"lng":120.676479 ,"lat":31.329212 ,"count":75.36 },{"lng":120.670296 ,"lat":31.317395 ,"count":80.28 },
{"lng":120.659629 ,"lat":31.312311 ,"count":75.36 },{"lng":120.661970 ,"lat":31.311770 ,"count":75.36 },{"lng":120.731979 ,"lat":31.318214 ,"count":75.08 },{"lng":120.685922 ,"lat":31.331876 ,"count":70.44 },{"lng":120.683898 ,"lat":31.316433 ,"count":75.36 },{"lng":120.719683 ,"lat":31.350674 ,"count":50.40 },{"lng":120.672071 ,"lat":31.297115 ,"count":70.08 },{"lng":120.676815 ,"lat":31.324026 ,"count":75.36 },{"lng":120.657955 ,"lat":31.319878 ,"count":70.16 },{"lng":120.683368 ,"lat":31.331195 ,"count":75.36 },{"lng":120.730733 ,"lat":31.301071 ,"count":60.24 },{"lng":120.680025 ,"lat":31.288350 ,"count":65.12 },{"lng":120.756699 ,"lat":31.323594 ,"count":80.28 },{"lng":120.827750 ,"lat":31.307825 ,"count":65.12 },{"lng":120.660772 ,"lat":31.303994 ,"count":70.40 },{"lng":120.824869 ,"lat":31.313274 ,"count":60.20 },{"lng":120.717664 ,"lat":31.367677 ,"count":70.32 },{"lng":120.652285 ,"lat":31.328446 ,"count":60.28 }
];


    if(!isSupportCanvas()){
    	alert('热力图目前只支持有canvas支持的浏览器,您所使用的浏览器不能使用热力图功能~')
    }
	heatmapOverlay = new BMapLib.HeatmapOverlay({"radius":20});
	map.addOverlay(heatmapOverlay);
	heatmapOverlay.setDataSet({data:points,max:100});
	//是否显示热力图
    function openHeatmap(){
        heatmapOverlay.show();
    }
	function closeHeatmap(){
        heatmapOverlay.hide();
    }
	closeHeatmap();
    function setGradient(){

     	var gradient = {
		};
     	var colors = document.querySelectorAll("input[type='color']");
     	colors = [].slice.call(colors,0);
     	colors.forEach(function(ele){
		gradient[ele.getAttribute("data-key")] = ele.value; 
     	});
        heatmapOverlay.setOptions({"gradient":gradient});
    }
	//判断浏览区是否支持canvas
    function isSupportCanvas(){
        var elem = document.createElement('canvas');
        return !!(elem.getContext && elem.getContext('2d'));
    }
	
	//清空地图
/*	function map_close(){
		map.clearOverlays(); 
	}
	*/
	//表单

	
	
	
	
	

	
</script>
</head>
 
<body>

	<div id="searchResultPanel" style="border:1px solid #C0C0C0;width:150px;height:auto; display:none;"></div>
	<div id="content">
	<h3><font color="black">---小区名称---</font></h3>
	<br><font color="balck">1、金匙望湖公寓</font></br>
	<br><font color="balck">2、中海星湖国际</font></br>
	<br><font color="balck">3、海尚壹品</font></br>
	<br><font color="balck">4、鸿海花苑</font></br>
	<br><font color="balck">5、金匙望湖</font></br>
	<br><font color="balck">6、师惠花苑</font></br>
	<br><font color="balck">7、宜家公寓</font></br>
	<br><font color="balck">8、天地源水墨三十度</font></br>
	<br><font color="balck">9、星公元名邸</font></br>
	<br><font color="balck">10、翡翠国际社区</font></br>
	<br><font color="balck">11、绿地华尔道名邸</font></br>
	<br><font color="balck">12、中央景城</font></br>
	<br><font color="balck">13、紫荆苑</font></br>
	<br><font color="balck">14、建屋领域</font></br>
	<br><font color="balck">15、苏悦国际公寓</font>
	</div>
   <!-- <div id="div1"></div>  -->

<div id="tag" >
<ul>
<li><a style="font-size:20px;"  >排行榜</a></li>
</ul>
</div>

	<script>
    demo1();
</script>
</body>
</html>
