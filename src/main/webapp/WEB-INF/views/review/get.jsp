<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" %> 

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>

<html id="html" lang="ko" class="no-mobile no-js">

  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=1024" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />

    <title>
      &lrm;${reviewFilmUserVO.title} review by ${reviewFilmUserVO.nickname} &bull; FILMEE
    </title>

	<%@ include file="/resources/html/header.jsp" %>
  
    <link href="/resources/css/letterboxd.css" rel="stylesheet" media="screen, projection" />
    <script src="https://s.ltrbxd.com/static/js/main.min.ed93f370.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-migrate/3.3.2/jquery-migrate.min.js"></script>
     <link rel="icon" href="/resources/img/favicon_noback.ico" type="image/x-icon">
    <link rel="stylesheet" href="/resources/css/bootstrap.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KyZXEAg3QhqLMpG8r+8fhAXLRk2vvoC2f3B09zVXn8CA5QIVfZOJ3BCsw2P0p/We" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-U1DAWAznBHeqEIlVSCgzq+c9gqGAJn5c/t99JyeKa9xxaYpSvHU5awsuZVVFIhvj" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-migrate/3.3.2/jquery-migrate.min.js"></script>
    <script src="/resources/js/reviewLike.js"></script>
    <script src="/resources/js/reviewReply.js"></script>
    <script src="/resources/js/reviewReport.js"></script>
    
    
    <script>    
    	$(function(){
            console.log("========= COMMENT JS =======")
    		var rnoValue='<c:out value="${reviewFilmUserVO.rno}"/>';
            var nickname='<c:out value="${__LOGIN__.nickname}"/>' 
            var userid='<c:out value="${__LOGIN__.userId}"/>'
            var replyUL=$(".chat");    
            var reviewwriter='<c:out value="${reviewFilmUserVO.writer}"/>'
            var modal = $(".modal"); 
            var modalInputReply=modal.find("input[name='content']");
            var modalInputReplyer=modal.find("input[name='writer']");
            var modalinputReplyDate=modal.find("input[name='insert_ts']");
            var modalModBtn=$("#modalModBtn");
            var modalRemoveBtn=$("#modalRemoveBtn");
            var modalRegisterBtn=$("#modalRegisterBtn");
            
         
            console.log("userid:",userid);
            console.log("writer:",writer);
            if("${__LOGIN__.userId}"==writer){
                $("#delete").show();
                $("#modifyBtn").show();
            } else{
                $("#delete").hide();
                $("#modifyBtn").hide();
                if("${__LOGIN__}"==""){
                    $("#addReplyBtn").hide()
                    $("#reportBtn").hide()
                }//if
            }//if-else
            	
            var likecheck="${heart.likecheck}"
            console.log(">>>> LIKECHECK >>>> ",likecheck); 
            if(likecheck==1){
                $("#likeimg").attr("src", "/resources/img/fullheart.png");
                $("#likeBtn").on("click",function(e){
                    // likeService.likeChecking(rnoValue);
                    likeService.unLike(rnoValue, userid);
                    alert("좋아요를 취소했습니다.");
                    $("#likeimg").attr("src", "/resources/img/emptyheart.png");
                    
                    console.log(">>>>>>>like check", likecheck);
                    
                /*     location.href="/review/get?rno=${reviewFilmUserVO.rno}&currPage=${cri.currPage}&amount=${cri.amount}&pagesPerPage=${cri.pagesPerPage}"
                 */
                 location.href="/film/${reviewFilmUserVO.film_id}/review/${reviewFilmUserVO.rno}"
                })
            }
            if(likecheck==0){
                $("#likeimg").attr("src", "/resources/img/emptyheart.png");
                $("#likeBtn").on("click",function(e){
                    // likeService.likeChecking(rnoValue);
                    likeService.likeIt(rnoValue, userid);
                    alert("좋아요를 눌렀습니다.");
                    $("#likeimg").attr("src", "/resources/img/fullheart.png");
                    
                    likecheck=1;
                    console.log(">>>>>>>like check", likecheck);
                    /*     location.href="/review/get?rno=${reviewFilmUserVO.rno}&currPage=${cri.currPage}&amount=${cri.amount}&pagesPerPage=${cri.pagesPerPage}"
                     */
                     location.href="/film/${reviewFilmUserVO.film_id}/review/${reviewFilmUserVO.rno}"
                })
            }
            showList(1);
            function showList(page){
                console.log("showList ! : nick:",nickname)
                replyService.getList({rno:rnoValue,page:page||1},function(list){
                    if(page== -1){
                        pageNum=Math.ceil(replyCnt/10.0);
                        showList(pageNum);
                        return;
                    }
                    var str="";
                    if(list==null||list.length==0){
                        str+="<div>아직 댓글이 없습니다.</div>"
                        // return;
                    }//if
                    for(var i=0, len=list.length||0; i<len; i++){
                        str+="      <div class='header'>";
                        str+="          <a href='/mypage/main?userid="+list[i].writer+"'><img class='rounded-circle' src='/resources/img/common.jpg' width='30px' height='30px'></a>";
                        str+="          <strong class='primary-font'>"+list[i].nickname+"</strong>";
                        // str+="          <button type='button' id='reportBtn'> <img src='/resources/img/siren.jpg' width='20px' height='20px'>신고</button>";
                        str+="          <samll class='pull-right text-muted' id='commentTs'>등록 "+replyService.displayTime(list[i].insert_ts)+" <c:if test='"+list[i].update_ts+"'><br>수정 "+replyService.displayTime(list[i].update_ts)+"</c:if>"+"</small>";
                        str+="      </div>"
                        str+="<li class='left clearfix' data-bcno='"+list[i].bcno+"'>";
                        str+="  <div>";
                        str+="      <p id='replycontent'>"+list[i].content+"</p>";
                        str+="   </div>";
                        str+="</li>";
                        str+="<hr>";
                    }
                    replyUL.html(str);
                })//end function
            }//showList
            
            $("#addReplyBtn").on("click",function(e){
                console.log("addReplyBtn")
                modal.find("input").val("");
                modalinputReplyDate.closest("div").hide();
                modal.find("button[id!='modalCloseBtn']").hide();
                modalRegisterBtn.show();
                replyComment.readOnly=false;
                $("#createComment").modal("show");
            })//onclick addReplyBtn
            modalRegisterBtn.on("click",function(e){
                var reply={
                    content:modalInputReply.val(),
                    rno:rnoValue,
                    writer:"${__LOGIN__.userId}"
                };
                replyService.add(reply,function(result){
                    alert(result); 
                    modal.find("input").val("");
                    modal.modal("hide");
                    showList(1);
                })
            })//modalRegisterBtn
            // $("#replycontent").css('cursor','pointer')
            $(".chat").on("click","li",function(e){
                console.log(" >> chat clicked.");
                bcno=$(this).data("bcno");
                console.log(".chat bcno:"+bcno);
                replyService.get(bcno, function(reply){
                    console.log(reply);
                    modalInputReply.val(reply.content);
                    modalInputReplyer.val(reply.nickname).attr("readonly","readonly");
                    modalinputReplyDate.val(replyService.displayTime(reply.update_ts)).attr("readonly","readonly").hide();
                    modal.data("bcno",reply.bcno);
                    modal.find("button[id!='modalCloseBtn']");
                    if("${__LOGIN__.userId}"==reply.writer){
                        modalModBtn.show();
                        modalRemoveBtn.show();
                        replyComment.readOnly=false;
                        
                    }else{
                        replyComment.readOnly=true;
                        modalModBtn.hide();
                        modalRemoveBtn.hide();
                    }
                    modalRegisterBtn.hide();
                    $("#createComment").modal("show");
                })
            })
            modalModBtn.on("click",function(e){
                console.log("modalModBtn Clicked");
            	var reply2={
                    bcno:bcno, 
                    content: modalInputReply.val()
                };
                console.log("reply2:"+reply2.bcno+ reply2.content)
				replyService.update(reply2, function(result){
                    alert("수정 되었습니다.");
					modal.modal("hide");
					showList(1);
				})
            })
			modalRemoveBtn.on("click",function(e){
                console.log("removeBtn clicked >> bcno:" +bcno);
				replyService.remove(bcno, function(result){
                    alert("삭제 되었습니다.");
					modal.modal("hide");
					showList(1);
				})
			})
            $("#reportBtn").on("click",function(e){
                console.log("reportBtn clicked>>")
                $("#reportmodal").modal("show");
            })
            var modalReportCode=modal.find("select[name='reportcode']").val();
            var modalAccuser=modal.find("input[name='reportwriter']").val();
            var modalTargetType=modal.find("input[name='reporttype']").val();
            var modalTarget=modal.find("input[name='reporttarget']").val();
            var modalSuspect=modal.find("input[name='suspect']").val();
            var modalReportContent=modal.find("textarea[name='rContent']");
            $("#modalReportBtn").on("click",function(e){
                console.log("modalReportBtn Clicked.");
                var reportinfo={
                    code: modalReportCode,
                    accuser: modalAccuser,
                    target_type: modalTargetType,
                    target: modalTarget,
                    suspect: modalSuspect,
                    content: modalReportContent.val()
                }
                console.log("reportinfo: ", reportinfo);
                reportService.send(reportinfo,function(result){
                    alert("신고가 접수되었습니다.");
                    modal.modal("hide");
                })
            })
    	})//jq
        $(function(){
            console.debug('>>> jq started.');
            $("#listBtn").on('click',function(){
                console.log(" >>> listBtn button clicked");
                location.href="/review/list?currPage=${cri.currPage}&amount=${cri.amount}&pagesPerPage=${cri.pagesPerPage}"
            }) //on click
            $("#modifyBtn").on('click',function(){
                console.log(" >>> modifyBtn clicked");
                location.href="/review/modify?rno=${review.rno}&currPage=${cri.currPage}&amount=${cri.amount}&pagesPerPage=${cri.pagesPerPage}"
            })//onclick
            $("#delete").on('click',function(){
                console.log("delete clicked.");
                if(confirm("리뷰를 삭제하시겠습니까?")){
                    let formobj=$('form');
                    formobj.attr('action','/film/review/remove');
                    formobj.attr('method','post');
                    formobj.submit();
                } else{
                	return false;
                }//if-else
            })//delete
            
        })//js
    </script>

    <style>
        body,input,textarea,select,button,table{font-family:'ELAND 초이스';}
        body,div,h1,h2,h3,h4,h5,h6,ul,ol,li,dl,dt,dd,p,form,fieldset,input,table,tr,th,td{margin:0;padding:0;}
        h1,h2,h3,h4,h5,h6{font-weight:normal;font-size:100%;}
        ul,ol{list-style:none;}
        fieldset,img{border:0; vertical-align:top;}
        address{font-style:normal;}
        p,li,dd{font-size:1em; line-height:1.5em; text-align:justify;}
        /* a-style */
        a{color:#333;text-decoration:none;text-align: center;}
        a:hover,a:active,a:focus,a:visited{color:#333;text-decoration:none;}
        body{
		    width: 998px;
		    margin: 0 auto;
		    font-size: 20px;
            font-family: 'ELAND 초이스';
            -ms-user-select: none; 
            -moz-user-select: -moz-none;
            -khtml-user-select: none;
            -webkit-user-select: none;
            user-select: none; 
		}
		#commentTs{
			float: right;
		}
        #thiscategory{
            width: 90%;
            height: 100px;
            font-size: 50px;
            font-family: 'ELAND 초이스';
            text-align: center;
            margin: 0 auto;
        }
        #userinfo{
            display: inline-table;
            margin-left: 20px;
            height: 160px;
        }
        #getinfo{
            float: right;
            margin-top: 40px;
            margin-right: 20px;
        }
        #title{
            width: 50%;
            height: 40px;
            font-size: 26px;
            padding: 10px;
            margin-bottom: 20px;
            background-color: #fcfcfc00; 
            border-radius: 30px;
        }
        #content{
            width: 100%;
            height: 100%;
            font-size: 19px;
            padding: 20px;
            background-color: #ffffff00; 
            border-radius: 30px;
        }
        #replycontent{
            width: 90%;
            margin-left: 32px;
            margin-top: 10px;
        }
        button {
            margin-left: 20px;
            background-color: white;
            font-family: "ELAND 초이스";
            font-size: 20px;
            font-weight: 400;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            width: auto;
            border: none;
            border-radius: 4px;
            /* box-shadow: 0 4px 6px -1px rgba(169, 235, 255, 0.781), 0 2px 4px -1px rgba(125, 160, 212, 0.425); */
            cursor: pointer;
            transition: 0.5s;
        }
        #threeBtn, #reportBtn{
            float: right;
        }
        #emptyheart{
            width: 20px;
            height: 20px;
        }
        table {
			width:100px;
		    text-align: center;
		    margin-top: 10px ;
            float: right;
		    font-size: 30px;
            font-family: 'ELAND 초이스';
  			border-collapse: collapse;
		  }
		 td{
		  	color: black;
		  	font-size:15px;
		  	padding: 10px;
  		  }
		  th{
		  	font-weight: bold;
		  	border:10px;
		  	margin:10px;
		  	padding:15px;
  		  }
        #commentList{
            display: inline-block;
            font-size: 16px;
        }
        #addReplyBtn{
            display: inline-block;
            float: right;
            font-size: 16px;
        }
        #reportBtn{
            float: right;
        }
        #isDeleteTs{
            margin-top: 300px;
            margin-left: 400px;
        }
    </style>
	
  </head>

  <body class="view">

      <div class="site-header-bg"></div>
      <section>
        <div
          class="react-component"
          data-component-class="globals.comps.NavComponent"></div>

 
    <div id="content" class="site-body">
      <div class="content-wrap">
        <div class="cols-2">
          <section class="section col-17 col-main overflow">
            <div class="col-4 gutter-right-1">
              <section class="poster-list -p150 el col">
                <div
                  class="
                    really-lazy-load
                    poster
                    film-poster film-poster-506032
                    linked-film-poster
                  "
                  data-image-width="150"
                  data-image-height="225"
                >
                  <img
                    src="https://www.themoviedb.org/t/p/original${reviewFilmUserVO.poster_path}"
                    width="150"
                    height="225"
                    class="image"
                    itemprop="image"
                  />
                  <span class="frame"><span class="frame-title"></span></span>
                </div>
              </section>

              <div
                class="js-csi"
                data-on-load="csi-availability"
              ></div>
            </div>

            <section class="col-12 review">
              <section class="film-viewing-info-wrapper">
                <header class="page-header overflow person-header">
                  <div class="person-summary -inline">
                    <a class="avatar -a24" href="/${reviewFilmUserVO.writer}/">
                      <img
                        src="회원프로필사진"
                        alt="${reviewFilmUserVO.writer}"
                        width="24"
                        height="24"
                      />
                    </a>
                    <h1
                      class="title-4"
                      itemprop="author">
                   
                      <a href="/${reviewFilmUserVO.nickname}/" itemprop="sameAs" class="name">
                        <span itemprop="name">${reviewFilmUserVO.nickname}님의 리뷰 </span>
                      </a>
                    </h1>
                  </div>

                  <div class="clear"></div>
                </header>

                <h2 class="headline-2 prettify">
                  <span class="film-title-wrapper">
                    <a href="/film/${reviewFilmUserVO.film_id}/">${reviewFilmUserVO.title}</a>
                    <small class="metadata"> <fmt:formatDate value="${reviewFilmUserVO.release_date}" pattern="yyyy" /></small>
                  </span>
                  <span class="rating rating-large rated-large-10">
                    ★★★★★
                  </span>
                </h2>
        
              </section>

               <div class="review body-text -prose -hero -loose">
                <div>
                  <h3 class="hidden">
                    ${reviewFilmUserVO.nickname}의 리뷰:
                  </h3>

                  <div>
                    <p>${reviewFilmUserVO.content}</p>
                  </div>
                </div>
              </div> 

              <!--  <p
                class="like-link-target react-component review-like -monotone"
                data-component-class="globals.comps.LikeLinkComponent" 
                data-likeable-name="review"
                data-likeable="true"
                data-format="svg"
                data-owner="${reviewFilmUserVO.writer}"
              >
               <span class="svg-action -like"></span>
              </p> -->
        
                <div
                  id="report-member-${reviewVO.writer}-review-130509321"
                  class="block-or-report-menu popmenu popup-menu"
                  data-username="${reviewFilmUserVO.writer}"
                >
                  <ul>
    
                  </ul>
                </div>
              </div>
        </div>
      </div>
   
		<!-- 여기부터 현아꺼 참고한거 -->
		<form action="/film/get">
            <input type="hidden" name="rno" value="${reviewFilmUserVO.rno}">
            <input type="hidden" name="userId" value="${__LOGIN__.userId}">
            <input type="hidden" name="likecheck" value="${reviewVO.likecheck}">
		<!-- 신고 / 좋아요 -->
            <div id="count">
                <table>
                    <tr>
                        <td><button id="reportBtn"><img src='/resources/img/siren.jpg' width='25px' height='25px'></button></td>
                        <td>
                            <c:if test="${__LOGIN__==null}">
                                <img src="/resources/img/emptyheart.png" alt="좋아요" width="30px" height="30px">
                            </c:if>
                            <c:if test="${__LOGIN__.userId != null}">
                                <button id="likeBtn"><img id="likeimg" src="/resources/img/emptyheart.png" alt="좋아요" width="30px" height="30px"></button>
                            </c:if>

                        </td>
                    </tr>
                    <tr>
                        <c:if test="${__LOGIN__.userId != null}">
                            <td>신고</td>
                        </c:if>
                        <c:if test="${__LOGIN__==null}">
                            <td> </td>
                        </c:if>
                 
                        <td> ${reviewFilmUserVO.like_cnt}</td>
                    </tr>
                </table>
            </div>

            <hr>
            <div id="content">
                       <div class="review body-text -prose -hero -loose">
       
              </div>
            </div>
            <hr>
            <div id="threeBtn">
                <button type="button" id="modifyBtn" class="btn btn-outline-dark">수정</button>
                <button type="button" id="delete" class="btn btn-outline-dark">삭제</button>
                <button type="button" id="listBtn" class="btn btn-outline-dark">목록</button>
            </div>
   

    <div class='row'>
                <div class='col-lg-12'>
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <i class="fa fa-comments fa-fw"></i><strong>댓글 목록</strong>
                            <button type="button" id="addReplyBtn" class="btn btn-outline-dark" data-bs-toggle="modal" data-bs-target="#exampleModal">새 댓글 쓰기</button>
                            <hr>
                            <!-- Modal -->
                        </div>
                        <div class="panel-body">
                            <ul class="chat">
                                <li class="left clearfix" data-bcno='89' >
                                    <div>
                                        <div class="header">
                                            <strong class="primary-font"></strong>
                                            <small class="pull-right text-muted"></small>
                                        </div>
                                        <p></p>
                                    </div>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Modal -->
            <div class="modal fade" id="createComment" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                  <div class="modal-content">
                    <div class="modal-header">
                      <h5 class="modal-title" id="exampleModalLabel">댓글 작성</h5>
                      <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div class="form-group">
                            <label for="content">내용</label>
                            <input id="replyComment" class="form-control" name='content' value='content'>
                        </div>      
                        <div class="form-group">
                            <input type="hidden" class="form-control" name='writer' >
                        </div>
                        <div class="form-group">
                            <input class="form-control" name='insert_ts' value='current_date'>
                        </div>

                    </div>
                    <div class="modal-footer">
                      <button id='modalCloseBtn' type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
                      <button id='modalModBtn' type="button" class="btn btn-warning">수정</button>
                      <button id='modalRemoveBtn' type="button" class="btn btn-danger">삭제</button>
                      <button id='modalRegisterBtn' type="button" class="btn btn-primary" data-bs-dismiss="modal">작성완료</button>
                    </div>
                  </div>
                </div>
              </div>

            <!-- Modal -->
            <div class="modal fade" id="reportmodal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                  <div class="modal-content">
                    <div class="modal-header">
                      <h5 class="modal-title" id="exampleModalLabel"><img src="/resources/img/siren.jpg" alt="" width="20px" height="20px"> 신고하기</h5>
                      <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div>
                            <label for="reportcode">신고유형</label>
                            <select class="form-select" name="reportcode">
                                <option value="1">욕설/비방</option>
                                <option value="2">스포일러</option>
                                <option value="3">광고</option>
                                <option value="4">기타</option>
                              </select>
                              <br>
                        </div>
                        <div class="form-group">
                            신고자 <input type="text" class="form-control" name="nickname" value="${__LOGIN__.nickname}" readonly>
                            <input type="hidden" type="text" class="form-control" name='reportwriter' value="${__LOGIN__.userId}" readonly>
                        </div>
                        <div class="form-group">
                            <label for="reportcontent">내용</label>
                            <textarea name="rContent" class="form-control" cols="44" rows="10" placeholder="* 주의 *&#13;&#10;1. 허위신고 시 제재를 받을 수 있습니다.&#13;&#10;2. 신고는 취소할 수 없습니다."></textarea>
                            
                            <!-- <input id="reportcontent" class="form-control" name='reportcontent' value='내용을 입력하세요.'> -->
                        </div>      
                        <div class="form-group">
                            <!-- 신고대상 -->
                            <input type="hidden" type="text" class="form-control" name="reporttype" value="rno" readonly> 
                            <input type="hidden" type="text" class="form-control" name="reporttarget" value="${ReviewFilmUserVO.film_id}" readonly>
                            <input type="hidden" type="text" class="form-control" name="reporttarget" value="${ReviewFilmUserVO.rno}" readonly>
                            <input type="hidden" type="text" class="form-control" name="suspect" value="${ReviewFilmUserVO.writer}" readonly>                       
                        </div>
                    </div>
                    <div class="modal-footer">
                      <button id='modalCloseBtn' type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
                      <button id='modalReportBtn' type="button" class="btn btn-danger" data-bs-dismiss="modal">신고하기</button>
                    </div> 
                  </div>
                </div>
            </div>

		</form>
  </body>
</html>