package com.charity.common;

import java.util.List;

import fi.common.mvc.action.Pager;
import fi.common.ui.bean.Condition;

public class QueryBean {
	private Pager pager;
	private List<Condition> conditions;
	public Pager getPager() {
		return pager;
	}
	public void setPager(Pager pager) {
		this.pager = pager;
	}
	public List<Condition> getConditions() {
		return conditions;
	}
	public void setConditions(List<Condition> conditions) {
		this.conditions = conditions;
	}
}
