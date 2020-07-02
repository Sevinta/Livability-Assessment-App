
package com.tity.controller;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.tity.dao.ComunityDao;
import com.tity.entity.Community;
import com.tity.entity.PageCunit;
import com.tity.service.ComunityService;

import cn.itcast.utils.Page;

@Controller
@RequestMapping("/unity")
public class ComunityController {
	
	@Resource
	private ComunityDao comunityDao;
	
	@Autowired
	private ComunityService comunityService;
	
	@RequestMapping("/list")
	public String list(PageCunit vo,Model model) throws Exception{
		
		//查询全表
		List<Community> slist = comunityService.findCommunityBy(vo);
		Integer count = comunityService.findCommunityByCount(vo);
		
		if(vo.getCunityName()!=null){
			vo.setCunityName(new String(vo.getCunityName().getBytes("iso8859-1"),"utf-8"));
		}
		if(vo.getPage()==null){
			vo.setPage(1);
		}
		vo.setStart((vo.getPage() - 1) * vo.getSize());
		
		//分页
		Page<Community> page = new Page<Community>();
		page.setTotal(count);
		page.setSize(vo.getSize());
		page.setPage(vo.getPage());
		page.setRows(slist);
		
		model.addAttribute("page",page);
		
		model.addAttribute("cunityName",vo.getCunityName());
		//model.addAttribute("cunityClounm",vo.getCunityClounm());
		
		return "commtity";
	}
	
	@RequestMapping("/detail")
	@ResponseBody
	public Community detail(Long id) throws Exception{
		Community commtity = comunityService.findCommunityById(id);
		return commtity;
	}
	
	@RequestMapping("/insert")
	public String insert(Community community) throws Exception{
		comunityService.insertCommunityById(community);
		return "commtity";
	}
	
	@RequestMapping("/delete")
	public String delete(long id) throws Exception{
		comunityService.deleteCommunityById(id);
		return "commtity";
	}
	
	@RequestMapping("/update")
	public String update(Community community) throws Exception{
		comunityService.updateCommunityById(community);
		return "commtity";
	}
	
}
