package com.filmee.myapp.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.List;
import java.util.Objects;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FilenameUtils;
import org.apache.commons.lang3.RandomStringUtils;
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
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.filmee.myapp.domain.BoardCommentUserVO;
import com.filmee.myapp.domain.BoardCommentVO;
import com.filmee.myapp.domain.BoardPageDTO;
import com.filmee.myapp.domain.BoardUserVO;
import com.filmee.myapp.domain.BoardVO;
import com.filmee.myapp.domain.Criteria;
import com.filmee.myapp.domain.FileVO;
import com.filmee.myapp.domain.HeartVO;
import com.filmee.myapp.domain.ReportVO;
import com.filmee.myapp.domain.UserVO;
import com.filmee.myapp.service.BoardCommentService;
import com.filmee.myapp.service.BoardService;
import com.filmee.myapp.service.HeartService;
import com.filmee.myapp.service.ReportService;

import lombok.NoArgsConstructor;
import lombok.extern.log4j.Log4j2;

@Log4j2
@NoArgsConstructor

@RequestMapping("/board/")
@Controller
public class BoardController { 

	@Autowired private BoardService service;
	@Autowired private BoardCommentService cService;
	@Autowired private HeartService hService;
	@Autowired private ReportService rService;
	
	//게시글 전체 목록조회
	@GetMapping("list")
	public String list(@ModelAttribute("cri")Criteria cri, Model model
			) {
		log.debug("list({},{}) invoked.",cri,model);
		Objects.requireNonNull(service);

		List<BoardUserVO> list = this.service.getList(cri);
		
		BoardPageDTO page = new BoardPageDTO(cri, this.service.getTotal(cri));
		model.addAttribute("list",list);
		model.addAttribute("pageMaker",page);
		return "board/list";
	}//list
	
	
	//게시글 수정
	@PostMapping("modify")
	public String modify(@ModelAttribute("cri")Criteria cri,BoardVO board, RedirectAttributes rttrs) {
		log.debug(" >>> modify({},{},{}) invoked.",cri,board,rttrs);
		Objects.requireNonNull(service);
		
		boolean isModified = this.service.modify(board);

		if(isModified) {
			log.info(">> if> ismodified");
			rttrs.addAttribute("result","modified");
		}//if
		rttrs.addAttribute("currPage",cri.getCurrPage());
		rttrs.addAttribute("amount",cri.getAmount());
		rttrs.addAttribute("pagesPerPage",cri.getPagesPerPage());
		
		return "redirect:/board/list";
	}//modify
	
	//게시글 상세조회(댓글리스트 추가)
	@GetMapping({"get","modify"})
	public void get(
			@ModelAttribute("cri") Criteria cri, 
			@RequestParam(value="bno") Integer bno,
			@SessionAttribute(value="__LOGIN__", required=false) UserVO user,
			FileVO fileVO,
			HeartVO heart,
			Model model
			) {
		log.debug("================================================================================");
		log.debug("get({},{},{},{},{})invoked.",cri,bno,fileVO,model);
		Objects.requireNonNull(service);
		
		BoardUserVO board = this.service.get(bno);
		fileVO = this.service.fileDetail(bno);
		List<BoardCommentUserVO> comment = this.cService.getList(bno);
		
		if(user!=null) {
			heart.setBno(bno);
			heart.setUserid(user.getUserId());
			if(this.hService.check(bno, user.getUserId())==null) {
				int aLine = this.hService.heartInsert(heart);
				log.info(">>>>>>> heartInsert : "+heart);
				log.info(">>>>>>> Result : "+aLine);
				heart=this.hService.check(bno, user.getUserId());
				model.addAttribute("heart", heart);			
			} else {
				heart=this.hService.check(bno, user.getUserId());
				model.addAttribute("heart", heart);			
			}
		}
			
		model.addAttribute("board",board);
		model.addAttribute("file", fileVO);
		model.addAttribute("comment", comment);
		
	}//get
	
