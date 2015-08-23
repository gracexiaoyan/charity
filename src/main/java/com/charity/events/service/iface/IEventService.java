package com.charity.events.service.iface;

import java.util.List;
import java.util.Map;

import com.charity.events.bean.EventInfo;

import fi.common.mvc.action.Pager;
import fi.common.mvc.service.iface.IBaseService;
import fi.common.ui.bean.Condition;

public interface IEventService extends IBaseService<EventInfo> {
	public Map queryEvent(List<Condition> conditions, Pager pager);
	
	public List getEventInfo(String id);
}
