package com.filmee.myapp.service;


import java.util.List;
import java.util.Objects;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.filmee.myapp.domain.CriteriaSearch;
import com.filmee.myapp.domain.SearchFilmGenreVO;
import com.filmee.myapp.domain.SearchFilmInfoVO;
import com.filmee.myapp.domain.SearchFilmVO;
import com.filmee.myapp.domain.SearchUserVO;
import com.filmee.myapp.mapper.SearchMapper;

import lombok.NoArgsConstructor;
import lombok.extern.log4j.Log4j2;


@Log4j2
@NoArgsConstructor

@Service
public class SearchServiceImpl implements SearchService {
	
	@Autowired
	private SearchMapper mapper;

	@Override
	public List<SearchFilmVO> searchFilmAutoComplete(String filmTitle) {
		log.debug("searchFilmAutoComplete({}) invoked.", filmTitle);
		
		Objects.requireNonNull(this.mapper);
		
		return this.mapper.getFilmList(filmTitle);
	} //searchFilmAutoComplete
	
	@Override
	public List<SearchUserVO> searchUserAutoComplete(String nickname) {
		log.debug("searchUserAutoComplete({}) invoked.", nickname);
		
		Objects.requireNonNull(this.mapper);
		
		return this.mapper.getUserList(nickname);
	} //searchUserAutoComplete
	
	@Override
	public List<SearchFilmVO> getFilmListPage(CriteriaSearch cri) {
		log.debug("getFilmListPage({}) invoked.", cri);
		
		Objects.requireNonNull(this.mapper);
		
		return this.mapper.getFilmListPage(cri);
	} //getFilmListPage

	@Override
	public List<SearchFilmInfoVO> getFilmListInfo(CriteriaSearch cri) {
		log.debug("getFilmListInfo({}) invoked.", cri);
		
		Objects.requireNonNull(this.mapper);
		
		return this.mapper.getFilmListInfo(cri);
	} //getFilmListInfo
	
	@Override
	public List<SearchFilmGenreVO> getFilmListGenre(CriteriaSearch cri) {
		log.debug("getFilmListGenre({}) invoked.", cri);
		
		Objects.requireNonNull(this.mapper);
		
		return this.mapper.getFilmListGenre(cri);
	} //getFilmListGenre

	@Override
	public List<SearchUserVO> getUserListPage(CriteriaSearch cri) {
		log.debug("getUserListPage({}) invoked.", cri);
		
		Objects.requireNonNull(this.mapper);
		
		return this.mapper.getUserListPage(cri);
	} //getUserListPage

	@Override
	public int getTotalCountFilmSearch(CriteriaSearch cri) {
		log.debug("getTotalCountFilmSearch({}) invoked.", cri);
		
		Objects.requireNonNull(this.mapper);
		
		return this.mapper.getTotalCountFilmSearch(cri);
	} //getTotalCountFilmSearch

	@Override
	public int getTotalCountUserSearch(CriteriaSearch cri) {
		log.debug("getTotalCountUserSearch({}) invoked.", cri);
		
		Objects.requireNonNull(this.mapper);
		
		return this.mapper.getTotalCountUserSearch(cri);
	} //getTotalCountUserSearch

} //end class
