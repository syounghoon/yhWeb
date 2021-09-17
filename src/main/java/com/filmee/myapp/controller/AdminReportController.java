package com.filmee.myapp.controller;

import java.util.List;

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
import org.springframework.web.bind.annotation.RequestParam;

import com.filmee.myapp.domain.BoardCommentVO;
import com.filmee.myapp.domain.CriteriaReport;
import com.filmee.myapp.domain.ReportPageDTO;
import com.filmee.myapp.domain.ReportVO;
import com.filmee.myapp.service.ReportService;

import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j2;

@Log4j2
@NoArgsConstructor

@Controller
@RequestMapping("/admin/report")
public class AdminReportController {
	
	@Setter(onMethod_=@Autowired)
	private ReportService service;
	
	@GetMapping("/list")
	public String getList(@ModelAttribute("cri")CriteriaReport cri, Model model) {
		log.debug(">> report list () invoked.");
		
		List<ReportVO> list = this.service.getList(cri);
		ReportPageDTO page = new ReportPageDTO(cri, this.service.getTotal(cri));
		
		model.addAttribute("list",list);
		model.addAttribute("pageMaker",page);
		
		return "admin/report/list";
	}//board

	@PostMapping(
			value="complete/{rptno}/{mgr_id}",
			produces= {MediaType.TEXT_PLAIN_VALUE}
			)
	public ResponseEntity<String> complete(@PathVariable("rptno")Integer rptno, @PathVariable("mgr_id")Integer mgr_id) {
		log.debug("complete({},{}) invoked.",rptno, mgr_id);
		
		int aLine = this.service.complete(rptno,mgr_id);		
		
		return aLine == 1 ?
				new ResponseEntity<>("success", HttpStatus.OK) : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);		
	}//reportRegister

}
