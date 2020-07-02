package com.tity.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tity.dao.ComunityDao;
import com.tity.entity.Community;
import com.tity.entity.PageCunit;

@Service
public class ComunityServiceImpl implements ComunityService {

	@Autowired
	private ComunityDao comunityDao;
	
	@Override
	public List<Community> findCommunityBy(PageCunit vo) {
		List<Community> list = comunityDao.findCommunityBy(vo);
		return list;
	}

	@Override
	public Integer findCommunityByCount(PageCunit vo) {
		Integer count = comunityDao.findCommunityByCount(vo);
		return count;
	}

	@Override
	public Community findCommunityById(Long id) {
		Community community = comunityDao.findCommunityById(id);
		return community;
	}

	@Override
	public void insertCommunityById(Community community) {
		comunityDao.insertCommunityById(community);
	}

	@Override
	public void deleteCommunityById(long id) {
		comunityDao.deleteCommunityById(id);
	}

	@Override
	public void updateCommunityById(Community community) {
		comunityDao.updateCommunityById(community);
	}

}
