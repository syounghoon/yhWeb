package com.filmee.myapp.controller;

import java.util.List;
import java.util.Objects;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.filmee.myapp.domain.CriteriaFilmReview;
import com.filmee.myapp.domain.CriteriaReview;
import com.filmee.myapp.domain.FilmGenreVO;
import com.filmee.myapp.domain.FilmPeopleVO;
import com.filmee.myapp.domain.FilmVO;
import com.filmee.myapp.domain.ReportVO;
import com.filmee.myapp.domain.ReviewCommentUserVO;
import com.filmee.myapp.domain.ReviewCommentVO;
import com.filmee.myapp.domain.ReviewDTO;
import com.filmee.myapp.domain.ReviewFilmUserVO;
import com.filmee.myapp.domain.ReviewPageDTO;
import com.filmee.myapp.domain.UserVO;
import com.filmee.myapp.service.FilmService;
import com.filmee.myapp.service.ReportService;
import com.filmee.myapp.service.ReviewCommentService;

import lombok.NoArgsConstructor;
import lombok.extern.log4j.Log4j2;

@Log4j2
@NoArgsConstructor

@RequestMapping("/film/")
@Controller
public class FilmController {

	
	@Autowired private FilmService service;  // ReviewService에 있을 내용은 모두 FilmService에 있음 
	@Autowired private ReviewCommentService rcService;
	@Autowired private ReportService rService;


//	@GetMapping("info")
//	public String getFilmInfo(@RequestParam("filmid") Integer film_id, Model model) {
	@GetMapping("/{filmid}")
	public String getFilmInfo(@PathVariable("filmid") Integer film_id, Integer rno, Model model) {
		log.debug("getFilmInfo({}, {}, {}) invoked.", film_id, rno, model);

		FilmVO filmVO = this.service.getFilmInfo(film_id);
		List<FilmPeopleVO> filmPeopleVOList = this.service.getFilmPeople(film_id);
		List<FilmGenreVO> filmGenreVOList = this.service.getGenre(film_id);
		List<ReviewFilmUserVO> reviewFilmUserVOList = this.service.getList(film_id);

		assert filmVO != null;
		assert filmPeopleVOList != null;
		assert filmGenreVOList != null;
		assert reviewFilmUserVOList != null;

		// 일단 막아둠
//		log.info("\t+ filmVO: {}", filmVO);
//		filmPeopleVOList.forEach(log::info);
//		filmGenreVOList.forEach(log::info);
//		reviewFilmUserVOList.forEach(log::info);

		model.addAttribute("filmVO", filmVO);
		model.addAttribute("filmPeopleVOList", filmPeopleVOList);
		model.addAttribute("filmGenreVOList", filmGenreVOList);
		model.addAttribute("reviewFilmUserVOList", reviewFilmUserVOList);

		return "film";
	} // getFilmInfo

	// ----------------------------------------------------//

	@GetMapping({"/{filmid}/review/{rno}"})  
	public String getReview(@PathVariable("filmid") Integer film_id, @PathVariable("rno") Integer rno,
			@SessionAttribute(value="__LOGIN__", required=false) UserVO user,
			@ModelAttribute("cri") CriteriaFilmReview cri, Model model) {
		log.debug("readReview({}, {}) invoked.", rno, model);

		ReviewFilmUserVO reviewFilmUserVO = this.service.get(rno);		
		List<ReviewCommentUserVO> reviewCommentList = this.rcService.getList(rno);

		assert reviewFilmUserVO != null;
		log.info("\t+ reviewFilmUserVO: {}", reviewFilmUserVO);
		
		
//		if(user!=null) {
//			heart.setBno(bno);
//			heart.setUserid(user.getUserId());
//			if(this.hService.check(bno, user.getUserId())==null) {
//				int aLine = this.hService.heartInsert(heart);
//				log.info(">>>>>>> heartInsert : "+heart);
//				log.info(">>>>>>> Result : "+aLine);
//				heart=this.hService.check(bno, user.getUserId());
//				model.addAttribute("heart", heart);			
//			} else {
//				heart=this.hService.check(bno, user.getUserId());
//				model.addAttribute("heart", heart);			
//			}
//		}
		
		
		model.addAttribute("reviewFilmUserVO", reviewFilmUserVO);
		model.addAttribute("reviewCommentList", reviewCommentList);

		return "review/get";
	} // getReview
	
	
	
	
	@GetMapping({"/{filmid}/review/m/{rno}/"})  
	public String modifyReview(@PathVariable("filmid") Integer film_id, @PathVariable("rno") Integer rno,
//			@SessionAttribute(value="__LOGIN__", required=false) UserVO user,
			@ModelAttribute("cri") CriteriaFilmReview cri, Model model) {
		log.debug("readReview({}, {}) invoked.", rno, model);

		ReviewFilmUserVO reviewFilmUserVO = this.service.get(rno);

		assert reviewFilmUserVO != null;
		log.info("\t+ reviewFilmUserVO: {}", reviewFilmUserVO);

		model.addAttribute("reviewFilmUserVO", reviewFilmUserVO);

		return "review/modify";
	} // getReview


