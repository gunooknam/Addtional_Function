package com.kwce.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.kwce.dao.BoardDAO;
import com.kwce.dao.ReplyDAO;
import com.kwce.domain.Criteria;
import com.kwce.domain.ReplyVO;


@Service  //���񽺸� �����ϴ� Ŭ�������ٰ��� @Service��� �ֳ����̼� ����
public class ReplyServiceImpl implements ReplyService{
	
	@Inject 
	private ReplyDAO dao;
	
	@Inject 
	private BoardDAO bdao;
	
	@Override
	public void addReply(ReplyVO vo) throws Exception {
		// TODO Auto-generated method stub
		dao.create(vo);
		bdao.updateReplyCnt(vo.getBno(), 1);
	}
	@Override
	public List<ReplyVO> listReply(Integer bno) throws Exception {
		// TODO Auto-generated method stub
		return dao.list(bno);
	}
	@Override
	public void modifyReply(ReplyVO vo) throws Exception {
		// TODO Auto-generated method stub
		dao.update(vo);
	}
	@Override
	public void removeReply(Integer rno) throws Exception {
		// TODO Auto-generated method stub
		int bno = dao.getBno(rno);
		dao.delete(rno);
		bdao.updateReplyCnt(bno, -1);
	}
	@Override
	public List<ReplyVO> listReplyPage(Integer bno, Criteria cri) throws Exception {
		// TODO Auto-generated method stub
		return dao.listPage(bno, cri);
	}
	@Override
	public int count(Integer bno) throws Exception {
		// TODO Auto-generated method stub
		return dao.count(bno);
	}
}