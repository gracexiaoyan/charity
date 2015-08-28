package com.charity.membership.service.iface;

import java.util.List;
import java.util.Map;

import com.charity.membership.bean.Membership;

import fi.common.mvc.action.Pager;
import fi.common.mvc.service.iface.IBaseService;
import fi.common.ui.bean.Condition;

public interface IMembershipService extends IBaseService<Membership> {
	public Map queryMember(List<Condition> conditions, Pager pager);
	
	public List queryAllMember(List<Condition> conditions);
	
	public Membership getMember(String id) throws Exception;
	
	public boolean getMemberExist(Membership member);
}
