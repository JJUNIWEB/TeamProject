<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="loginout" value="${sessionScope.member==null ? 'Login' : 'Logout' }" />
<c:set var="loginoutlink" value="${sessionScope.member==null ? '/login' : '/logout' }" />

<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
    <script src="https://kit.fontawesome.com/cac1ec65f4.js" crossorigin="anonymous"></script>
    <script src="${pageContext.request.contextPath}/resources/script/toggle.js" defer></script>
    <script src="${pageContext.request.contextPath}/resources/script/html2canvas.js"></script>
    <script src="${pageContext.request.contextPath}/resources/script/dangoffice.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.7/dist/umd/popper.min.js" integrity="sha384-zYPOMqeu1DAVkHiLqWBUTcbYfZ8osu1Nd6Z89ify25QV9guujx43ITvfi12/QExE" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.min.js" integrity="sha384-Y4oOpwW3duJdCWv5ly8SCFYWqFDsfob/3GkgExXKV4idmbt98QcxXYs9UoXAB7BZ" crossorigin="anonymous"></script>
    <link href="https://fonts.googleapis.com/css2?family=Gaegu&family=Nanum+Gothic:wght@400;700;800&display=swap" rel="stylesheet">
	<script
		  src="https://code.jquery.com/jquery-3.4.1.js"
		  integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
		  crossorigin="anonymous">
	</script>  
    <title>비밀번호 찾기</title>
</head>

<body>
<header>
    <nav class="navbar">

        <div class="navbar__logo">
            <a href="${pageContext.request.contextPath}/main">with DANG</a>
        </div>

        <ul class="navbar__menu">
            <li><a href="${pageContext.request.contextPath}/main">댕댕여지도</a></li>
            <li><a href="${pageContext.request.contextPath}/dangguen">댕근마켓</a></li>
            <li><a href="${pageContext.request.contextPath}/dangcare">댕댕케어</a></li>
            <li><a href="${pageContext.request.contextPath}/dangcomu/list">댕댕커뮤</a></li>
            <li><a href="${pageContext.request.contextPath}/dangoffice">댕사무소</a></li>
            <c:if test="${ member != null }">
                <li><a href="${pageContext.request.contextPath}/mypage"><i class="fa fa-user-o" id="btnMypage" aria-hidden="true"></i></a></li>
            </c:if>
            <li><button class="btnLogin"><a href="<c:url value='${loginoutlink }' />">${loginout}</a></button></li>

        </ul>

        <a href="#" class="navbar__toggleBtn">
            <i class="fas fa-bars" aria-hidden="true"></i>
        </a>
    </nav>
</header>

<form method="post" class="form-signin" id="Chk-form" name="findform">
		<div class="form-label-group">
			<span><input type="text" id="name" name="user_name" class="input_name" placeholder="이름을 입력해주세요."/></span>
			<span><input type="text" id="nickname" name="user_nickname" class="input_nickname" placeholder="닉네임을 입력해주세요."/></span>
			<span><input type="text" id="email" name="user_email" class="input_email" placeholder="이메일을 입력해주세요."/></span>
			<span class="info_ck">정보를 입력해 주세요</span>
		</div>
		
		<div class="form-label-group">
			<input class="btn"
				type="button" value="비밀번호 찾기">
		</div>
	</form>
		
		
	<script type="text/javascript">
		$(document).ready(function() {
			$(".btn").click(function() {
				
				var nickname = $('.input_nickname').val();          // 닉네임 입력란
				var name = $('.input_name').val();					// 이름 입력란
				var email = $('.input_email').val();				// 이메일 입력란
				
				if(nickname == "" || name == "" || email == "") {
					$('.info_ck').css('display','block');
					infoCheck = false;
				} else {
					$('.info_ck').css('display','none');
					infoCheck = true;
				}
				
				if(infoCheck) {
				
				$("#Chk-form").attr("action", "/withdang/pwdFindRes");
	      		$("#Chk-form").submit();
	      		
				}
				
				return false;
			});
		});
	
	</script>
    
</body>
</html>