package com.demo.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.demo.domain.BoardVO;
import com.demo.service.BoardService;

import lombok.extern.log4j.Log4j;

@RequestMapping("/board/*")
@Controller
@Log4j
public class BoardController {
	@Autowired
	private BoardService service;

	@GetMapping("/register")
	public void register() {
		
	}
	@PostMapping("/register")
	public String register(BoardVO vo) {
		service.register(vo);
		return "redirect:/board/list";
	}
	
	@GetMapping("/list")
	public void list(Model model) {
		List<BoardVO> list = service.getList();
		model.addAttribute("list", list);
	}
	
	@GetMapping("/modify")
	public void modify1(BoardVO vo, @RequestParam("bno") Long bno, Model model) {
		
		model.addAttribute("board", service.get(bno));
	}
	
	@PostMapping("/modify")
	public String modify(BoardVO vo, Model model) {
		service.modify(vo);
		return "redirect:/board/list";
	}
	
	@GetMapping("/delete")
	public String delete(@RequestParam("bno") Long bno) {
		service.delete(bno);
		
		return "redirect:/board/list";
	}
	
	
	
}
