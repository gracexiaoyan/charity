<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div ng-controller="eventController">

<div class="panel panel-default" >
	<div class="panel-heading" >
		<div class="controls controls-row">
		<div class="input-group">
		  <span class="input-group-addon" id="srhQName">姓&nbsp;&nbsp;&nbsp;&nbsp;名:&nbsp;&nbsp;&nbsp;&nbsp;</span>
		  <input type="text" class="form-control" aria-describedby="srhQName" ng-model="qName">
		  <span class="input-group-addon" id="srhQPhone">手&nbsp;&nbsp;&nbsp;&nbsp;机:&nbsp;&nbsp;&nbsp;&nbsp;</span>
		  <input type="text" class="form-control" aria-describedby="srhQPhone" ng-model="qPhone">
		  <span class="input-group-addon" id="srhQCard">卡&nbsp;&nbsp;&nbsp;&nbsp;号:&nbsp;&nbsp;&nbsp;&nbsp;</span>
		  <input type="text" class="form-control" aria-describedby="srhQCard" ng-model="qCard">
		  <span class="input-group-addon" id="srhQCard">活动日期:</span>
		  <input type="date" class="form-control" aria-describedby="srhQDate" ng-model="qDate">
		  <span class="input-group-btn">
	        <button class="btn btn-primary" style="margin-left:5px" type="button" ng-click="newEvent()">签&nbsp;&nbsp;&nbsp;&nbsp;到</button>
	      </span>
		  <span class="input-group-btn" >
	        <button class="btn btn-primary" style="margin-left:5px" type="button" ng-click="queryEvent()">查&nbsp;&nbsp;&nbsp;&nbsp;询</button>
	      </span>
		</div>
		</div>
	</div>
	<p>
	<nav class="navbar-right"></nav>
  <!-- Table -->
  <table class="table table-striped" height="90%">
  	<tr>
	    <th>活动日期</th>
	    <th>经费</th>
	    <th>姓名</th>
	    <th>性别</th>
	    <th>电话</th>
	    <th>手机</th>
	    <th>是否会员</th>
	    <th>卡号</th>
	    <th>单位</th>
	    <th>操作</th>
    </tr>
    <tr ng-repeat="event in eventList">
    	<td>{{ event[0].attendDate }}</td>
	    <td>{{ event[0].donate }}</td>
	    <td>{{ event[1].name }}</td>
	    <td>{{ event[1].sex }}</td>
	    <td>{{ event[1].phone }}</td>
	    <td>{{ event[1].cellphone }}</td>
	    <td>{{ event[1].isMember }}</td>
	    <td>{{ event[1].cardId }}</td>
	    <td>{{ event[1].company }}</td>	    
	    <td><a href="javascript:" ng-click="getEvent( event[0].id )">修改</a> &nbsp; 
	    	<a href="javascript:" ng-click="deleteEvent(event[0].id)" >删除</a></td>
  	</tr>
  </table>
  <table class="table table-striped" height="90%"  style="margin-top:10px">
    <tr >
    	<td><nav ><ul id="eventPager"></ul></nav></td>
    	<td align="right"  style="vertical-align:middle"><font color="red">总金额 【{{amount}}】元</font>    </td>
	    <td align="right"  style="vertical-align:middle">共 【{{totalPages}}】 页      &nbsp;&nbsp;&nbsp;&nbsp; 共【{{total}}】条数据</td>
   </tr>
  </table>
</div>

