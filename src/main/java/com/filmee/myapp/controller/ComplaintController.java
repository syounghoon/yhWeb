package com.filmee.myapp.controller;

import java.util.List;
import java.util.Objects;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.InitializingBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.filmee.myapp.domain.ComCriteria;
import com.filmee.myapp.domain.ComPageDTO;
import com.filmee.myapp.domain.ComplaintVO;
import com.filmee.myapp.domain.UserVO;
import com.filmee.myapp.service.ComplaintService;
import com.filmee.myapp.service.LoginService;
import com.filmee.myapp.service.MailSendService;

import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j2;

@Log4j2
@NoArgsConstructor

@RequestMapping("/complaint/")
@Controller
public class ComplaintController
   implements InitializingBean{
	
	@Setter(onMethod_=@Autowired)
	private LoginService loginService;
	
	@Setter(onMethod_= @Autowired)
	private MailSendService mailSend;
	
   @Setter(onMethod_= @Autowired)
   private ComplaintService service;
   
   @Override
   public void afterPropertiesSet() throws Exception {
	   log.debug("afterPropertiesSet() invoked.");
	   
	   Objects .requireNonNull(service);
	   
	   log.info("\t+ service : {}", service);
	   
   }//afterPropertiesSet
     

   
   @PostMapping("register")
   public String register(
		   ComplaintVO complaint,
		   RedirectAttributes rttrs,
		   HttpServletRequest request
		   ) {
	   log.debug("register({},{}) invoked", complaint,rttrs) ;
	   
	   
	   boolean isRegister = this.service.register(complaint);
	   String referer = (String)request.getHeader("REFERER");
	   
		if(isRegister) {	//?????? ????????? ???
			rttrs.addFlashAttribute("comResult", "????????????");
		}//if
     return "redirect:"+referer;
   }//regeister
   
  

   @GetMapping("listPerPage")
	public String listPerPage(
			@ModelAttribute("cri")	// ????????? ??????????????? model.addAttribute??? ?????? ??????. ????????? cri
			ComCriteria cri,	//command object -> ???????????? request scope??? ????????????. ????????? criteria
			Model model
			) {
		log.debug("listPerPage({},{}) invoked.",cri, model);
		
		List<ComplaintVO> complaint = this.service.getListPerPage(cri);
		
		Objects.requireNonNull(complaint);
		
		ComPageDTO pageDTO = new ComPageDTO(cri,this.service.getTotal(cri));
		
		model.addAttribute("list", complaint);
		model.addAttribute("pageMaker", pageDTO);
		
		return "complaint/comList";
	}//listPerPAge
	
	@GetMapping( "get" )
	public String get(
			@ModelAttribute("cri") ComCriteria cri,
			@RequestParam("compno") Integer compno, 
			Model model
			) {
		log.debug("get({}, {}, {}) invoked.", cri, compno, model);
		
		ComplaintVO complaint = this.service.get(compno);
		
		assert complaint != null;
		
		log.info("\t+ get : {}", complaint);

		model.addAttribute("complaint", complaint);

		return "complaint/comGet";
	}//get
	
	@PostMapping("temporary")
	public String temporaryUpdate(
			@ModelAttribute("cri") ComCriteria cri,
			ComplaintVO complaint,
			RedirectAttributes rttrs
			) {
		log.debug("temporary({}, {}, {}) invoked.", cri, complaint, rttrs);
		

		boolean isTemporary = this.service.temporaryUpdate(complaint);


		if(isTemporary == false) {
			log.info("=====================================================");
			log.info("\t+isTemporary:{}",isTemporary);
			log.info("=====================================================");
			rttrs.addFlashAttribute("comResult", "?????? ????????? ?????????????????????.");
		}

		rttrs.addAttribute("currPage", cri.getCurrPage());
		rttrs.addAttribute("amount", cri.getAmount());
		rttrs.addAttribute("pagesPerPage", cri.getPagesPerPage());

		return "redirect:/complaint/listPerPage";
	}
	
	@PostMapping("completion")
	public String completion(
			@ModelAttribute("cri") ComCriteria cri,
			ComplaintVO complaint,
			RedirectAttributes rttrs
			) throws Exception {
		log.debug("completion({}, {}, {},{}) invoked.", cri, complaint, rttrs);

		boolean isCompletion = this.service.completion( complaint);
		log.info("=====================================================");
		log.info("\t+isCompletion:{}",isCompletion);
		log.info("=====================================================");
		if(isCompletion == false) {
			rttrs.addFlashAttribute("comResult", "?????? ????????? ?????????????????????.");
		}
				
		rttrs.addAttribute("currPage", cri.getCurrPage());
		rttrs.addAttribute("amount", cri.getAmount());
		rttrs.addAttribute("pagesPerPage", cri.getPagesPerPage());

		return "redirect:/complaint/listPerPage";
	}

}