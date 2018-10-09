package com.kwce.dao;
import java.util.List;
import com.kwce.domain.BoardVO;
import com.kwce.domain.SearchCriteria;

public interface BoardDAO {
	public void create(BoardVO vo) throws Exception;
	
	public BoardVO read(Integer bno)throws Exception;
	
	public void update(BoardVO vo)throws Exception;
	
	public void delete(Integer bno)throws Exception;
	
	public List<BoardVO> listAll()throws Exception;
	
	public List<BoardVO> listSearch(SearchCriteria cri) throws Exception;
	
}
