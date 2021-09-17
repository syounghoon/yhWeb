package com.filmee.myapp.service;

import java.util.List;
import java.util.Objects;

import org.springframework.stereotype.Service;

import com.filmee.myapp.domain.CriteriaFilmReview;
import com.filmee.myapp.domain.FilmGenreVO;
import com.filmee.myapp.domain.FilmPeopleVO;
import com.filmee.myapp.domain.FilmVO;
import com.filmee.myapp.domain.ReviewDTO;
import com.filmee.myapp.domain.ReviewFilmUserVO;
import com.filmee.myapp.mapper.FilmMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j2;

@Log4j2
@AllArgsConstructor

@Service
public class FilmServiceImpl implements FilmService {

	private FilmMapper mapper;



	@Override
	public FilmVO getFilmInfo(Integer film_id) {
		log.debug("getFilmInfo({}) invoked.", film_id);

		Objects.requireNonNull(this.mapper);

		return this.mapper.selectFilmInfo(film_id);
	} // getFilmInfo

	@Override
	public List<FilmPeopleVO> getFilmPeople(Integer film_id) {
		log.debug("getFilmPeople({}) invoked.", film_id);

		Objects.requireNonNull(this.mapper);

		return this.mapper.selectFilmPeople(film_id);
	} // getFilmPeople

	@Override
	public List<FilmGenreVO> getGenre(Integer film_id) {
		log.debug("getGenre({}) invoked.", film_id);

		Objects.requireNonNull(this.mapper);

		return this.mapper.selectGenre(film_id);
	}

	// ---------------------------------------------------------//

	@Override
	public int register(ReviewDTO review) {
		log.debug("register({}) invoked.", review);

		Objects.requireNonNull(this.mapper);
		return  this.mapper.insert(review);
	} // register

	@Override
	public ReviewFilmUserVO get(Integer rno) {
		log.debug("get({}) invoked.", rno);

		Objects.requireNonNull(this.mapper);
		return this.mapper.select(rno);
		
	} // get

	@Override
	public List<ReviewFilmUserVO> getList(Integer film_id) {
		log.debug("getList({}) invoked.", film_id);

		Objects.requireNonNull(this.mapper);
		return this.mapper.selectList(film_id);
	} // getList

	@Override
	public int remove(Integer rno) {
		log.debug("remove({}) invoked.", rno);

		Objects.requireNonNull(this.mapper);
		return this.mapper.delete(rno);
	} // remove

	@Override
	public int modify(ReviewDTO review) {
		log.debug("modify({}) invoked.", review);
		
		Objects.requireNonNull(this.mapper);
		return this.mapper.update(review);
	} // modify

	@Override
	public List<ReviewFilmUserVO> getListWithPaging(CriteriaFilmReview cri) {
		log.debug("getListWithPaging({}, {}) invoked.",  cri);
		
		Objects.requireNonNull(this.mapper);
		return this.mapper.selectListWithPaging(cri);
	} // getListWithPaging

	@Override
	public int getTotalCount(Integer film_id, CriteriaFilmReview cri) {
		log.debug("getTotalCount({}, {}) invoked.", cri);
		
		Objects.requireNonNull(this.mapper);
		return this.mapper.selectTotalCount(film_id, cri);
	}

	
	// 리뷰 좋아요 
	@Override
	public int likeInsert(ReviewFilmUserVO vo) {
		log.info("-------------------------------------");
		log.debug(">> likeInsert({})invoked.", vo);
		Objects.requireNonNull(this.mapper);
				
		return this.mapper.likeInsert(vo);
	}//likeinsert
	
	
	@Override
	public int likeCheck(Integer rno, Integer userid) {
		log.info("-------------------------------------");
		log.debug(">> likeCheck({},{})invoked.", rno,userid);
		Objects.requireNonNull(this.mapper);
		
		this.mapper.likeCnt(rno, 1);
		
		return this.mapper.likeCheck(rno, userid);
	}//likeCheck
	
	@Override
	public void likeCheckTotal(Integer rno) {
		log.info("-------------------------------------");
		log.debug(">> likeCheckTotal({})invoked.", rno);
		
		Objects.requireNonNull(this.mapper);
		
		this.mapper.likeCheckTotal(rno);
	
	}//likeCheckTotal
	
	@Override
	public int likeUncheck(Integer rno, Integer userid) {
		log.info("-------------------------------------");
		log.debug(">> likeUncheck({},{})invoked.", rno,userid);
		Objects.requireNonNull(this.mapper);
		
		this.mapper.likeCnt(rno, -1);
		
		return this.mapper.likeUncheck(rno, userid);
	}//likeUncheck
	
	
	@Override
	public ReviewFilmUserVO check(Integer rno, Integer userid) {
		log.info("-------------------------------------");
		log.debug(">> check({},{})invoked.", rno,userid);
		Objects.requireNonNull(this.mapper);
		
		return this.mapper.check(rno, userid);
	}


	@Override
	public int likeCnt(Integer rno) {
		log.info("-------------------------------------");
		log.debug(">> check({})invoked.", rno);
				
		return this.mapper.likeCnt(rno);

	} // likeCnt



} // end class