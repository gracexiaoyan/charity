var mainModule = angular.module('mainModule',[]);

mainModule.controller('changeLink', ['$scope', '$http', function($scope, $http) {
	//$("#divMain").load("./membership/listMembers");
	$scope.userShowTemplateUrl = "./membership/listMembers";
	// change link when click the head
    $scope.showMember = function () {
        $("#liEvent").removeClass("active");
        $("#liMember").addClass("active");
        //$("#divMain").load("./membership/listMembers");
        $scope.userShowTemplateUrl = "./membership/listMembers";
    };
    
    $scope.showEvent = function () {
        $("#liMember").removeClass("active");
        $("#liEvent").addClass("active");
        //$("#divMain").load("./eventList.jsp");
        $scope.userShowTemplateUrl = "./membership/listMembers1";
    };
    
    $scope.newUser = function (){
    	$("#memberForm").trigger("reset");
    	$('#myModal').modal();
    };
    
 // updateUser
    $scope.updateUser = function (id) {
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
    
    $scope.deleteUser = function (id) {
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
//    	$http.post("./membership/deleteMember?id="+id)
//	        .success(function(data, status, headers, config) {
//	        	alert("删除会员成功。");
//	        }).
//	        error(function(data, status, headers, config) {
//	        	alert("删除会员失败。");
//	        });
    	$http(req).then(function(response) {
    			$scope.userShowTemplateUrl = "./membership/listMembers";
	        	alert("删除会员成功。");	        	
	        }, function(response) {
	        	alert("删除会员失败。");
	      });
    };
}]);