	//파일 다운로드
	@RequestMapping("/downloadFile/{bno}")
    private String fileDown(
    		@PathVariable int bno, 
    		HttpServletRequest request, 
    		HttpServletResponse response,
    		@ModelAttribute("cri") Criteria cri
    		) throws Exception{
    log.debug(" >> fileDown() invoked.");
        request.setCharacterEncoding("UTF-8");
        FileVO fileVO = this.service.fileDetail(bno);
        
        try{
            String fileUrl = fileVO.getPath();
            fileUrl += "/";
            String savePath = fileUrl;
            String fileName = fileVO.getUuid();
            
            String oriFileName = fileVO.getFname();
            InputStream in = null;
            OutputStream os = null;
            File file = null;
            boolean skip = false;
            String client = "";
            
            try{
                file = new File(savePath, fileName);
                in = new FileInputStream(file);
            } catch (FileNotFoundException fe) {
                skip = true;
            }
            
            client = request.getHeader("User-Agent");
            
            response.reset();
            response.setContentType("application/octet-stream");
            response.setHeader("Content-Description", "JSP Generated Data");
            
            if (!skip) {
                if (client.indexOf("MSIE") != -1) {
                    response.setHeader("Content-Disposition", "attachment; filename=\""
                            + java.net.URLEncoder.encode(oriFileName, "UTF-8").replaceAll("\\+", "\\ ") + "\"");
                } else if (client.indexOf("Trident") != -1) {
                    response.setHeader("Content-Disposition", "attachment; filename=\""
                            + java.net.URLEncoder.encode(oriFileName, "UTF-8").replaceAll("\\+", "\\ ") + "\"");
                } else {
                    response.setHeader("Content-Disposition",
                            "attachment; filename=\"" + new String(oriFileName.getBytes("UTF-8"), "ISO8859_1") + "\"");
                    response.setHeader("Content-Type", "application/octet-stream; charset=utf-8");
                }
                response.setHeader("Content-Length", "" + file.length());
                os = response.getOutputStream();
                byte b[] = new byte[(int) file.length()];
                int leng = 0;
                while ((leng = in.read(b)) > 0) {
                    os.write(b, 0, leng);
                }
            } else {
            	log.info(" 다운로드 실패 ");
                return "redirect:/board/get";
            }
            in.close();
            os.close();
        } catch (Exception e) {
            System.out.println("ERROR : " + e.getMessage());
        }
        return "board/get";
    }

	
	//게시글작성화면
	@GetMapping("register")
	public void register(@ModelAttribute("cri")Criteria cri) {
		log.debug("GetMapping register({}) invoked.",cri);
	}//register
	
	//게시글작성 & 파일업로드
	@PostMapping(path = "register", consumes = {"multipart/form-data"})
	public String register(@ModelAttribute("cri")Criteria cri,  BoardVO board, RedirectAttributes rttrs,
			@RequestPart MultipartFile files) throws IllegalStateException, IOException {
		log.debug("register({},{},{}) invoked",board,rttrs,files);
		Objects.requireNonNull(service); 
		log.info(">> requireNonNull");
		FileVO file = new FileVO();

		rttrs.addAttribute("result",board.getBno());
		rttrs.addAttribute("currPage",cri.getCurrPage());
		rttrs.addAttribute("amount",cri.getAmount());
		rttrs.addAttribute("pagesPerPage",cri.getPagesPerPage());
		rttrs.addAttribute("file", file.getFno());
		
		String fileName=files.getOriginalFilename();
		if(fileName=="") {
			this.service.register(board);
			log.info(">> done if >> register");
		} else {
			this.service.register(board);

			String fileNameExtension=FilenameUtils.getExtension(fileName).toLowerCase();
			File destinationFile;
			String destinationFileName;
			String fileUrl="C:/Temp/upload/";
			String mimeType=files.getContentType();

			do {
	           destinationFileName = RandomStringUtils.randomAlphanumeric(32) + "." + fileNameExtension;
	           destinationFile = new File(fileUrl+ destinationFileName);
	           
	           log.info(" ***** >>> destinationFileName : "+destinationFileName);
	           log.info(" ***** >>> destinationFile : "+destinationFile);
			} while (destinationFile.exists());
	           log.info(" ***** >>> end do");
			
			destinationFile.getParentFile().mkdirs();
			files.transferTo(destinationFile);
			
			file.setBno(board.getBno()+1);
			file.setFname(fileName);
			file.setUuid(destinationFileName);
			file.setPath(fileUrl);
			file.setMime(mimeType);
			
			this.service.fileInsert(file);
		}//if-else

		return "redirect:/board/list";
	}//register
	
	//게시글 삭제
	@PostMapping("remove")
	public String remove(
			@ModelAttribute("cri")Criteria cri,
			@RequestParam("bno") Integer bno, 
			RedirectAttributes rttrs) {
		log.debug("remove({},{},{}) invoked.",cri,bno,rttrs);
		
		if(this.service.remove(bno)) {
			rttrs.addAttribute("result","removed");
		}//if
		rttrs.addAttribute("currPage",cri.getCurrPage());
		rttrs.addAttribute("amount",cri.getAmount());
		rttrs.addAttribute("pagesPerPage",cri.getPagesPerPage());
		
		return "redirect:/board/list";
	}//remove
	

