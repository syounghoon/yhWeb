 package com.filmee.myapp.service;

import java.util.List;
import java.util.Objects;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.filmee.myapp.domain.ReviewCommentUserVO;
import com.filmee.myapp.domain.ReviewCommentVO;
import com.filmee.myapp.mapper.ReviewCommentMapper;
import com.filmee.myapp.mapper.ReviewMapper;

import lombok.NoArgsConstructor;
import lombok.extern.log4j.Log4j2;

@Log4j2 
@NoArgsConstructor

@Service 
public class ReviewCommentServiceImpl implements ReviewCommentService {
	
	@Autowired private ReviewCommentMapper mapper;
	@Autowired private ReviewMapper rmapper;

	@Override
	public List<ReviewCommentUserVO> getList(Integer rno) {
		log.debug(" >> list({}) invoked.", rno);
		Objects.requireNonNull(this.mapper);
		
		return this.mapper.list(rno);
	}

	@Override
	public ReviewCommentVO get(Integer rcno) {
		log.debug(" >> get({}) invoked.", rcno);
		log.debug("get({}) invoked.");
		Objects.requireNonNull(this.mapper);

		return this.mapper.read(rcno);
	}//get

	@Override
	public int register(ReviewCommentVO vo) {
		log.debug(" >> register({}) invoked.", vo);
		Objects.requireNonNull(this.mapper);
		this.rmapper.commentCnt(vo.getRno(), 1);
		
		return this.mapper.insert(vo);
	}//register

	@Override
	public int modify(ReviewCommentVO vo) {
		log.debug(" >> ReviewCommentVO({}) invoked.", vo);
		Objects.requireNonNull(this.mapper);
		
		return this.mapper.update(vo);
	}//modify

	@Override
	public int remove(Integer rcno) {
		log.debug(" >> remove({}) invoked.", rcno);
		Objects.requireNonNull(this.mapper);
		ReviewCommentVO vo = this.mapper.read(rcno);
		this.rmapper.commentCnt(vo.getRno(), -1);
		
		return this.mapper.delete(rcno);
	}//remove

}//end class