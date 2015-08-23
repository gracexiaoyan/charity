package com.charity.events.dao;

import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.stereotype.Repository;

import com.charity.events.bean.EventInfo;
import com.charity.events.dao.iface.IEventsDao;

import fi.common.mvc.dao.BaseDAO;

@Repository("eventDao")
public class EventsDao extends BaseDAO<EventInfo> implements IEventsDao {

	public long getAmount(String hql, Object... values) {
		Session session = getCurrentSession();
        Query queryObj = createQuery(session, hql, values);
        Object result = queryObj.uniqueResult();
        if(result != null){
        	return (Long)result;
        }
		return 0;
	}


}