<div class="modal fade" id="eventModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title">登记活动信息</h4>
      </div>
      <form id="eventForm" data-toggle="validator"><div class="modal-body">
        <div class="input-group" style="margin-bottom:10px">
		  <span class="input-group-addon" id="srhName">活动日期:</span>
		  <input type="date" class="form-control" name="attendDate" ng-model="attendDate">
		  <span class="input-group-addon" id="srhSex">活动经费:</span>
		  <input type="text" class="form-control" name="donate" ng-model="donate">
		</div>
        <div class="input-group" style="margin-bottom:10px">
		  <span class="input-group-addon" id="srhName">姓&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;名:</span>
		  <input type="text" class="form-control" ng-model="name" disabled>
		  <span class="input-group-addon" id="srhSex">性&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;别:</span>
		  <div class="form-control">
			  <label class="radio-inline" style="width:67px"><input type="radio" ng-model="sex" value="男" disabled>男</label>
			  <label class="radio-inline" style="width:69px"><input type="radio" ng-model="sex" value="女" disabled>女</label>
		  </div>
		</div>
		<div class="input-group" style="margin-bottom:10px">
		  <span class="input-group-addon" id="srhBirthday">出生年月:</span>
		  <input type="date" class="form-control" ng-model="birthday" disabled>
		  <span class="input-group-addon" id="srhCard">电子邮箱:</span>
		  <input type="text" class="form-control" ng-model="email" disabled>
		</div>
		<div class="input-group" style="margin-bottom:10px">
		  <span class="input-group-addon" id="srhBirthday">是否会员:</span>
		  <div class="form-control">
			  <label class="radio-inline" style="width:69px"><input type="radio" ng-model="isMember" value="是" disabled>是</label>
			  <label class="radio-inline" style="width:69px"><input type="radio" ng-model="isMember" value="否" disabled>否</label>
		  </div>
		  <span class="input-group-addon" id="srhCard">卡&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;号:</span>
		  <input type="text" class="form-control" ng-model="cardId" disabled>
		</div>
		<div class="input-group" style="margin-bottom:10px">
		  <span class="input-group-addon" id="srhCellphone">手&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;机:</span>
		  <input type="text" class="form-control" ng-model="cellphone" disabled>
		  <span class="input-group-addon" id="srhPhone">电&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;话:</span>
		  <input type="text" class="form-control" ng-model="phone" disabled>
		</div>
		<div class="input-group" style="margin-bottom:10px">
		  <span class="input-group-addon" id="srhAddress">家庭住址:</span>
		  <input type="text" class="form-control" ng-model="address" disabled>
		  <span class="input-group-addon" id="srhCompany">所在单位:</span>
		  <input type="text" class="form-control" ng-model="company" disabled>
		  <input type="text" style="display:none" class="form-control" id="id" name="id" ng-model="id">
		  <input type="text" style="display:none" class="form-control" id="memberId" name="memberId" ng-model="memberId">
		</div>	
      </div></form>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">关&nbsp;&nbsp;&nbsp;&nbsp;闭</button>
        <button type="submit" class="btn btn-primary" id="submitForm" ng-click="updateEvent()">保&nbsp;&nbsp;&nbsp;&nbsp;存</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<div class="modal fade" id="memberEventModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title">登记活动信息</h4>
      </div>
      <div class="modal-body">
        <table class="table table-striped" height="90%">
		  	<tr>
			    <th>姓名</th>
			    <th>性别</th>
			    <th>电话</th>
			    <th>手机</th>
			    <th>是否会员</th>
			    <th>卡号</th>
			    <th>操作</th>
		    </tr>
		    <tr ng-repeat="memberEvent in memberEventList">
			    <td>{{ memberEvent.name }}</td>
			    <td>{{ memberEvent.sex }}</td>
			    <td>{{ memberEvent.phone }}</td>
			    <td>{{ memberEvent.cellphone }}</td>
			    <td>{{ memberEvent.isMember }}</td>
			    <td>{{ memberEvent.cardId }}</td>
			    <td><a href="javascript:" ng-click="registerMember( memberEvent )">签到</a> </td>
		  	</tr>
		  </table>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<script type='text/javascript'>        
        // 加此事件是为了防止在编辑时第二次打开对话框时没有数据的情况
        $('#eventModal').on('hidden.bs.modal', function (event) {
        	$(this).removeData("bs.modal");
        });
        $('#memberEventModal').on('hidden.bs.modal', function (event) {
        	$(this).removeData("bs.modal");
        });
</script>

</div>