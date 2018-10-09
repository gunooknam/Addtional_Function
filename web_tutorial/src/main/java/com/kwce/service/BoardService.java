package com.kwce.service;

import java.util.List;

import com.kwce.domain.BoardVO;
import com.kwce.domain.FileVO;

public interface BoardService {
	
	public void regist(BoardVO board)throws Exception;
	
	public BoardVO read(Integer bno)throws Exception;
	
	public void modify(BoardVO board)throws Exception;
	
	public void remove(Integer bno)throws Exception;
	
	public List<BoardVO>listAll()throws Exception;
	
	public List<String> getAttach(Integer bno)throws Exception;

}