	//===========//
	// 댓글처리영역  //
	//===========//
	
	//------- 등 록 -------//
	@PostMapping(
			value="replies/new",
			consumes="application/json",			//JSON 데이터사용
			produces= {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> create(@RequestBody BoardCommentVO vo){	//@RequestBody :> JSON->BoardCommentVO
		log.debug("create({}) invoked.",vo);
		
		int affectedLines = this.cService.register(vo);
		return affectedLines ==1 ? 
				new ResponseEntity<>("success",HttpStatus.OK) : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}//create
	
	//------- 목록조회 -------//
	@GetMapping(
			value="replies/pages/{bno}/{page}",
			produces= {
//					MediaType.APPLICATION_XML_VALUE,
					MediaType.APPLICATION_JSON_VALUE 
			})
	public ResponseEntity<List<BoardCommentUserVO>> getList(
			@PathVariable("bno") int bno
			){
		log.debug("getList({}) invoked.",bno);

		 
		return new ResponseEntity<>(this.cService.getList(bno), HttpStatus.OK);
	}//getList

	//------- 상세조회 -------//
	@GetMapping(
			value="replies/{bcno}",
			produces= {
//					MediaType.APPLICATION_XML_VALUE,
					MediaType.APPLICATION_JSON_VALUE
			})
	public ResponseEntity<BoardCommentVO> get(@PathVariable("bcno") Integer bcno){
		log.debug("get({}) invoked.",bcno);
		
		return new ResponseEntity<>(this.cService.get(bcno), HttpStatus.OK);
	}//get

	//------- 삭제 -------//
	@PostMapping(
			value="replies/{bcno}",
			produces= {
					MediaType.TEXT_PLAIN_VALUE
			})
	public ResponseEntity<String> remove(@PathVariable("bcno") int bcno){
		log.debug("remove({}) invoked.",bcno);
		
		return this.cService.remove(bcno) == 1 ? 
				new ResponseEntity<>("success", HttpStatus.OK) : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}//remove

	//------- 수정 -------//
	@RequestMapping(
			method= {RequestMethod.PUT, RequestMethod.PATCH},
			value="replies/{bcno}",
			consumes="application/json",
			produces= {MediaType.TEXT_PLAIN_VALUE}
			)
	public ResponseEntity<String> modify( 
			@RequestBody BoardCommentVO vo,
			@PathVariable("bcno") int bcno)
			{
		log.debug("modify({},{}) invoked.", vo, bcno);
		
		vo.setBcno(bcno);
		return this.cService.modify(vo) == 1 ?
				new ResponseEntity<>("success", HttpStatus.OK) : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}//modify
	
	
	//===========//
	// 	* 좋아요   //
	//===========//
	
	// 좋아요
	@PostMapping("like/{bno}/{userid}")
	public ResponseEntity<String> likeIt( 
			@PathVariable("bno") int bno,
			@PathVariable("userid") int userid
		){
		log.debug("likeIt({},{}) invoked.", bno,userid);
		
		int aLine = this.hService.heartCheck(bno, userid);
		
		return aLine == 1 ?
				new ResponseEntity<>("success", HttpStatus.OK) : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}//likeIt
	
	//좋아요 취소
	@PostMapping("unlike/{bno}/{userid}")
	public ResponseEntity<String> unLike(
			@PathVariable("bno") int bno,
			@PathVariable("userid") int userid
			){
		log.debug("unLike({},{}) invoked.", bno,userid);
		
		int aLine = this.hService.heartUncheck(bno, userid);
		
		return aLine == 1 ?
				new ResponseEntity<>("success", HttpStatus.OK) : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}//unLike

//	@PostMapping("like/check/{bno}")
//	public ResponseEntity<String> likeCheck(			
//			@RequestParam(value="bno") Integer bno,
//			@SessionAttribute("__LOGIN__") UserVO user,
//			Model model) {
//		log.debug(">> likeCheck invoked.");
//		
//		HeartVO vo = this.hService.check(bno, user.getUserId());
//		model.addAttribute("heart",vo);
//		
//		return vo != null ?
//				new ResponseEntity<>("success", HttpStatus.OK) : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
//	}//likeCheck
	
	
	//======================================================
	// * 신고처리 부분
	
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
	

}//end class
