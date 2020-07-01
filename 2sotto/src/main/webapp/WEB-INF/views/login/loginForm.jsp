<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
<head>
	
	<title>로그인</title>
	
	<!-- Favicon -->
	<link rel="icon" type="image/png" sizes="16x16" href="${pageContext.request.contextPath}/images/icons8-cat-footprint-48.png">
	<link rel="shortcut icon" href="${pageContext.request.contextPath}/images/icons8-cat-footprint-48.png" type="image/x-icon">
	
</head>

<body>

	<jsp:include page="/WEB-INF/views/include/headerAndNavi.jsp" />
	
	<div class="side_overlay">
		<div class="container" style="margin-top: 100px">
			<div class="row">
				<div class="col-lg-4 col-md-6 ml-auto mr-auto">
					<div class="card card-login">
						<form class="form" id="loginform" method="post" action="nomalLogin.bit">
							<div class="card-header card-header-primary text-center">
								<h4 class="card-title">Login</h4>
							</div>
							<br>
							<div class="card-body">
								<span class="bmd-form-group">
									<div class="input-group">
										<div class="input-group-prepend">
											<span class="input-group-text">
												<i class="material-icons">mail</i>
											</span>
										</div>
										<input type="text" class="form-control" placeholder="이메일주소" name="userid">
									</div>
								</span>
								<span class="bmd-form-group">
									<div class="input-group">
										<div class="input-group-prepend">
											<span class="input-group-text">
												<i class="material-icons">lock_outline</i>
											</span>
										</div>
					                  	<input type="password" class="form-control" placeholder="비밀번호" name="pwd">
									</div>
								</span>
							</div>
							
							<!-- 소셜로그인 아이콘인데 일단 둠 > 안쓰면 나중에 삭제
							<div class="social-line">
			                  <a href="#pablo" class="btn btn-just-icon btn-link">
			                    <i class="fa fa-facebook-square"></i>
			                  <div class="ripple-container"></div></a>
			                  <a href="#pablo" class="btn btn-just-icon btn-link">
			                    <i class="fa fa-twitter"></i>
			                  <div class="ripple-container"></div></a>
			                  <a href="#pablo" class="btn btn-just-icon btn-link">
			                    <i class="fa fa-google-plus"></i>
			                  <div class="ripple-container"></div></a>
			                </div>
							 -->
							
							<div class="footer text-center">
								 <a href="../index"><button type="submit" class="btn btn-primary">로그인</button></a>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div> <!-- container end -->
	</div> <!-- side_overlay end -->
	
</body>
</html>