<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>


<!DOCTYPE html>

<html lang="ko">
<head>
    <meta charset="UTF-8" name="viewport" content="width=device=width, initial-scale=1.0">
    <title>FILMUS</title>
    <link rel="icon" href="/resources/img/favicon_noback.ico" type="image/x-icon">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KyZXEAg3QhqLMpG8r+8fhAXLRk2vvoC2f3B09zVXn8CA5QIVfZOJ3BCsw2P0p/We" crossorigin="anonymous">
	<link rel="stylesheet" href="/resources/css/star-rating.css">
	<link rel='stylesheet' href='https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css'/>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-U1DAWAznBHeqEIlVSCgzq+c9gqGAJn5c/t99JyeKa9xxaYpSvHU5awsuZVVFIhvj" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" ></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-migrate/3.3.2/jquery-migrate.min.js"></script>

    <script src="/resources/js/boardReport.js"></script>
    <script src="/resources/js/reply.js"></script>


	<script>
        $(function(){
            var likeCheck = "${likeCheck}"
            console.log("revieLike Check : ",likeCheck);
            console.log("likeCnt:","${review.likeCnt}");    
            console.log("filmId:","${review.filmId}");  

            $(".flip").click(function() {
                $(".panel").slideToggle("fast");
            });
            $(".flip2").click(function() {
                $(".panel2").slideToggle("fast");
            });

            //신고모달
            $("#reportBtn").on("click",function(e){
                console.log("reportBtn clicked>>")
                e.preventDefault();
                $("#reportmodal").modal("show");
            })
            //리뷰모달
            $("#register_review_btn").on("click",function(e){
                console.log("review clicked>>")
                $("#reg_review").modal("show");
            })
            // //댓글수정모달
            // $("#modReplyBtn").on("click", function(e){
            //     e.preventDefault();
            //     $("#modReplyModal").modal("show");
            // })

            
            //신고처리
            $("#modalReportBtn").on("click",function(e){
                console.log("modalReportBtn Clicked.");
                    var modal=$("#reportmodal");
                    var modalReportCode=modal.find("#reportcode").val();
                    console.log(modalReportCode);
                    var modalAccuser=modal.find("input[name='reportwriter']").val();
                    var modalTargetType=modal.find("input[name='reporttype']").val();
                    var modalTarget=modal.find("input[name='reporttarget']").val();
                    var modalSuspect=modal.find("input[name='suspect']").val();
                    var modalReportContent=modal.find("textarea[name='rContent']");
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

            //리뷰삭제
            $("#delete_review_btn").on('click',function(){
                console.log("delete clicked.");

                if(confirm("리뷰를 삭제하시겠습니까?")){
                    let formObj = $('#deleteForm');
				
                    formObj.attr("action", "/film/delReview");
                    formObj.attr("method", "POST");					
                
                    formObj.submit();
                } else{
                	return false;
                }//if-else
            })//delete     

            //댓글등록
            $("#regReplyBtn").on('click',function(){
                console.log("regReply clicked.");

                let formObj = $('#regReplyForm');
                
                formObj.attr("action", "/film/newReply");
                formObj.attr("method", "POST");					
            
                formObj.submit();
            })//regReply

            //댓글삭제
            $("#delReplyBtn").on('click',function(){
                console.log("delReply clicked.");

                let formObj = $('#modReplyForm');
            
                formObj.attr("action", "/film/delReply");
                formObj.attr("method", "POST");					
            
                formObj.submit();
            })//regReply

            //대댓글삭제
            $("#childReplyDelBtn").on('click',function(){
                console.log("delChildReply clicked.");

                let formObj = $('#modChildReplyForm');
            
                formObj.attr("action", "/film/delReply");
                formObj.attr("method", "POST");					
            
                formObj.submit();
            })//regReply

        })//jq
	</script>
    <style>
        #review_wrap{
            width: 998px;
            margin: 0 auto;
            clear: both;
        }
        #asideLeft{
            width: 210px;
            float: left;
        }
        #reviewInfo{
            width: 780px;
            float: left;
            padding: 20px;
        }
        #filmPoster{
            margin-top: 30px;
        }
        #content{
            padding: 10px 20px 30px 10px;
            font-size: 18px;
            white-space: pre-wrap;           
            word-wrap: break-word;
        }
        #movieName{
            display: inline-block;
            font-size: 40px;
        }
        #reviewRate{
            display: inline-block;
            padding-left: 20px;
            font-size: 15px;
        }
        #user{
            width: 200px;
            text-align: center;
            padding-top: 15px;
        }
        #counts{
            float: right;
            width: 100px;
        }
        #counts ul li{
            display: inline-block;
            padding-top: 30px;
        }
        #content{
            min-height: 250px;
            font-size: 18px;
            padding-left: 10px;
            white-space: pre-wrap;           
            word-wrap: break-word;
        }
        button{
            background-color: white;
            border: none;
        }
        .inner-star::before {
            color: pink;            
        }
        .outer-star {
            position: relative;
            display: inline-block;
            color: rgb(177, 175, 175);
        }
        .inner-star {
            position: absolute;
            left: 0;
            top: 0;
            width: 0%;
            overflow: hidden;
            white-space: nowrap;
        }
        .outer-star::before, .inner-star::before {
            content: '\f005 \f005 \f005 \f005 \f005';
            font-family: 'Font Awesome 5 free';
            font-weight: 900;
            font-size: 150%;
        }
        #deleteReview{
            margin-top: 150px;
            margin-left: 550px;
        }
        #delReview{
            min-height: 530px;
        }
        #returnBtn{
            margin-top: 30px;
            margin-left: 395px;
            text-align: center;
            width: 300px;
        }
        #regReply ul li{
            display: inline-block;
            padding: 10px;
            margin-bottom: 14px;
        }
        #regReply ul li:first-child{
            width: 600px;
        }
        .panel, .panel2, .panel3 {
            display: none;
        }
        #reatedDate, #modifiedDate{
            margin-top: 10px;
            font-size: 14px;
            color: rgba(0, 0, 0, 0.26);
        }
        #childReplyArea>li, #parentReplyInfo>ul>li, #childReplyInfo>ul>li, #childReplyInfo>ul>li, .panel>ul>li, .panel2>ul>li{
            display: inline-block;
        }
    </style>

