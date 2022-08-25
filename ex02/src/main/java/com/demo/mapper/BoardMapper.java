package com.demo.mapper;

import java.util.List;

import com.demo.domain.BoardVO;

public interface BoardMapper {

	void register(BoardVO vo);
	
	List<BoardVO> getList();
	
	BoardVO get(Long bno);
	
	void modify(BoardVO vo);
	void delete(Long bno);
	
	
}
