<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <title>FILMEE | FILM MEETING</title>
    <link rel="icon" href="/resources/img/favicon_noback.ico" type="image/x-icon">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KyZXEAg3QhqLMpG8r+8fhAXLRk2vvoC2f3B09zVXn8CA5QIVfZOJ3BCsw2P0p/We" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-U1DAWAznBHeqEIlVSCgzq+c9gqGAJn5c/t99JyeKa9xxaYpSvHU5awsuZVVFIhvj" crossorigin="anonymous"></script>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" referrerpolicy="no-referrer"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-migrate/3.3.2/jquery-migrate.min.js" referrerpolicy="no-referrer"></script>

    <link rel="icon" href="/img/favicon_noback.ico" type="image/x-icon">

    <link rel="stylesheet" href="/resources/css/layout.css">
    <link rel="stylesheet" href="/resources/css/swiper.css">
    <link rel="stylesheet" href="/resources/css/main.css">

    <script src="/resources/js/jquery-1.8.3.min.js"></script>
    <script src="/resources/js/swiper.js"></script>
    <script>
        
    	window.onload = function(){
            var swiper = new Swiper('.swiper-container', {
                        pagination: '.swiper-pagination',
                        paginationType: 'progress',
                        slidesPerView: 'auto',
                        paginationClickable: true,
                        spaceBetween: 0,
                        freeMode: true,
                        nextButton: '.next',
                        prevButton: '.back'
            });
        };
    
    </script>
    
    <style>
    
    	#container {
    		width: 998px;
    		margin: 0 auto;
    		
    		font-family: 'ELAND 초이스';
    	}
    	
    	#mainFilm {
    		position: relative;
    	}
    	
    	#mainPosterUl {
    		position: relative;
    		
    		height: 300px;
    	}
    	
    	.filmPosterList {
    		float: left;
    		
    		margin: 5px;    		
    	}
    	
    	#hoverPost {
    		z-index: 8;
    		position:absolute; 
    		top:20px; 
    		left:22px;
    	}
    	
    	.hoverEventList {
    		width:160px; 
    		height:250px; 
    		border:1px solid black;
    		
    		float:left;
    	}
    
    </style>

</head>    

<body>
    <%@include file="/resources/html/header.jsp"  %>

    <div id="container">
            
 
        <div id="mainback">
            <img class="img-fluid" src="/resources/img/common.jpg" alt="mainbackimg" width="998">
    
        </div>

        <div id="mainText">
            <p>
                Track films you’ve watched.<br> Save those you want to see.<br>Tell your friends what’s good.
            </p>
            <p></p>
            <p>
                The social network for film lovers.
            </p>
        </div>
        
        <hr>
        
        <div id='mainFilm' style='height:300px;'>
        
        	<ul id='mainPosterUl'>
        		<li class="filmPosterList" style='margin-left: 8px;'><img src='../resources/img/fitem01.jpg' ></li>    			

        		<li class="filmPosterList"><img src='../resources/img/fitem01.jpg' ></li>
        		<li class="filmPosterList"><img src='../resources/img/fitem01.jpg' ></li>
        		<li class="filmPosterList"><img src='../resources/img/fitem01.jpg' ></li>
        		<li class="filmPosterList"><img src='../resources/img/fitem01.jpg' ></li>
        	</ul>
        	
        	<ul id='hoverPost'>
        		<li class='hoverEventList'></li>
        		<li class='hoverEventList' style='margin-left: 38px;'></li>
        		<li class='hoverEventList' style='margin-left: 38px;'></li>
        		<li class='hoverEventList' style='margin-left: 38px;'></li>
        		<li class='hoverEventList' style='margin-left: 38px;'></li>
        	</ul>
        
        </div>
        
        <hr>
        
        <h1 class="display-6">Recent Reviews</h1>
        

    </div>  
    <%@include file="/resources/html/footer.jsp" %>
      
</body>
</html>