	@PostMapping("/{filmid}/review/register")
	public String register(@PathVariable("filmid") Integer film_id, 
							@ModelAttribute("reviewCri") CriteriaFilmReview cri,
							ReviewDTO review, 
							HttpSession session,
							UserVO user,
							RedirectAttributes rttrs) {
		log.debug("register({}, {}, {}, {}) invoked.", film_id, cri, review, rttrs);

		this.service.register(review);
		

		rttrs.addFlashAttribute("result", review.getRno());

//		return "redirect:/film/" + filmIdPath; // 리뷰쓴 영화의 상세페이지나, 마이페이지의 리뷰페이지로 redirect
		return "redirect:/film/{filmid}";
	} // registerReview

	@GetMapping("/{filmid}/review/register")
	public String register(@PathVariable("filmid") Integer film_id,							
							@ModelAttribute("reviewCri") CriteriaFilmReview cri, 
							Model model) {
		log.debug("register({}, {}) invoked.", film_id, cri);
		
		FilmVO filmVO = this.service.getFilmInfo(film_id);
		

		model.addAttribute("filmVO", filmVO);

		return "review/register";
	} // register

//	@GetMapping("list")
//	public void getReviewList(Integer film_id, Model model) {
//		log.debug("list({}) invoked.", model);
//		
//		List<ReviewVO> reviewList = this.service.getList(film_id);
//		
//		Objects.requireNonNull(reviewList);
//		reviewList.forEach(log::info);
//		
//		model.addAttribute("reviewList", reviewList);
//	} // getReviewList

	
	@PostMapping("review/remove")
	public String remove(@ModelAttribute("criR")CriteriaReview criR, Integer rno, RedirectAttributes rttrs) {
		log.debug("remove({}, {}) invoked.", rno, rttrs);
		
		int removed = this.service.remove(rno);
			
		rttrs.addAttribute("userid", criR.getUserid());		
		rttrs.addAttribute("currPage", criR.getCurrPage());
		rttrs.addAttribute("amount", criR.getAmount());
		rttrs.addAttribute("pagesPerPage", criR.getPagesPerPage());
		
		return "redirect:/mypage/myreviews";
	} //deleteMyReview
	
	
	@PostMapping("review/modify")
	public String modify(
			@ModelAttribute("cri") CriteriaFilmReview criFR,
			ReviewDTO review,
			RedirectAttributes rttrs) {
		log.debug("modifyReview({}, {}) invoked.", review, rttrs);
		
		int modifiedReview = this.service.modify(review);
		
		if(modifiedReview == 1) {
			rttrs.addFlashAttribute("result", "success");
		} // if
		
		rttrs.addAttribute("currPage", criFR.getCurrPage());
		rttrs.addAttribute("amount", criFR.getAmount());
		rttrs.addAttribute("pagesPerPage", criFR.getPagesPerPage());
		
		return "redirect:/mypage/myreviews";
	} //modify
	
