var mainModule = angular.module('mainModule',[]);

mainModule.controller('changeLink', ['$scope', '$http', function($scope, $http) {
	$scope.userShowTemplateUrl = "./membership/showListMembers";
	
	$scope.initMemberTable = function() {
    	var req = {
    			method:'POST',
    			 url: './membership/listMembers',
    			 data: {"num":1}
     		};
      	$http(req).then(function(response) {	 
      			$scope.userList = response.data.rows;
      			$scope.currentPage = response.data.pager.num;
      			$scope.totalPages = response.data.pager.count;
      			$scope.total = response.data.total;
      			
      			var options = {
      		        	bootstrapMajorVersion:3,
      		            currentPage: $scope.currentPage,
      		            numberOfPages: 10,
      		            totalPages: $scope.totalPages,
      		            onPageClicked: function (event, originalEvent, type, page) {
      		            	//$("#divMain").load("./membership/listMembers",{"num":page});
      		            	$scope.refreshMemberTable(page);
      		            }
      		        };
      		    $('#memberPager').bootstrapPaginator(options);
   	        }, function(response) {
   	        	alert("获取会员失败。");
   	      });
    };    
    $scope.initMemberTable();

	// change link when click the head
    $scope.showMember = function () {
        $("#liEvent").removeClass("active");
        $("#liMember").addClass("active");
        //$("#divMain").load("./membership/listMembers");
        $scope.userShowTemplateUrl = "./membership/showListMembers";
        $scope.refreshMemberTable(1);
    };
    
    $scope.showEvent = function () {
        $("#liMember").removeClass("active");
        $("#liEvent").addClass("active");
        //$scope.refreshMemberTable();
        //$("#divMain").load("./eventList.jsp");
        //$scope.userShowTemplateUrl = "./membership/listMembers1";
    };
    
    $scope.refreshMemberTable = function(page) {
    	var req = {
    			method:'POST',
     			 url: './membership/listMembers',
     			 data: {"num":page}
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
    		            currentPage: page,
    		            numberOfPages: 10,
    		            totalPages: $scope.totalPages,
    		            onPageClicked: function (event, originalEvent, type, page) {
    		            	//$("#divMain").load("./membership/listMembers",{"num":page});
    		            	$scope.refreshMemberTable(page);
    		            }
    		        };
      			$('#memberPager').bootstrapPaginator(options);
   	        }, function(response) {
   	        	alert("获取会员失败。");
   	      });
    };
        
    // show the new member dialog
    $scope.newMember = function (){
    	$("#memberForm").trigger("reset");
    	$('#myModal').modal();
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
   	        	$scope.refreshMemberTable(1);
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
	        	$scope.refreshMemberTable(1);
	        }, function(response) {
	        	alert("删除会员失败。");
	      });
    };
}]);

