package com.charity.events.dao;

import org.springframework.stereotype.Repository;

import com.charity.events.bean.EventInfo;
import com.charity.events.dao.iface.IEventsDao;

import fi.common.mvc.dao.BaseDAO;

@Repository("eventDao")
public class EventsDao extends BaseDAO<EventInfo> implements IEventsDao {


}