	@GetMapping("listPerPage")
	public String listPerPage(
			@ModelAttribute("cri")
			CriteriaFilmReview criFR,
			Integer film_id,
			Model model
		) {
		log.debug("listPerPage({}) invoked.", model);
		
		List<ReviewFilmUserVO> reviewList = this.service.getListWithPaging(criFR);
		
		Objects.requireNonNull(reviewList);
		reviewList.forEach(log::info);
		
		ReviewPageDTO pageDTO = new ReviewPageDTO(criFR, this.service.getTotalCount(film_id, criFR));
		
		model.addAttribute("reviewList", reviewList);
		model.addAttribute("pageMaker", pageDTO);
		
		return "film/list";
	} // listPerPage
	
	
		// 좋아요
		@PostMapping("like/{rno}/{userid}")
		public ResponseEntity<String> likeIt( 
				@PathVariable("rno") int rno,
				@PathVariable("userid") int userid
			){
			log.debug("likeIt({},{}) invoked.", rno,userid);
			
			int aLine = this.service.likeCheck(rno, userid);
			
			return aLine == 1 ?
					new ResponseEntity<>("success", HttpStatus.OK) : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}//likeIt
		
		//좋아요 취소
		@PostMapping("unlike/{rno}/{userid}")
		public ResponseEntity<String> unLike(
				@PathVariable("rno") int rno,
				@PathVariable("userid") int userid
				){
			log.debug("unLike({},{}) invoked.", rno,userid);
			
			int aLine = this.service.likeUncheck(rno, userid);
			
			return aLine == 1 ?
					new ResponseEntity<>("success", HttpStatus.OK) : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}//unLike
		
		//===========//
		// 댓글처리영역  //
		//===========//
		
		//------- 등 록 -------//
		@PostMapping(
				value="replies/new",
				consumes="application/json",			//JSON 데이터사용
				produces= {MediaType.TEXT_PLAIN_VALUE})
		public ResponseEntity<String> create(@RequestBody ReviewCommentVO vo){	//@RequestBody :> JSON->BoardCommentVO
			log.debug("create({}) invoked.",vo);
			
			int affectedLines = this.rcService.register(vo);
			return affectedLines ==1 ? 
					new ResponseEntity<>("success",HttpStatus.OK) : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}//create
		
		//------- 목록조회 -------//
		@GetMapping(
				value="replies/pages/{rno}/{page}",
				produces= {
//						MediaType.APPLICATION_XML_VALUE,
						MediaType.APPLICATION_JSON_VALUE 
				})
		public ResponseEntity<List<ReviewCommentUserVO>> getList(
				@PathVariable("rno") int rno
				){
			log.debug("getList({}) invoked.",rno);

			 
			return new ResponseEntity<>(this.rcService.getList(rno), HttpStatus.OK);
		}//getList

		//------- 상세조회 -------//
		@GetMapping(
				value="replies/{rcno}",
				produces= {
//						MediaType.APPLICATION_XML_VALUE,
						MediaType.APPLICATION_JSON_VALUE
				})
		public ResponseEntity<ReviewCommentVO> get(@PathVariable("rcno") Integer rcno){
			log.debug("get({}) invoked.",rcno);
			
			return new ResponseEntity<>(this.rcService.get(rcno), HttpStatus.OK);
		}//get

		//------- 삭제 -------//
		@PostMapping(
				value="replies/{rcno}",
				produces= {
						MediaType.TEXT_PLAIN_VALUE
				})
		public ResponseEntity<String> remove(@PathVariable("rcno") int rcno){
			log.debug("remove({}) invoked.",rcno);
			
			return this.rcService.remove(rcno) == 1 ? 
					new ResponseEntity<>("success", HttpStatus.OK) : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}//remove

		//------- 수정 -------//
		@RequestMapping(
				method= {RequestMethod.PUT, RequestMethod.PATCH},
				value="replies/{rcno}",
				consumes="application/json",
				produces= {MediaType.TEXT_PLAIN_VALUE}
				)
		public ResponseEntity<String> modify( 
				@RequestBody ReviewCommentVO vo,
				@PathVariable("rcno") int rcno)
				{
			log.debug("modify({},{}) invoked.", vo, rcno);
			
			vo.setRcno(rcno);
			return this.rcService.modify(vo) == 1 ?
					new ResponseEntity<>("success", HttpStatus.OK) : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}//modify
		
		
		@PostMapping(
				value="report",
				consumes="application/json",
				produces= {MediaType.TEXT_PLAIN_VALUE})
		public ResponseEntity<String> reportRegister(@RequestBody ReportVO report) {
			log.debug("reportRegister({},report) invoked.");
			
			int aLine = this.rService.reportRegister(report);
			
			return aLine == 1 ?
					new ResponseEntity<>("success", HttpStatus.OK) : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);		
		}//reportRegister
} // end class