<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>

<html lang="ko">
<head>
    <meta charset="UTF-8" name="viewport" content="width=device=width, initial-scale=1.0">
    <title></title>
    <link rel="stylesheet" href="/resources/css/bootstrap.css">
    <!-- <link rel="stylesheet" href="/resources/css/calender.css"> -->
	<link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" />
    <!-- <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KyZXEAg3QhqLMpG8r+8fhAXLRk2vvoC2f3B09zVXn8CA5QIVfZOJ3BCsw2P0p/We" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-U1DAWAznBHeqEIlVSCgzq+c9gqGAJn5c/t99JyeKa9xxaYpSvHU5awsuZVVFIhvj" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-migrate/3.3.2/jquery-migrate.min.js"></script> -->
	<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
	<script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>

    <style>
        body{
            -ms-user-select: none; 
            -moz-user-select: -moz-none;
            -khtml-user-select: none;
            -webkit-user-select: none;
            user-select: none; 
        }  
        #adminmenuinfo{
            width: 100px;
            background-color: rgba(65, 105, 225, 0.185);
            border-radius: 10px;
            margin: 0 auto;
            text-align: center;
            margin-bottom: 10px;
        }
        #menu{
        	font-size: 40px;
        	width: 998px;
        	margin: 0 auto;
        	text-align: center;
        }
/* =========================================================== */
.clearfix:after {
	content: '';
	display: inline-block;
    width: 990px;
}
/* ======== Calendar ======== */
#mainCalender{
    width: 998px;
    margin: 0 auto;
}
.my-calendar {
	margin: 0 auto;
	width: 700px;
	padding: 20px 20px 10px;
	text-align: center;
	font-weight: 800;
	border: 1px solid #ddd;
}

.my-calendar .clicked-date {
	border-radius: 25px;
	margin-top: 36px;
	width: 42%;
	padding: 46px 0 26px;
	background: rgba(104, 167, 226, 0.192);
    float: left;
}

.my-calendar .calendar-box {
	width: 58%;
	padding-left: 30px;
    float: right;
}

.clicked-date .cal-day {
	font-size: 24px;
}

.clicked-date .cal-date {
	font-size: 130px;
}

.ctr-box {
	padding: 0 16px;
	margin-bottom: 20px;
	font-size: 20px;
}

.ctr-box .btn-cal {
	position: relative;
	/* float: left; */
	width: 25px;
	height: 25px;
	margin-top: 5px;
	font-size: 16px;
	cursor: pointer;
	border: none;
	background: none;
}

.ctr-box .btn-cal:after {
	content: '<';
	position: absolute;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	line-height: 25px;
	font-weight: bold;
	font-size: 20px;
}

.ctr-box .btn-cal.next {
	float: right;
}

.ctr-box .btn-cal.next:after {
	content: '>';
}

.cal-table {
	width: 100%;
}

.cal-table th {
	width: 14.2857%;
	padding-bottom: 5px;
	font-size: 16px;
	font-weight: 900;
}

.cal-table td {
	padding: 3px 0;
	height: 50px;
	font-size: 15px;
	vertical-align: middle;
}

.cal-table td.day {
	position: relative;
	cursor: pointer;
}

.cal-table td.today {
	background: #ffd255;
	border-radius: 50%;
	color: #fff;
}

.cal-table td.day-active {
	background: #ff8585;
	border-radius: 50%;
	color: #fff;
}

.cal-table td.has-event:after {
	content: '';
	display: block;
	position: absolute;
	left: 0;
	bottom: 0;
	width: 100%;
	height: 4px;
	background: #FFC107;
}
#chart_div {
	display: inline-block;
}

#container {
	margin: 0 auto;
}

#piechart {
	width: 900px;
	height: 500px;
}

#overlay {
	position: absolute;
	width: 80px;
	height: 80px;
	top: 110px;
	left: 110px;
	border-radius: 40px;
}

#content {
	/* float: left; */
	/* padding:50px 50px; */
	margin: 0 auto;
	padding-bottom: 40px;
	background: #fff;
	width: 840px;
}

#cafeAdmin #content {
	color: #444;
}

.adm_home {
    width: 800px;
	margin: 0 auto;
}

.date_info {
	position: relative;
	width: 840px;
	height: 19px;
}

.date_selector {
	position: relative;
	top: 1px;
	display: inline-block;
}

