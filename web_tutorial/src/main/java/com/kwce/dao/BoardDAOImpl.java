package com.kwce.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import com.kwce.domain.BoardVO;
import com.kwce.domain.Criteria;
import com.kwce.domain.SearchCriteria;

@Repository
public class BoardDAOImpl implements BoardDAO{

	@Autowired
	private SqlSession session;
	private static String namespace="com.kwce.mapper.BoardMapper";
	
	@Override
	public void create(BoardVO vo) throws Exception {
		session.insert(namespace+".create",vo);
	}
	@Override
	public BoardVO read(Integer bno) throws Exception {
		return session.selectOne(namespace+".read",bno);
	}
	@Override
	public void update(BoardVO vo) throws Exception {
		session.update(namespace + ".update",vo);
	}
	@Override
	public void delete(Integer bno) throws Exception {
		session.delete(namespace+".delete",bno);
	}
	@Override
	public List<BoardVO> listAll() throws Exception {
		return session.selectList(namespace+".listAll");
	}
	@Override
	public List<BoardVO> listSearch(SearchCriteria cri) throws Exception {
		// TODO Auto-generated method stub
		return session.selectList(namespace + ".listSearch", cri);
	}
	
	/*@Override
	public List<BoardVO> listPage(int page, int pageNum) throws Exception {
		// TODO Auto-generated method stub
		// 일단 대기
		if(page <= 0)
			page = 1;
		
		page = (page - 1)*10;
		
		return session.selectList(namespace+".listPage", page);
	}*/
	
	@Override
	public List<BoardVO> listCriteria(Criteria cri) throws Exception {
		return session.selectList(namespace+".listPageCriteria", cri);
	}
	
	@Override
	public int countPaging() throws Exception {
		// TODO Auto-generated method stub
		return session.selectOne(namespace+ ".countPaging");
	}

}
