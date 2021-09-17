var action = '';
var url = '';
var type = '';
var rno = 0;

$(document).ready(function(){

	// 새 글 쓰기 버튼 클릭
	$("#writeBtn").click(function(){
		action="/film/register.jsp"
		type = 'get'
		$("#modal-title").text("리뷰 작성");
		$("#myModal").modal();
	});
	
	
	// 수정하기 버튼 클릭
	$("button[name='modify']").click(function(){
		url : '/film/review/modify/m' + rno
		type = 'PUT';
		rno = this.value;

		// content 담기
		var row = $(this).parent().parent().parent();
		var tr = row.children();
		
		var userName = tr.eq(2).text();
		var contents = tr.eq(1).text();

		$("#modal-title").text("수정하기");

		$("#userName").val(userName);
		$("#contents").val(contents);
		
		$("#myModal").modal();
	});	
	// 삭제하기 버튼 클릭
	$("button[name='delete']").click(function(){
		rno = this.value;
		$.ajax({
			/*url : '/film/remove' + rno,*/
			url : '/film/remove',
			type : 'DELETE',
		});
		location.reload();
	})
	
	// Modal의 Submit 버튼 클릭
	$("#modalSubmit").click(function(){
		
		if(action == 'create'){
			rno = 0;
			url = '/film';
		}else if(action == 'modify'){
			url = '/film';
		}

		var data = {
			"rno" : rno,
			"userName" : $("#userName").val(),
			"contents" : $("#contents").val()
		};
		
		$.ajax({
			url : url,
			type : type,
			data : data
		})
		
		location.reload();
	});
	

});