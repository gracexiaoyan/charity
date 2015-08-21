var mainModule = angular.module('mainModule',[]);

mainModule.controller('changeLink', ['$scope', '$http', function($scope, $http) {
	$scope.userShowTemplateUrl = "./membership/showListMembers"; 
    
	// refresh member table
    $scope.refreshMemberTable = function(queryData) {
    	var req = {
    			 method:'POST',
     			 url: './membership/listMembers',
     			 data: queryData
     		};
      	$http(req).then(function(response) {
     			//$scope.userShowTemplateUrl = "./membership/listMembers";    			
   	        	//alert(response.data.rows);	 
      			$scope.userList = response.data.rows;
      			$scope.currentPage = response.data.pager.num;
      			$scope.totalPages = response.data.pager.count;
      			$scope.total = response.data.total;
      			
      			var options = {
    		        	bootstrapMajorVersion:3,
    		            currentPage: queryData.pager.num,
    		            numberOfPages: 10,
    		            totalPages: $scope.totalPages,
    		            onPageClicked: function (event, originalEvent, type, page) {
    		            	//$("#divMain").load("./membership/listMembers",{"num":page});
    		            	//$scope.refreshMemberTable(page);
    		            	dataQuery = {"pager":{"num":page}};
    		              	$scope.refreshMemberTable(dataQuery);
    		            }
    		        };
      			
      			$('#memberPager').bootstrapPaginator(options);
      			//alert(options.currentPage);
   	        }, function(response) {
   	        	alert("获取会员失败。");
   	      });
    };
    dataQuery = {"pager":{"num":1}};
  	$scope.refreshMemberTable(dataQuery);

	// change link when click the head
    $scope.showMember = function () {
        $("#liEvent").removeClass("active");
        $("#liMember").addClass("active");
        //$("#divMain").load("./membership/listMembers");
        $scope.userShowTemplateUrl = "./membership/showListMembers";
        dataQuery = {"pager":{"num":1}};
      	$scope.refreshMemberTable(dataQuery);
    };
    
    $scope.showEvent = function () {
        $("#liMember").removeClass("active");
        $("#liEvent").addClass("active");
    };    
    
}]);

mainModule.controller('memberController', ['$scope', '$http', function($scope, $http) {
	// show the new member dialog
    $scope.newMember = function (){
    	$("#memberForm").trigger("reset");
    	$('#myModal').modal();
    	$scope.sex="男";
    	$scope.isMember="否";
    };
    
    // show the edit member dialog
    $scope.getMember = function (id) {
    	$http.get("./membership/getMember?id="+id)
        .success(function(data, status, headers, config) {
        	$('#myModal').modal();
        	if(data.birthday){
        		var dataArray = data.birthday.split("-");
        		$scope.birthday=new Date(dataArray[0], dataArray[1]-1, dataArray[2]);
        	}
        	$scope.memberId= data.id;
        	$scope.name=data.name;
        	$scope.sex=data.sex;        	
        	$scope.email=data.email;
        	$scope.isMember=data.isMember;
        	$scope.cardId=data.cardId;
        	$scope.cellphone=data.cellphone;
        	$scope.phone=data.phone;
        	$scope.address=data.address;
        	$scope.company=data.company;
        	$scope.note=data.note;        	
        }).
        error(function(data, status, headers, config) {
        	alert("更新会员失败。");
        });
        
    };
    
    // add or update member
    $scope.updateMember = function(){
    	if(!$('#name')){
			 alert("请填写姓名。");
		 }
	     $.ajax({
	     	type: "POST",
	 		url: "./membership/addMember",
	 		data: $('#memberForm').serialize(),
	 		success: function(msg){
	 			if(msg=="success"){
	 				alert("保存会员成功。");        	 				
	 				$("#myModal").modal('hide');   
	 				dataQuery = {"pager":{"num":1}};
	 		      	$scope.refreshMemberTable(dataQuery);
	 			}
	 			else{
	 				alert("保存会员失败。");
	 			}
	        },
	 		error: function(jqXHR, textStatus, errorThrown){
	 			alert("保存会员失败。");
	 		}
	       });
    };
	
	// delete member
    $scope.deleteMember = function (id) {
    	if(!confirm("确定要删除会员吗?")){
    		return;
    	}
    	var req = {
    			 method: 'POST',
    			 url: './membership/deleteMember?id='+id,
    			 headers: {
    			   'Accept': 'text/plain'
    			 }
    		};
    	$http(req).then(function(response) {			
	        	alert("删除会员成功。");
	        	dataQuery = {"pager":{"num":1}};
	          	$scope.refreshMemberTable(dataQuery);
	        }, function(response) {
	        	alert("删除会员失败。");
	      });
    };
    
    $scope.queryMember = function() {
    	var queryCondition = [];
    	var dataQuery;
    	if($scope.qName){
    		queryCondition.push({"propertyKey" : "name", "propertyExpression" : "like", "propertyValue" : $scope.qName});
    	}
    	if($scope.qPhone){
    		queryCondition.push({"propertyKey" : "cellphone", "propertyExpression" : "like", "propertyValue" : $scope.qPhone});
    	}
    	if($scope.qCard){
    		queryCondition.push({"propertyKey" : "cardId", "propertyExpression" : "like", "propertyValue" : $scope.qCard});
    	}
    	if(queryCondition.length > 0){
    		dataQuery = {"pager":{"num":1}, "conditions":queryCondition};
    	}
    	else{
    		dataQuery = {"pager":{"num":1}};
    	}
    	$scope.refreshMemberTable(dataQuery);
    };
}]);

