//Êý¾Ý·ÃÎÊ²ã
package com.tity.dao;

import java.util.List;

import com.tity.entity.Community;
import com.tity.entity.PageCunit;

public interface ComunityDao {
	
	public List<Community> findCommunityBy(PageCunit vo);
	public Integer findCommunityByCount(PageCunit vo);
	public Community findCommunityById(Long id);
	
	public void insertCommunityById(Community community);
	
	public void deleteCommunityById(long id);
	
	public void updateCommunityById(Community community);
	
}
