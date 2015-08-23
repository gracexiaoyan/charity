package com.charity.events.dao.iface;

import com.charity.events.bean.EventInfo;

import fi.common.mvc.dao.iface.IBaseDAO;

public interface IEventsDao extends IBaseDAO<EventInfo> {
	public long getAmount(String hql, Object... values);
}