.next_stat_btn, .prev_stat_btn {
	/* float: left; */
	display: inline-block;
	width: 10px;
	height: 17px;
	cursor: pointer;
}

.prev_stat_btn {
	background: url(//t1.daumcdn.net/cafe_image/founder/2018/prevBtn.png)
		no-repeat;
	background-size: 10px 17px;
}

.stat_btn.end {
	display: none;
}

.next_stat_btn {
	position: relative;
	left: -2px;
	background: url(//t1.daumcdn.net/cafe_image/founder/2018/nextBtn.png)
		no-repeat;
	background-size: 10px 17px;
}

a {
	font-size: inherit;
}

a, a:hover {
	color: #000;
}

.sr_only {
	position: absolute;
	width: 1px;
	height: 1px;
	padding: 0;
	margin: -1px;
	overflow: hidden;
	clip: rect(0, 0, 0, 0);
	border: 0;
}

.stat_date {
	position: relative;
	top: -2px;
	/* float: left; */
	display: inline-block;
	padding: 0 14px;
	height: 19px;
	font-size: 16px;
	font-weight: 700;
	line-height: 19px;
	vertical-align: middle;
	color: #000;
}

.stat_collect_dt {
	position: absolute;
	top: 0;
	right: 0;
	font-size: 13px;
	color: #888;
}

.stat_title {
font-weight: 700;
    display: inline-block;
    /* height: 18px; */
    font-size: 20px;
    line-height: 1.2;
    vertical-align: top;
    color: #222;
}

.ico_etc_tip {
	position: relative;
	top: 1px;
	left: 2px;
	display: inline-block;
	width: 17px;
	height: 17px;
	background:
		url(//t1.daumcdn.net/cafe_image/founder/2018/ico-etc-tip@1x.png)
		no-repeat;
}

.tip_box {
	position: absolute;
	display: none;
	width: 268px;
	padding: 18px 16px 20px;
	margin-top: 4px;
	border: 1px solid #565a60;
	box-shadow: 0 2px 4px 0 rgb(0 0 0/ 10%);
	background-color: #fff;
}

.box_tooltip_title {
	height: 18px;
	font-size: 14px;
	font-weight: 700;
	line-height: 18px;
	color: #222;
}

.box_tooltip_contents {
	padding-top: 8px;
	font-size: 13px;
	line-height: 18px;
	color: #444;
}

.stat_value {
	display: block;
	width: 170px;
	height: 34px;
	padding-top: 2px;
	font-size: 32px;
	font-weight: 700;
	line-height: 34px;
	color: #222;
	margin-top: 10px;
}

.stat_increase {
	/*position: absolute;*/
	bottom: 40px;
	display: inline-block;
}

.ico_increase.up {
	background:
		url(//t1.daumcdn.net/cafe_image/founder/2018/ico-ranking-up-r@1x.png)
		no-repeat;
}

.ico_increase {
	position: relative;
	top: 4px;
	display: inline-block;
	width: 8px;
	height: 8px;
}

.value_increase.up {
	color: #ed3e49;
}

.value_increase {
	text-align:center;
	font-weight:700;
	position: relative;
	top: 1px;
	display: inline-block;
	height: 18px;
	font-size: 25px;
	line-height: 18px;
	vertical-align: middle;
}

.box_stat {
	/* position: relative; */
    margin: 0 auto;
	margin-top: 20px;
	height: 170px;
	box-sizing: border-box;
	border: 1px solid #e2e2e2;
	background-color: #fafafa;
	padding: 0 0 0 10px;
}

.box_stat .stat {
	position: relative;
    display: inline-block;
    width: 19%;
    height: 88px;
    padding: 38px 30px;
    vertical-align: top;
	text-align: center;
    /* float: left; */
}

.testDatePicker{
    width: 220px;
    height: 40px;
    border-radius: 5px;
    text-align: center;
    font-size: 20px;
    margin-top: 20px;
}
.avatar.avatar-xl{
    margin: 0;
    border-radius: 50%;
    width: 998px;
    height: 55px;
    margin: 50px;
    text-align: center;
}
div.avatar.avatar-xl > img.calendar{
	width: 50px;
	height: 50px;
	border-radius: 0; 
	margin-top: 13px;
}

    </style>
</head>
<body>
    <%@ include file="/resources/html/header.jsp" %>
<div id="container">
    <div>
        <div>
            <div id="adminmenuinfo">관리자 전용</div>
            <div id=menu>
            	<h2>전체</h2>
                <%@include file="menu.jsp"%>
            </div>
        </div>
    </div>
    <div id=mainCalender>
        <div class="my-calendar clearfix">
            <div class="clicked-date">
                <div class="cal-day"></div>
                <div class="cal-date"></div>
            </div>
            <div class="calendar-box">
                <div class="ctr-box clearfix">
                    <button type="button" title="prev" class="btn-cal prev">
                    </button>
                    <span class="cal-month"></span> <span class="cal-year"></span>
                    <button type="button" title="next" class="btn-cal next">
                    </button>
                </div>
                <table class="cal-table">
                    <thead>
                        <tr>
                            <th>일</th>
                            <th>월</th>
                            <th>화</th>
                            <th>수</th>
                            <th>목</th>
                            <th>금</th>
                            <th>토</th>
                        </tr>
                    </thead>
                    <tbody class="cal-body"></tbody>
                </table>
            </div>
        </div>
        <!-- // .my-calendar -->
    </div>

    <div>    
        <div text-align="center">
            <div class="avatar avatar-xl">
                <img class="calendar" src="/resources/img/calender-2389150_1280.png" alt="CAL">
                <!-- <input type="text" class="testDatePicker" id="testDatepicker" placeholder="조회 날짜를 선택하세요."> -->
                <a class="input-button" title="toggle" data-toggle>
                    <i class="icon-calendar"></i></a>
            </div>
        </div>

        <div id="content" class="adm_home">
            <div class="date_info">
                <div class="date_selector">
                    <a role="button" class="stat_btn prev_stat_btn" id="prevBtn">
                        <span class="sr_only">이전 날짜</span>
                    </a>
                    <span id="date" class="stat_date" style="user-select: none;"></span>
                    <a role="button" class="stat_btn next_stat_btn end" id="nextBtn">
                        <span class="sr_only">다음 날짜</span>
                    </a>
                </div>
                <span class="stat_collect_dt"></span>
            </div>

            <!-- =================  Today Total  ================-->
            <div class="box_stat" id="statBox">

                <div class="stat">
                    <span class="stat_title">신규가입자<br><br></span>
                    <br>
                    <span class="value_increase" id="inquire_span">${total.useridno} 명</span>
                </div>

                <div class="stat">
                    <span class="stat_title">신규 리뷰<br><br></span>
                    <br>
                    <span class="value_increase" id="report_span">${total.countrno} 개</span>
                </div>

                <div class="stat">
                    <span class="stat_title">신규게시물<br><br></span>
                    <br>
                    <span class="value_increase" id="board_span">${total.countbno} 개</span>
                </div>

                <div class="stat">
                    <span class="stat_title">신고<br><br></span>
                    <br>
                    <span class="value_increase" id="newMember_span">${total.countrptno} 건</span>
                </div>

                <div class="stat">
                    <span class="stat_title">요청사항<br><br></span>
                    <br>
                    <span class="value_increase" id="saleBoard_span">${total.compno} 건</span>
                </div>
            </div>
        </div>

    </div>


    <!--달력생성-->
    <script type="text/javascript">
        const init = {
        monList: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
        dayList: ['일', '월', '화', '수', '목', '금', '토'],
        today: new Date(),
        monForChange: new Date().getMonth(),
        activeDate: new Date(),
        getFirstDay: (yy, mm) => new Date(yy, mm, 1),
        getLastDay: (yy, mm) => new Date(yy, mm + 1, 0),
        nextMonth: function () {
        let d = new Date();
        d.setDate(1);
        d.setMonth(++this.monForChange);
        this.activeDate = d;
        return d;
        },
        prevMonth: function () {
        let d = new Date();
        d.setDate(1);
        d.setMonth(--this.monForChange);
        this.activeDate = d;
        return d;
        },
        addZero: (num) => (num < 10) ? '0' + num : num,
        activeDTag: null,
        getIndex: function (node) {
        let index = 0;
        while (node = node.previousElementSibling) {
        index++;
        }
        return index;
        }
        };
        
        const $calBody = document.querySelector('.cal-body');
        const $btnNext = document.querySelector('.btn-cal.next');
        const $btnPrev = document.querySelector('.btn-cal.prev');
        function loadDate (date, dayIn) {
        document.querySelector('.cal-date').textContent = date;
        document.querySelector('.cal-day').textContent = init.dayList[dayIn];
        }
        
        function loadYYMM (fullDate) {
        let yy = fullDate.getFullYear();
        let mm = fullDate.getMonth();
        let firstDay = init.getFirstDay(yy, mm);
        let lastDay = init.getLastDay(yy, mm);
        let markToday;  // for marking today date
        if (mm === init.today.getMonth() && yy === init.today.getFullYear()) {
        markToday = init.today.getDate();
        }
        document.querySelector('.cal-month').textContent = init.monList[mm];
        document.querySelector('.cal-year').textContent = yy;
        let trtd = '';
        let startCount;
        let countDay = 0;
        for (let i = 0; i < 6; i++) {
        trtd += '<tr>';
        for (let j = 0; j < 7; j++) {
        if (i === 0 && !startCount && j === firstDay.getDay()) {
            startCount = 1;
        }
        if (!startCount) {
            trtd += '<td>'
        } else {
            let fullDate = yy + '.' + init.addZero(mm + 1) + '.' + init.addZero(countDay + 1);
            trtd += '<td class="day';
            trtd += (markToday && markToday === countDay + 1) ? ' today" ' : '"';
            trtd += ` data-date="${countDay + 1}" data-fdate="${fullDate}">`;
        }
        trtd += (startCount) ? ++countDay : '';
        if (countDay === lastDay.getDate()) { 
            startCount = 0; 
        }
        trtd += '</td>';
        }
        trtd += '</tr>';
        }
        $calBody.innerHTML = trtd;
        }
        function createNewList (val) {
        let id = new Date().getTime() + '';
        let yy = init.activeDate.getFullYear();
        let mm = init.activeDate.getMonth() + 1;
        let dd = init.activeDate.getDate();
        const $target = $calBody.querySelector(`.day[data-date="${dd}"]`);
        
        let date = yy + '.' + init.addZero(mm) + '.' + init.addZero(dd);
        
        let eventData = {};
        eventData['date'] = date;
        eventData['memo'] = val;
        eventData['complete'] = false;
        eventData['id'] = id;
        init.event.push(eventData);
        $todoList.appendChild(createLi(id, val, date));
        }
        
        loadYYMM(init.today);
        loadDate(init.today.getDate(), init.today.getDay());
        
        $btnNext.addEventListener('click', () => loadYYMM(init.nextMonth()));
        $btnPrev.addEventListener('click', () => loadYYMM(init.prevMonth()));
        
        $calBody.addEventListener('click', (e) => {
        if (e.target.classList.contains('day')) {
        if (init.activeDTag) {
        init.activeDTag.classList.remove('day-active');
        }
        let day = Number(e.target.textContent);
        loadDate(day, e.target.cellIndex);
        e.target.classList.add('day-active');
        init.activeDTag = e.target;
        init.activeDate.setDate(day);
        reloadTodo();
        }
        });
    </script>
        
    <script type="text/javascript">
        $(function(){
            var now = new Date();	// 현재 날짜 및 시간
            var year = now.getFullYear();	// 연도
            var month = now.getMonth()+1;
            var date = now.getDate();
            
            if(month<10){
                month='0'+month;
            }
            if(date<10){
                date='0'+date;
            }
            
            $('.cal-day').html(month+"월");
            $('.cal-date').html(date);
            $('.stat_collect_dt').html(year+"."+month+"."+date+" 기준");
            $('.stat_date').html(year+"."+month+"."+date+" 기준");
            
            // $.ajax({
            //     url:'/jaju/manager/getManagerMainCount',
            //     type:'post',
            //     dataType:'json',
            //     success:function(data){
            //         console.log("mainChart에 대한 모든정보" + JSON.stringify(data));
            //         //만약 모든 정보 가져오는 걸 성공했다면 html로 하나씩 넣어주기. 
                    
            //         $('#inquire_span').html(data.inquire_db+'건');
            //         $('#report_span').html(data.report_db+'건');
            //         $('#newMember_span').html(data.newMember_db+'건');
            //         $('#saleBoard_span').html(data.saleReport_db+'건');
        
            //     },error:function(err){
            //         console.log("mainChartJSP에 오류 발생" + err);
            //     }
            // });//ajax
        });
        function getFormatDate(date){
            var year = date.getFullYear();              //yyyy
            var month = (1 + date.getMonth());          //M
            month = month >= 10 ? month : '0' + month;  //month 두자리로 저장
            var day = date.getDate();                   //d
            day = day >= 10 ? day : '0' + day;          //day 두자리로 저장
            return  year + '-' + month + '-' + day;       //'-' 추가하여 yyyy-mm-dd 형태 생성 가능
        }
        $('.cal-body').click(function (){
            var calyear = $('.cal-year').text();
            var calmonth = $('.cal-month').text();
            var dayactive = $('.day-active').text();
            var calmonthMinus = calmonth.substring(0,1); 
            //alert("cal-year/cal-month/day-active : "+calyear+calmonthMinus+dayactive);
            
            if(calmonthMinus<10){
                calmonthMinus='0'+calmonthMinus;
            }
            if(dayactive<10){
                dayactive='0'+dayactive;
            }
            
            var date = new Date(calyear,calmonthMinus-1,dayactive);
            date= getFormatDate(date);
            //alert(date);
            
            if(confirm(date+" 일자로 조회하시겠습니까?")){
            
            $.ajax({
                // url:'/jaju/manager/getCalenderInfo',
                data: {'date': date },
                type:'post',
                dataType:'json',
                success:function(data){
                    //alert("getCalenderInfo 결과물  : " +JSON.stringify(data));
                    //console.log("datepicker 결과물  : " +JSON.stringify(data));
                    $.each(data.list, function(index, items){
                        //console.log(JSON.stringify(data.list[0]));
                        
                        $('.cal-table td.today').css('background', '#fff');
                        $('.cal-table td.today').css('color', '#000000');
        
                        $('.stat_collect_dt').html(date+" 기준");
                        $('.stat_date').html(date+" 기준");
                        
                        $('#inquire_span').html(data.list[0]+'건');
                        $('#report_span').html(data.list[1]+'건');
                        $('#newMember_span').html(data.list[2]+'건');
                        $('#saleBoard_span').html(data.list[3]+'건');
                        
                    });//each
        
                    
                },error:function(err){
                    console.log("managerCalender 에러발생" + err)	
                }
            });
            }
            else{
                alert("다시 선택해주세요.")
            }
        });
        
        
        //$( "#testDatepicker" ).datepicker( "getDate" );
        $('#testDatepicker').change(function (){
            var date = $('#testDatepicker').val();
            //alert("date???" + date);
            
            var arr = date.split('-'); 
            //alert("arr"+arr);
        
            var now = new Date();	// 현재 날짜 및 시간
            var year = arr[0];	// 연도
            var month = arr[1];
            var dateArr = arr[2];
        
            $('.cal-day').html(month+"월");
            $('.cal-date').html(dateArr);
            $('.stat_collect_dt').html(year+"."+month+"."+dateArr+" 기준");
            $('.stat_date').html(year+"."+month+"."+dateArr+" 기준");
            
            $('.cal-table td.today').css("background","#fff");
            $('.cal-table td.today').css("color","#333");
        
            $.ajax({
                // url:'/jaju/manager/getDatePickerInfo',
                data: {'date': date },
                type:'post',
                dataType:'json',
                success:function(data){
                    $('#ui-datepicker-div').hide();
                    
                    //console.log("datepicker 결과물  : " +JSON.stringify(data));
                    $('.stat_collect_dt').html(date+" 기준");
                    $('.stat_date').html(date+" 기준");
                        
                    $('#inquire_span').html(data.inquirePickerCount+'건');
                    $('#report_span').html(data.reportPickerCount+'건');
                    $('#newMember_span').html(data.newMemberPickerCount+'건');
                    $('#saleBoard_span').html(data.saleReportPickerCount+'건');
                    
                
                    /* $.each(arr, function(index, value) { 
                        console.log(index + ':값 = ' + value); 
                    }); */
        
                    
                },error:function(err){
                    console.log("managerCalender 에러발생" + err)	
                }
                
            });
            var arr = date.split('-'); 
            //alert("arr"+arr);
        });
    </script>
    
    
    
    <%@ include file="/resources/html/footer.jsp" %>
</div>
</body>
</html>