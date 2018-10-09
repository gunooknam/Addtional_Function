package com.kwce.service;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kwce.dao.BoardDAO;
import com.kwce.domain.BoardVO;
import com.kwce.domain.FileVO;

@Service
public class BoardServiceImpl implements BoardService{

	@Autowired
	private BoardDAO dao;
	
	@Transactional //여기서 트랜잭션의 처리가 이루어져야 한다 그래야 이전의 값을 기억한다.
	@Override
	public void regist(BoardVO board) throws Exception {
		
		dao.create(board);
		
		String[] files=board.getFiles();
		
		if(files==null) {return;}
		
		for(String fileName:files) {
			dao.addAttach(fileName);
		}
		
	}

	@Override
	public BoardVO read(Integer bno) throws Exception {
		return dao.read(bno);
	}
	
	@Transactional //여기서 트랜잭션의 처리가 이루어져야 한다 그래야 이전의 값을 기억한다.
	@Override
	public void modify(BoardVO board) throws Exception {
		dao.update(board);
		
		Integer bno= board.getBno();
		
		dao.deleteAttach(bno);
		
		String[] files = board.getFiles();
		if(files==null) {return;}
		for(String fileName :files) {
			dao.replaceAttach(fileName, bno);
		}
	}

	
	@Transactional //여기서 트랜잭션의 처리가 이루어져야 한다 그래야 이전의 값을 기억한다.
	@Override
	public void remove(Integer bno) throws Exception {
		dao.deleteAttach(bno); //반드시 첨부파일부터지우고
		dao.delete(bno);  //게시글을 지우자
	}

	@Override
	public List<BoardVO> listAll() throws Exception {
		return dao.listAll();
	}

	@Override
	public List<String> getAttach(Integer bno) throws Exception {
		return dao.getAttach(bno);
	}

}
