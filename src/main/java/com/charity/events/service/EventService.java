package com.charity.events.service;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.charity.events.bean.EventInfo;
import com.charity.events.service.iface.IEventService;

import fi.common.easyui.PagerUtil;
import fi.common.mvc.action.Pager;
import fi.common.mvc.dao.iface.IBaseDAO;
import fi.common.mvc.service.BaseService;
import fi.common.ui.bean.Condition;

@Service("eventService")
public class EventService extends BaseService<EventInfo> implements IEventService{
	@Resource(name="eventDao")
	public void setBaseDAO(IBaseDAO<EventInfo> baseDAO) {
		this.baseDAO = baseDAO;
	}

	public List getEventInfo(String id) {
		String hql = " from EventInfo e, Membership m where e.memberId = m.id and e.id = ?";
		
		return this.find(hql, id);
	}

	public Map queryEvent(List<Condition> conditions, Pager pager) {
		StringBuilder hql = new StringBuilder(" from EventInfo e, Membership m where e.memberId = m.id ");
		List<Object> values = new ArrayList<Object>();
		if(!conditions.isEmpty()){
			values = concatConditions(hql, conditions);
		}
		int count = baseDAO.count("select count(*) " + hql.toString(), values.toArray());
        pager = new Pager(pager == null ? 1 : pager.getNum(),10  ,count);
        String hqlOrder = "select e,m " + hql.toString() + " order by e.attendDate desc ";
        List dataList = this.pagedList(hqlOrder, pager.getStartRow(), pager.getSize(), values.toArray());
        return PagerUtil.dataFormat(pager, dataList);
	}

	private List<Object> concatConditions(StringBuilder hql, List<Condition> conditions){
		List<Object> values = new ArrayList<Object>();
		for(int i = 0; i < conditions.size(); i++){
			Condition c = conditions.get(i);
			
			if(c.getPropertyKey().equals("e.attendDate")){
				hql.append(" and ").append(c.getPropertyKey()).append(" = ? ");
				SimpleDateFormat f = new SimpleDateFormat("yyyy-MM-dd");
                try
                {
                    Object value = f.parse(c.getPropertyValue());
                    values.add(value);
                }
                catch(ParseException e)
                {
                    e.printStackTrace();
                }
			}
			else{
				Object value = null;
				hql.append(" and ").append(c.getPropertyKey()).append(" ").append(c.getPropertyExpression()).append(" ? ");
				if(c.getPropertyExpression().equals("like")){
					value = "%" + c.getPropertyValue() + "%";
				}
				else{
					value = c.getPropertyValue();
				}
				values.add(value);
			}
		}
		return values;
	}
}
