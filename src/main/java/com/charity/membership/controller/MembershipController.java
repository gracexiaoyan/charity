package com.charity.membership.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.charity.common.QueryBean;
import com.charity.membership.bean.Membership;
import com.charity.membership.service.iface.IMembershipService;

import fi.common.ui.bean.Condition;

@Controller
@RequestMapping("/membership")
public class MembershipController {
	@Autowired
	private IMembershipService membershipService;
	
	@RequestMapping("/showListMembers")
	public String showListMembers(){
		return "membership/memberList";
	}
	
	@RequestMapping("/listMembers")
	@ResponseBody
	//public Map listMembers(@RequestBody Pager pager, @RequestBody List<Condition> conditions){
	public Map listMembers(@RequestBody QueryBean queryBean){
		List<Condition> conditions = new ArrayList<Condition>();
		if(queryBean.getConditions() != null){
			conditions  = queryBean.getConditions();
		}
		
		Map memberMap = membershipService.queryMember(conditions, queryBean.getPager());		
		return memberMap;
	}
	
	@RequestMapping(value="/addMember")
	@ResponseBody
	public String addMember(Membership member){
		try {
			if(member.getId().equals("")){
				membershipService.save(member);
			}
			else{
				membershipService.saveOrUpdate(member);
			}			
		} catch (Exception e) {
			e.printStackTrace();
			return "error";
		}
		return "success";
	}
	
	@RequestMapping(value="/getMember", headers="Accept=*/*")
	@ResponseBody
	public Object getMember(String id) throws Exception{
		Membership member = membershipService.getMember(id);
		return member;
	}
	
	@RequestMapping(value="/deleteMember")//, produces="text/plain")
	@ResponseBody
	public String deleteMember(String id) throws Exception{
		membershipService.removeById(id);
		return "success";
	}
	
	@InitBinder
	public void initBinder(WebDataBinder binder) {
	    SimpleDateFormat sdf = new SimpleDateFormat("MM-dd-yyyy");
	    sdf.setLenient(true);
	    binder.registerCustomEditor(Date.class, new CustomDateEditor(sdf, true));
	}

}
