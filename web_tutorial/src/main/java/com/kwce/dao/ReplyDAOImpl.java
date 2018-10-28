package com.kwce.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.kwce.domain.Criteria;
import com.kwce.domain.ReplyVO;

@Repository  //DAO Ŭ���� ���ٰ� Repository��� �ֳ����̼� ������ ��
public class ReplyDAOImpl implements ReplyDAO{
	
	@Inject
	private SqlSession session;
	private static String namespace = "com.kwce.mapper.ReplyMapper";
	
	@Override
	public List<ReplyVO> list(Integer bno) throws Exception {
		// TODO Auto-generated method stub
		return session.selectList(namespace + ".list", bno);
	}
	@Override
	public void create(ReplyVO vo) throws Exception {
		// TODO Auto-generated method stub
		session.insert(namespace+".create",vo);
		
	}
	@Override
	public void update(ReplyVO vo) throws Exception {
		// TODO Auto-generated method stub
		session.update(namespace+ ".update", vo);
	}
	@Override
	public void delete(Integer rno) throws Exception {
		// TODO Auto-generated method stub
		session.delete(namespace + ".delete", rno);
	}
	@Override
	public List<ReplyVO> listPage(Integer bno, Criteria cri) throws Exception {
		// Map 에다가 bno와 cri를 담는다. 
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("bno", bno);
		paramMap.put("cri", cri);
		// 인자를 Object 형태로 담았다. 맵형태로 담았다는 점=> !!!!!!! 그렇게 한 경우 
		// key.getPageStart로 xml에서 사용가능
		return session.selectList(namespace + ".listPage", paramMap);
	}
	@Override
	public int count(Integer bno) throws Exception {
		// TODO Auto-generated method stub
		return session.selectOne(namespace + ".count", bno);
	}


}
