package com.charity.membership.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.charity.membership.bean.Membership;
import com.charity.membership.service.iface.IMembershipService;

import fi.common.easyui.PagerUtil;
import fi.common.hibernate.QueryHQLParser;
import fi.common.mvc.action.Pager;
import fi.common.mvc.dao.iface.IBaseDAO;
import fi.common.mvc.service.BaseService;
import fi.common.ui.bean.Condition;

@Service("membershipService")
public class MembershipService extends BaseService<Membership> implements
		IMembershipService {

	public Membership getMember(String id) throws Exception {
		return baseDAO.get(id);
	}

	@Resource(name="membershipDao")
	public void setBaseDAO(IBaseDAO<Membership> baseDAO) {
		this.baseDAO = baseDAO;
	}

	public Map queryMember(List<Condition> conditions, Pager pager) {
		QueryHQLParser p = new QueryHQLParser(new Membership(), conditions);
        int count = baseDAO.count("select count(*) " + p.getHql(), p.getValues());
        pager = new Pager(pager == null ? 1 : pager.getNum(),10  ,count);
        String hqlOrder = p.getHql() + " order by modifyDate desc ";
        List dataList = this.pagedList(hqlOrder, pager.getStartRow(), pager.getSize(), p.getValues());
        return PagerUtil.dataFormat(pager, dataList);
	}

	public List queryAllMember(List<Condition> conditions) {
		QueryHQLParser p = new QueryHQLParser(new Membership(), conditions);
        List dataList = this.dataList(p.getHql(), p.getValues());
        return dataList;
	}

}
