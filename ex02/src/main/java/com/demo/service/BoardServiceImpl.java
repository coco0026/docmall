package com.demo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.demo.domain.BoardVO;
import com.demo.mapper.BoardMapper;

@Service
public class BoardServiceImpl implements BoardService {

	@Autowired
	private BoardMapper mapper;
	
	@Override
	public void register(BoardVO vo) {
		mapper.register(vo);
		
	}

	@Override
	public List<BoardVO> getList() {
		// TODO Auto-generated method stub
		return mapper.getList();
	}

	@Override
	public void modify(BoardVO vo) {
		// TODO Auto-generated method stub
		mapper.modify(vo);
		
	}

	@Override
	public void delete(Long bno) {
		// TODO Auto-generated method stub
		mapper.delete(bno);
	}

	@Override
	public BoardVO get(Long bno) {
		// TODO Auto-generated method stub
		return mapper.get(bno);
	}

}
