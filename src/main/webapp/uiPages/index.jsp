<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html ng-app="mainModule">
<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
	<title>慈善总会会员系统</title>
	<script src="<%=request.getContextPath()%>/js/common.js" type="text/javascript"></script>
</head>
<body class="easyui-layout" style="background-color:#dfe8f6;">
	<nav class="navbar navbar-default">
	  <div class="container-fluid">
	    <!-- Brand and toggle get grouped for better mobile display -->
	    <div class="navbar-header">
	      <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
	        <span class="sr-only">Toggle navigation</span>
	        <span class="icon-bar"></span>
	        <span class="icon-bar"></span>
	        <span class="icon-bar"></span>
	      </button>
	      
	    </div>
	
	    <!-- Collect the nav links, forms, and other content for toggling -->
	    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1" ng-controller="changeLink">
	      <ul class="nav navbar-nav">
	        <li class="active" id="liMember"><a href="" ng-click="showMember()">会员信息</a></li>
	        <li id="liEvent"><a href="" ng-click="showEvent()">活动信息</a></li>
	      </ul>
	    </div><!-- /.navbar-collapse -->
	    
	    <div class="panel panel-default">
		  <div class="panel-body" id="divMain">
		     
		  </div>
		  <div class="panel-footer">Panel footer</div>
		</div>
	  </div><!-- /.container-fluid -->
	</nav>
</body>
</html>