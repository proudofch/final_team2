<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<!DOCTYPE html>
<html>
<head>

<title>홈_슬기로운 반려생활</title>

<%@ include file="/WEB-INF/include/import.jsp"%>


</head>
<body>

	<!-- header -->
	<%@ include file="/WEB-INF/include/headerAndNavi.jsp"%>
	<!-- header -->

	<div class="side_overlay">

		<div class="container">


			<button class="btn btn-primary btn-round"
				onclick="location.href='main.bit'">Q&A내용</button>



			<div class="card  card-nav-tabs ">

				<div class="card-body">
					<div class="tab-content text-center">
						<!---------- Q&A 내용  ------------------>

						<div class="table-responsive">
						
							<table class="table">
						 
								<thead class=" text">
									
									<tr>
										<th>작성자</th>
										<td>${qna.userid}</td>
										<th>작성일</th>
										<td>${qna.qatime}</td>
									</tr>
									<tr>
										<th>조회수</th>
										<td>${qna.count}</td>
										<th>첨부파일명</th>
										<td>${qna.filename}</td>
									</tr>
									<tr>
										<th>글번호</th>
										<td>${qna.qaindex}</td>
										<th>제목</th>
										<td>${qna.title}</td>
									</tr>
								</thead>
								 	
								<tbody>
									
									<tr>
										<td colspan="5" align="left" valign=top style="font-family: 돋음; font-size: 12;">
											<div style="margin: 40px 40px 80px 40px;">${qna.content}</div>
										</td>
									</tr>
									<tr>
										<td colspan="5" align="left" valign=top style="font-family: 돋음; font-size: 12;">
											<div style="margin: 40px 40px 80px 40px;">이부분은 관리자가 적어줄 부분입니다.</div>
										</td>
									</tr>


									<tr align="center" valign="middle">
										<td colspan="5">
										<!--<c:if test="${currentPost.user_id == user_id }"> -->
												<a class="btn btn btn-round" href="javascript:history.back();"> 이전 </a>
												<a class="btn btn-rose btn-round" href="edit.bit?qaindex=${qna.qaindex}">
													수정 </a>
											<!-- <a class="btn btn-rose btn-round" href="reply.bit?qaindex=${qna.qaindex}">답글 </a> -->
											<!-- <a id="delete" class="btn btn-white btn-round" href="delete.bit?qaindex=${qna.qaindex}"> 삭제 </a> --> 	
											 <!-- Modal로 보내기 -->
											 <a href="#" data-toggle="modal" data-target="#deleteModal" class="btn btn-white btn-round">삭제</a>	
											 <!-- Modal로 보내기 -->
											<!-- </c:if> --></td>

									</tr>
								</tbody>

							</table>
							
							
							
						</div>
							
							
					</div>

				</div>

			</div>
				
				
			<button class="btn btn-primary btn-round">관리자 댓글</button>
				
				<div id="replybox"></div>
					<!-- 댓글 폼 -->
					<br>
					<form name="reply" id="reply" method="POST">
						${sessionScope.user.userid}님<br>
						<input type="hidden" name="qaindex" id="qaindex" value="${qna.qaindex}">
						<input type="hidden" name="id" id="id" value="${sessionScope.id}">
						<textarea rows="3" cols="" id="content" name="content" style="width: 100%"></textarea>
						<br>
						<input type="button" class="btn btn-rose btn-round" value="댓글 등록" id="writecom">
						<input type="reset" class="btn btn btn-round" value="다시 쓰기">
					</form>
					<!-- 댓글 폼 끝 -->
					
					
		</div>

	</div>
	
	<!-- Modal -->
	
<div class="modal" id="deleteModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">게시물 삭제</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        게시물을 정말 삭제하시겠습니까?
      </div>
      <div class="modal-footer">
  		<button onclick="Delete()" type="button" class="btn btn-primary">삭제하기</button>
        <button type="button" class="btn btn-secondary" data-dismiss="modal">취소하기</button>
       	
      </div>
    </div>

  </div>
</div>
<!-- Modal -->


 <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script> 


<script>


	// 삭제 전 확인 창 띄우기 confirm
	/*
	$('#delete').click(function(){
		let con = confirm("정말로 삭제 하시겠습니까?");
		if(con){
			return location.href='delete.bit?qaindex=${qna.qaindex}';
		}else{
			return false;
		}
	});
	*/
	<!-- Modal에서 삭제 -->
	// 삭제 전 확인 창 띄우기
	function Delete() {
	    location.replace("delete.bit?qaindex=${qna.qaindex}"); 
	  }
	<!-- Modal에서 삭제 --> 
	
	
	
		

	
	//모든 요소 load 후 댓글 목록과 댓글 쓰기 폼 불러오기
	$(function() {
		
		getReplyList();
		insertReply();
		
	});


	//댓글 목록 가져오기
	function getReplyList() {
		
		$.ajax({
			url:"reply.bit",
			datatype: "json",
			data: { qaindex:'${qna.qaindex}'},
			success: function(data) {
				
				var html = "";
				console.log("data: "+data);
				
				$.each(JSON.parse(data), function(index, element) {
					
					
					html += "<form action='ReplyDelete' method='POST'>";
					html += "<div id='reply_id'><b>";
					html += element.id;
					html += "</b></div>";
					html += "<div id='reply_content'>";
					html += element.replycont;
					html += "</div>";
					html += "<div id='reply_date'><h6>";
					html += element.replydate;
					html += "</h6></div>";
					html += "<input type='hidden' name='replynum' id='replynum' value='";
					html += element.replynum;
					html += "'> <input type='submit' value='삭제' class='button small' onclick='deleteReply(this.form)'>";
					html += "</form>";
					
				});
				
				$('#replybox').append(html);
				
			}
		});
		
	}


	//댓글 쓰기
	function insertReply() {
		$('#writecom').click(function(){
			
			if(!reply.content.value) {
				swal('댓글 내용을 입력하세요!');
				reply.content.focus();
				return false;
			}
			
			$.ajax ({
				
				url:"ReplyInsert",
				datatype:"json",
				data: { qaindex:'${qna.qaindex}',
						id: '${qna.userid}',
						content: $('#content').val()
					  },
				success: function(data) {
						$('#replybox').empty();
						getReplyList();
						$('#content').val("");
						
					}
					
			});
			
			return false;
			
		});
	}


	//댓글 삭제

	function deleteReply(form) {
		$(form).on("submit", function() {
			
			var data = $(this).serialize();
			
			$.ajax({
				url: "ReplyDelete",
				data: data,
				success: function(data) {
					$('#replybox').empty();
					getReplyList();
				}
			});
			return false;
		});
	}
	
</script>
	
		<%@ include file="/WEB-INF/include/footer.jsp"%>
</body>
</html>