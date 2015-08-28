var mainModule = angular.module('mainModule');

mainModule.controller('memberController', ['$scope', '$http', function($scope, $http) {
	// show the new member dialog
    $scope.newMember = function (){
    	$("#memberForm").trigger("reset");
    	$scope.sex="男";
    	$scope.isMember="否";
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
        	$scope.id= data.id;
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
			 return;
		 }
	     $.ajax({
	     	type: "POST",
	 		url: "./membership/addMember",
	 		data: $('#memberForm').serialize(),
	 		success: function(msg){
	 			if(msg=="success"){
	 				alert("保存会员成功。");        	 				
	 				$("#myModal").modal('hide');   
	 				$scope.queryMember();
	 			}
	 			else if(msg=="exist"){
	 				alert("该会员已存在。");
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
	        	$scope.queryMember();
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
    	if($scope.qCellPhone){
    		queryCondition.push({"propertyKey" : "cellphone", "propertyExpression" : "like", "propertyValue" : $scope.qCellPhone});
    	}
    	if($scope.qPhone){
    		queryCondition.push({"propertyKey" : "phone", "propertyExpression" : "like", "propertyValue" : $scope.qPhone});
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