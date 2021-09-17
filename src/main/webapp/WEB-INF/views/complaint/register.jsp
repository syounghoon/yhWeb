<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
     

<!DOCTYPE html>

<html lang="ko">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title></title>

 
        <style>
            #popup{

                display: flex;
                flex-flow: column nowrap;
                justify-content: left;
                position: fixed;
                z-index: 1100;
                left: 50%;
                top: 50%;
                transform: translate(-50%, -50%);
                width: 500px;
                height: 500px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 5);
                background: #fff;
                border-radius: 5px;
                text-align: right;
                padding: 20px;
                box-sizing: border-box;
                text-decoration: none; 
                
                transition: all 0.5s;
                display: none;
            }

            #com_register_btn{
                
                display:  block; 
                width: 90px;
                height: 30px;
                
                border: 1px none;
                background: #534002e8;
                text-decoration: none;
                text-align: center;
                line-height: 10px;
                color: #fff;
                border-radius: 50px;
                
                display: none;
            }

            #comp_close{
                color:  #f0adceed;
                text-decoration: none;
            }

            #select{
                display: flex;
                flex-flow: row;
                width: 120px;
                height: 40px;
                border: 2px solid #f0adce96;
                
            }

            #comp_text{
                border: 2px solid #f0adce96 ;
                font-size: 20px;
                width: 455px;
                
                
                margin-top: 5px;
                height: 340px;
                border: 2px solid #f0adce96;
            }
            #chackbox{
                display: flex;
                flex-flow: row;
            }

            #comp_submit{
                width: 460px;
                margin-top: 5px;
                color: white;
                background-color: #f0adce96;
                border: 2px solid #f0adce96;
            }

            #comModal{
                
                display: flex;
                flex-flow: column nowrap;
                align-items: center;
                justify-content: center;
                position: fixed;
                z-index: 1150;
                left: 50%;
                top: 50%;
                transform: translate(-50%, -50%);
                width: 200px;
                height: 60px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 5);
                background: #fff;
                border-radius: 5px;
                text-align: center;
                padding: 20px;
                box-sizing: border-box;
                text-decoration: none; 
                
                transition: all 0.5s;
                display: none;
                font-size: 18px;
                
            }
        </style>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-migrate/3.3.2/jquery-migrate.min.js"></script>

        <script>
     
            $(function(){
            	
                
				/* console.clear(); */

                /* var comResult = "<c:out value='${comResult}'/>";
    	        console.log("comResult:"+comResult); */
    	        if(comResult.length > 0){


					if(comResult==true){  
	                    
	                    $("#comModal").show("slow");
	                    $("#comModal").add("z-index=1100")
	    	        }//if
	    	        
	    	        jQuery(document).ready(function() {
	                    $('#comModal').show();
		            });
	    	        
		            //닫기버튼을 누르면 모달을 숨김
		           //  function close_pop(flag) {
		           //      $('#comp_close').hide();
		           // };
		           
		            //모달을 시간이 지나면 자동으로 숨김 1000초가 1초
		            setTimeout(function() { $('#comModal').hide();}, 2000);																												
                }//if
    	        
                
                $("#compl_close").click(function(){
                    $("#popup").hide("com_register_btn");
                });//#hide

                $("#com_register_btn").click(function(){
                    $("#popup").show("slow");
                    $("#popup").add("z-index=1100")
                });
           
				
                var login="${__LOGIN__.userId}";
                if(login.length>0){
                	
                	$(document).ready(function(){
                        $("#com_register_btn").show("slow");
                    })
                }
                
            });
			
            
        </script>


    </head>
    <body>

        <button id="com_register_btn">요청하기</button>
		
        <div id="popup"> 
            <form action="/complaint/register" method="POST">
            <input type="hidden" name="writer" value="${__LOGIN__.userId}">
                <div id="compl_close">닫기</div>

                <select name="code" id="select">
                    <option value="1">버그리포트</option>
                    <option value="2">영화 수정</option>
                    <option value="3">영화 추가</option>
                    <option value="4">기타</option>
                </select>
                <div id="comp_cont">
                    <textarea name="content" id="comp_text" cols="54" rows="15"placeholder="내용을 입력하세요." ></textarea>
                    
                </div>
                <div id="comp_send">
                    <input type="checkbox" id="checkbox" name="send" value="1" checked>답변 받기
                </div>
                <button id="comp_submit" type="submit" value="results">보내기</button>
            </form>
        </div>
		
      <div id="comModal">
        <div id="comModalClo" >${comResult}</div>
      </div>
    </body>
</html>