</head>
<body>
    <div id="wrap">
        <%@ include file="/resources/html/header.jsp" %>
        <div id="review_wrap">
            <c:if test="${review.deleteTs!=null}">
                <div id="deleteReview">
                    <div id="delReview">
                        <p id="isDeleteTs"><img src="/resources/img/choonsigi.jpg" alt=""><br>삭제된 리뷰입니다.</p>
                        <button type="button" class="btn btn-outline-dark" id="returnBtn"><a href="/film/${review.filmId}">영화로 돌아가기</a></button>
                    </div>
                </div>
            </c:if>
            <c:if test="${review.deleteTs==null}">
                <div id="asideLeft">
                    <form action="/film/delReview" method="POST" id="deleteForm">
                        <input type="hidden" name="rno" value="${review.rno}">
                        <input type="hidden" name="filmId" value="${review.filmId}">
                        <div id="movieImg">
                            <a href="/film/${review.filmId}"><img src="https://www.themoviedb.org/t/p/original${review.posterPath}" alt="filmPoster" id="filmPoster" width="200px"></a>
                            <div>
                                <div id="user">
                                    <div id="userprofile">
                                        <a href="/mypage/main?userid=${review.writer}">
                                            <img id="profileImg" src="https://younghoon.s3.ap-northeast-2.amazonaws.com/${review.profilePhotoPath}" class="img-thumbnail" alt="..." style="width: 40px; height: 40px; border-radius: 50%;">
                                            <div>
                                                ${review.nickname}
                                            </div>
                                        </a>
                                    </div>
                                    <c:if test="${review.updateTs==null}">
                                        <div id="reatedDate">
                                            <div>Created </div><fmt:formatDate pattern='yyyy/MM/dd' value="${review.insertTs}"/>
                                        </div>
                                    </c:if>
                                    <c:if test="${review.updateTs!=null}">
                                        <div id="modifiedDate">
                                            <div>Created </div><fmt:formatDate pattern='yyyy/MM/dd' value="${review.insertTs}"/>
                                            <div>Modified </div><fmt:formatDate pattern='yyyy/MM/dd' value="${review.updateTs}"/>
                                        </div>
                                    </c:if>
                                    <c:if test="${__LOGIN__.userId==review.writer}">
                                        <div id="regdelBtn">
                                            <button type="button" class="btn btn-outline-dark" id="register_review_btn">수정</button>
                                            <button type="button" class="btn btn-outline-dark" id="delete_review_btn">삭제</button>
                                        </div>
                                    </c:if>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
                <div id="reviewInfo">
                    <div id="reviewTitle">
                        <div id="movieName">
                            ${review.title}
                        </div>
                        <div id="reviewRate">
                            <div class='RatingStar'>
                                <div class='RatingScore'>
                                    <div class='outer-star'>
                                        <div class='inner-star' style='width: ${review.rate*20}%'></div>
                                    </div>
                                    ${review.rate} / 5.0
                                </div>
                            </div>
                        </div>
                        <div id="counts">
                            <ul>
                                <li>
                                    <c:set var='likeCheck' value='${likeCheck}' />
                                    <c:choose>
                                        <c:when test="${likeCheck eq '0'}">
                                            <form action="/film/reviewLike" method="POST" id='reviewLike'>                       
                                                <input type='hidden' name='rno' value='${review.rno}'>
                                                <input type='hidden' name='filmId' value='${review.filmId}'>
                                                <input type='hidden' name='userId' value='${__LOGIN__.userId}'>
                                                <button type="submit" id="likeBtn"><img src="/resources/img/emptyheart.png" alt="좋아요" width="30px" height="30px"></button>${review.likeCnt}
                                            </form>
                                        </c:when>
                                        <c:when test="${likeCheck eq '1'}">                       
                                            <form action="/film/reviewUnlike" method="POST" id='reviewUnLike'>                       
                                                <input type='hidden' name='rno' value='${review.rno}'>
                                                <input type="hidden" name="filmId" value="${review.filmId}">
                                                <input type='hidden' name='userId' value='${__LOGIN__.userId}'>
                                                <button type="submit" id="unlikeBtn"><img src="/resources/img/fullheart.png" alt="좋아요" width="30px" height="30px"></button>${review.likeCnt}
                                            </form>                                          
                                        </c:when>
                                        <c:when test="${likeCheck eq '2'}">
                                            <img src="/resources/img/emptyheart.png" alt="좋아요" width="30px" height="30px">${review.likeCnt}
                                        </c:when>
                                    </c:choose>
                                </li>
                                <li><button id="reportBtn"><img src='/resources/img/siren.jpg' width='25px' height='25px'></button></li>
                            </ul>
                        </div>
                    </div>
                    <div id="reviewContent">
                        <hr>
                        <div id="content">${review.content}</div>
                    </div>
                    <div id="reviewReply">
                        <c:set var="userId" value="${__LOGIN__.userId}"/>
                        <!-- 댓글작성 -->
                        <div id="replyRegist">
                            <hr>
                            <form action="/film/newReply" method="POST" id="regReplyForm">
                                <input type="hidden" name="rno" value="${review.rno}">
                                <input type="hidden" name="filmId" value="${review.filmId}">
                                <input type="hidden" name="writer" value="${__LOGIN__.userId}">
                                <div id="regReply">
                                    <c:choose>
                                        <c:when test="${userId ne null}">
                                            <ul>
                                                <li><input type="text" class="form-control" name="content" placeholder="댓글을 남겨보세요."></li>
                                                <li><button type="submit" class="btn btn-outline-dark" id="regReplyBtn">댓글남기기</button></li>
                                            </ul>
                                        </c:when>
                                        <c:otherwise>
                                            <ul>
                                                <li><input type="text" class="form-control" name="content" placeholder="로그인 후 댓글을 남겨보세요." readonly></li>
                                                <li><button type="submit" class="btn btn-outline-dark" id="regReplyBtn" disabled>댓글남기기</button></li>
                                            </ul>                                        
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </form>
                        </div> <!-- replyRegist -->
                        <!-- 댓글 리스트 -->
                        <div id="replyList">
                            <c:forEach items="${list}" var="reply">
                                <c:if test="${reply.deleteTs==null && reply.parentRcno==null}">
                                    <div id="parentReplyInfo">
                                        <ul>
                                            <li><a href="/mypage/main?userid=${reply.writer}"><img id="replyImg" src="https://younghoon.s3.ap-northeast-2.amazonaws.com/${reply.profilePhotoPath}" alt="profile" style="width: 40px; height: 40px; border-radius: 50%;"></a></li>
                                            <li> ${reply.nickname}</li>
                                            <li style="color: rgba(128, 128, 128, 0.5); font-size: 10px;">작성 <fmt:formatDate pattern='yyyy/MM/dd hh:mm' value="${reply.insertTs}"/></li>
                                            <c:if test="${reply.updateTs!=null}">
                                                <li style="color: rgba(128, 128, 128, 0.5); font-size: 10px;">수정
                                                    <fmt:formatDate pattern='yyyy/MM/dd hh:mm' value="${reply.updateTs}" />
                                                </li>
                                            </c:if>
                                        </ul>
                                    </div>
                                    <div style="padding: 15px 0 15px 50px;">
                                        ${reply.content}
                                    </div>
                                    <c:if test="${reply.writer==userId}">
                                        <div style="padding: 15px 0 15px 30px;">
                                            <form action="/film/modReply" method="POST" id="modReplyForm" style="display: inline-block;">
                                                <input type="hidden" name="rno" value="${review.rno}">
                                                <input type="hidden" name="filmId" value="${review.filmId}">
                                                <input type="hidden" name="writer" value="${__LOGIN__.userId}">
                                                <input type="hidden" name="rcno" value="${reply.rcno}">
                                                <button type="button" class="flip" style="color: rgb(241, 251, 255); background-color: rgb(181, 192, 216);">수정</button>
                                                <button type="button" id="delReplyBtn" style="color: rgb(241, 251, 255); background-color: rgb(181, 192, 216);">삭제</button>
                                                <div class="panel" id="childReplyArea">
                                                    <ul>
                                                        <li><input type="text" class="form-control" name="content"
                                                                style="width:540px;"></li>
                                                        <li><button type="submit" class="btn btn-outline-dark"
                                                                id="RegChildReplyBtn">등록</button></li>
                                                    </ul>
                                                </div>
                                            </form>
                                        </div>
                                    </c:if>
                                    <div style="padding-left: 33px;">
                                        <form action="/film/newChildReply" method="POST">
                                            <input type="hidden" name="rno" value="${review.rno}">
                                            <input type="hidden" name="filmId" value="${review.filmId}">
                                            <input type="hidden" name="writer" value="${__LOGIN__.userId}">
                                            <input type="hidden" name="parentRcno" value="${reply.rcno}">
                                            
                                            <div>
                                                <c:choose>
                                                    <c:when test="${userId ne null}">
                                                        <ul>
                                                            <ul id="childReplyArea">
                                                                <li><input type="text" class="form-control" name="content"
                                                                        placeholder="답글을 남겨보세요." style="width:540px;"></li>
                                                                <li><button type="submit" class="btn btn-outline-dark"
                                                                        id="RegChildReplyBtn">답글남기기</button></li>
                                                            </ul>
                                                        </ul>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <ul id="childReplyArea">
                                                            <li><input type="text" class="form-control" name="content"
                                                                    placeholder="로그인 후 답글을 남겨보세요." style="width:540px;" readonly></li>
                                                            <li><button type="submit" class="btn btn-outline-dark"
                                                                    id="RegChildReplyBtn" disabled>답글남기기</button></li>
                                                        </ul>                                    
                                                    </c:otherwise>
                                                </c:choose>
                                                
                                            </div>
                                        </form>
                                        
                                    </div>
                                    <div id="childReplyList" style="padding: 15px 0 0 30px;">
                                        <c:forEach items="${list}" var="childReply">
                                            <c:if test="${reply.rcno==childReply.parentRcno && childReply.deleteTs==null}">
                                                <div style="margin-top: 10px;">
                                                    <div id="childReplyInfo">
                                                        <ul>
                                                            <li><a href="/mypage/main?userid=${childReply.writer}"><img id="replyImg" src="https://younghoon.s3.ap-northeast-2.amazonaws.com/${childReply.profilePhotoPath}" alt="profile" style="width: 40px; height: 40px; border-radius: 50%;"></a></li>
                                                            <li> ${childReply.nickname}</li>
                                                            <li style="color: rgba(128, 128, 128, 0.5); font-size: 10px;">작성 <fmt:formatDate pattern='yyyy/MM/dd hh:mm' value="${childReply.insertTs}"/></li>
                                                            <c:if test="${childReply.updateTs!=null}">
                                                                <li style="color: rgba(128, 128, 128, 0.5); font-size: 10px;">수정
                                                                    <fmt:formatDate pattern='yyyy/MM/dd hh:mm' value="${childReply.updateTs}" />
                                                                </li>
                                                            </c:if>
                                                        </ul>
                                                    </div>
                                                    <div style="padding: 15px 0 15px 30px;">
                                                        ${childReply.content}
                                                    </div>
                                                    <c:if test="${childReply.writer==userId}">
                                                        <div  style="padding-left: 30px;">
                                                            <form action="/film/modReply" method="POST" id="modChildReplyForm" style="display: inline-block;">
                                                                <input type="hidden" name="rno" value="${review.rno}">
                                                                <input type="hidden" name="filmId" value="${review.filmId}">
                                                                <input type="hidden" name="writer" value="${__LOGIN__.userId}">
                                                                <input type="hidden" name="rcno" value="${childReply.rcno}">
                                                                <button type="button" class="flip2" style="color: rgb(241, 251, 255); background-color: rgb(181, 192, 216);">수정</button>
                                                                <button type="button" id="childReplyDelBtn" style="color: rgb(241, 251, 255); background-color: rgb(181, 192, 216);">삭제</button>
                                                                <div class="panel2" id="childReplyArea">
                                                                    <ul>
                                                                        <li><input type="text" class="form-control" name="content" style="width:540px;"></li>
                                                                        <li><button type="submit" class="btn btn-outline-dark">등록</button></li>
                                                                    </ul>
                                                                </div>
                                                            </form> 
                                                        </div>
                                                    </c:if>
                                                </div>
                                            </c:if>
                                        </c:forEach>
                                    </div>
                                    <hr>
                                </c:if>
                            </c:forEach>
                        </div> <!-- replyList end -->
                    </div> <!-- review reply end -->
                </div> <!-- reviewInfo end -->
            </c:if>
        </div> <!-- review_wrap end -->

        <!-- report Modal -->
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
                            <select class="form-select" name="reportcode" id='reportcode'>
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
                        </div>      
                        <div class="form-group">
                            <!-- 신고대상 -->
                            <input type="hidden" type="text" class="form-control" name="reporttype" value="RNO" readonly> 
                            <input type="hidden" type="text" class="form-control" name="reporttarget" value="${review.rno}" readonly>
                            <input type="hidden" type="text" class="form-control" name="suspect" value="${review.writer}" readonly>                       
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button id='modalCloseBtn' type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
                        <button id='modalReportBtn' type="button" class="btn btn-danger" data-bs-dismiss="modal">신고하기</button>
                    </div> 
                </div>
            </div>
        </div>

        <!-- reg_review Modal -->
        <div class="modal fade input_modal" id="reg_review" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <h2 class="modal-title" id="staticBackdropLabel"><b>Modify a review</b></h2>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body row">
                        <div class="col-4">
                            <img src="https://www.themoviedb.org/t/p/original${review.posterPath}"  alt="filmPoster" id="filmPoster" style="margin: 0; margin-left: 15px; width: 200px;">
                        </div>
                        <div class="col-8 film_header">
                            <p>
                                <strong>${review.title}</strong>
                            </p>
                            <form action="/film/modReview" method="POST" id="">
                                <input type="hidden" name="filmId" value="${review.filmId}">
                                <input type="hidden" name="writer" value="${__LOGIN__.userId}">
                                <input type="hidden" name="rno" value="${review.rno}">

                                <div class='rating-wrap'>
                                    <fieldset class='rating'>
                                        <input type='radio' id='star5' name='rate' value='5' /><label for='star5' class='full'></label>
                                        <input type='radio' id='star4.5' name='rate' value='4.5' /><label for='star4.5' class='half'></label>
                                        <input type='radio' id='star4' name='rate' value='4' /><label for='star4' class='full'></label>
                                        <input type='radio' id='star3.5' name='rate' value='3.5' /><label for='star3.5' class='half'></label>
                                        <input type='radio' id='star3' name='rate' value='3' /><label for='star3' class='full'></label>
                                        <input type='radio' id='star2.5' name='rate' value='2.5' /><label for='star2.5' class='half'></label>
                                        <input type='radio' id='star2' name='rate' value='2' /><label for='star2' class='full'></label>
                                        <input type='radio' id='star1.5' name='rate' value='1.5' /><label for='star1.5' class='half'></label>
                                        <input type='radio' id='star1' name='rate' value='1' /><label for='star1' class='full'></label>
                                        <input type='radio' id='star0.5' name='rate' value='0.5' /><label for='star0.5' class='half'></label>
                                    </fieldset>
                                </div>
                                <p id='rating-value'></p>					
                                <script src='/resources//js/star-rating.js'></script>
                                <div class="mb-3">
                                    <textarea id="review_content" class="form-control" placeholder="write your review here..." name="content" maxlength="2048" style="height: 180px;"></textarea>
                                </div>
                                <div class="form-check">
                                    <label class="form-check-label" for="spoiler"><b>this review contains spoilers</b></label>
                                    <input class="form-check-input" type="checkbox" name="spoiler" id="spoiler">
                                </div>
                                <div class="d-grid gap-2">
                                    <button type="submit" class="btn btn-primary" id="modReviewBtn">REGISTER</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div style="clear: both;">
            <%@ include file="/resources/html/footer.jsp" %>
        </div>
    </div> <!-- wrap end -->
</body>
</html>