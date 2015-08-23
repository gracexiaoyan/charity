package com.charity.events.controller;

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
import com.charity.events.bean.EventInfo;
import com.charity.events.service.iface.IEventService;

import fi.common.ui.bean.Condition;

@Controller
@RequestMapping("/events")
public class EventController {
	@Autowired
	private IEventService eventService;
	
	@RequestMapping("/showListEvents")
	public String showListEvents(){
		return "events/eventList";
	}
	
	@RequestMapping("/listEvents")
	@ResponseBody
	public Map listEvents(@RequestBody QueryBean queryBean){
		List<Condition> conditions = new ArrayList<Condition>();
		if(queryBean.getConditions() != null){
			conditions  = queryBean.getConditions();
		}
		
		Map eventMap = eventService.queryEvent(conditions, queryBean.getPager());
		return eventMap;
	}
	
	@RequestMapping(value="/addEvent")
	@ResponseBody
	public String addEvent(EventInfo event){
		try {
			if(event.getId().equals("")){
				eventService.save(event);
			}
			else{
				eventService.saveOrUpdate(event);
			}			
		} catch (Exception e) {
			e.printStackTrace();
			return "error";
		}
		return "success";
	}
	
	@RequestMapping(value="/getEvent", headers="Accept=*/*")
	@ResponseBody
	public List getEvent(String id) throws Exception{
		return eventService.getEventInfo(id);
	}
	
	@RequestMapping(value="/deleteEvent")//, produces="text/plain")
	@ResponseBody
	public String deleteEvent(String id) throws Exception{
		eventService.removeById(id);
		return "success";
	}
	
	@InitBinder
	public void initBinder(WebDataBinder binder) {
	    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	    sdf.setLenient(true);
	    binder.registerCustomEditor(Date.class, new CustomDateEditor(sdf, true));
	}
}
