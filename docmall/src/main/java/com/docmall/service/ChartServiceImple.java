package com.docmall.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.docmall.domain.ChartVO;
import com.docmall.mapper.CartMapper;
import com.docmall.mapper.ChartMapper;

@Service
public class ChartServiceImple implements ChartService {
	
	@Autowired
	private ChartMapper mapper;

	@Override
	public List<ChartVO> primaryChart() {
		// TODO Auto-generated method stub
		return mapper.primaryChart();
	}

}
