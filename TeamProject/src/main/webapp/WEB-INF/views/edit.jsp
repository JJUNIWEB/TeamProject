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
    <link rel="stylesheet" href='${pageContext.request.contextPath}/resources/css/comu2.css'>
    <script src='${pageContext.request.contextPath}/resources/script/dangguenwrite.js' defer></script>
    <script src='${pageContext.request.contextPath}/resources/script/toggle.js' defer></script>
    <script src="https://kit.fontawesome.com/cac1ec65f4.js" crossorigin="anonymous"></script>
    <link href="https://fonts.googleapis.com/css2?family=Gaegu&family=Nanum+Gothic:wght@400;700;800&display=swap"
          rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.7/dist/umd/popper.min.js"
            integrity="sha384-zYPOMqeu1DAVkHiLqWBUTcbYfZ8osu1Nd6Z89ify25QV9guujx43ITvfi12/QExE"
            crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.min.js"
            integrity="sha384-Y4oOpwW3duJdCWv5ly8SCFYWqFDsfob/3GkgExXKV4idmbt98QcxXYs9UoXAB7BZ"
            crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <style type="text/css">
	    @charset "UTF-8";
	
		.dangguen-sec {
	    width: 90% auto;
	    background-color: #d7e7e491;
		}
	      #container {
	        display: flex;
	      }
	      .imgbox {
	        position: relative;
	        width: 200px;
	        height: 200px;
	        border: 1px solid black;
	        margin-right: 10px;
	      }
	      .imgbox img {
	        max-width: 100%;
	        max-height: 100%;
	      }
	      .delete-btn {
	        position: absolute;
	        top: 10px;
	        right: 10px;
	        font-size: 20px;
	        font-weight: bold;
	        cursor: pointer;
	        color: red;
	      }
	
    </style>        
    <title>댕댕커뮤 글 수정</title>
</head>

<body>

<jsp:include page="header.jsp"></jsp:include>

<form action="<c:url value='/dangcomu/update${searchItem.queryString}?post_id=${comuDTO.post_id}'/>" id="form" class="board_modify_wrap" enctype="multipart/form-data" method="post">
	<div class="board_wrap">
	    <div class="board_title">
	        <strong>댕댕커뮤</strong>
	        <p>우리 댕댕이 자랑부터 동네 소식까지!</p>
	    </div>
	    <div class="board_write_wrap">
	        <div class="board_write">
	            <div class="title">
	                <dl>
                    	<dd>
                    		<select id="post_ctgr" name="post_ctgr_id" class="form-select" aria-label="category" required>
                                   <option value="">카테고리</option>
                                   <option value="2">반려소식</option>
                                   <option value="3">반려일상</option>
                                   <option value="4">반려질문</option>
                                   <option value="5">펫과사전</option>
                                   <option value="6">육아꿀팁</option>
                                   <option value="7">기타</option>
                            </select><input id="post_title" name="post_title" type="text" placeholder="제목 입력" value="${comuDTO.post_title}" required>
                        </dd>
	                </dl>
	            </div>
	            <section class="dangguen-sec">
	                <div class="info">
	                    <div class="img-sec" style="display: flex;">
						    <input id="fileInput" type="file" accept=".jpg, .jpeg, .png">
						    <button type="button" onclick="addImgBox()">추가</button>
						</div>
								
						<!-- 사진 순서 조정, 추가, 삭제 가능 -->
						<!-- 사진 목록 불러오기 -->
		                <div id="container">
		                	<c:forEach var="photo" items="${photoList}" varStatus="loop">
		                		<div id="imgbox${loop.index+1}" class="imgbox">
								    <img src="${photo.pt_adres}">
								    <span class="delete-btn" onclick="deleteImgBox('imgbox${loop.index+1}')">X</span>
								    <input type="hidden" name="imgbox${loop.index+1}" value="${photo.pt_adres}">
							    </div>
							</c:forEach>
		                </div>
                    </div>
	                <div class="cont">
		                <textarea id="post_content" name="post_content" placeholder="내용 입력" required>
		                    ${comuDTO.post_content}
		                </textarea>
	                </div>
                </section>
	        </div>
	        <div class="bt_wrap">
	            <button type="submit" id="modifyButton" class="on">완료</button>
	            <a href="${pageContext.request.contextPath}/dangcomu/list">취소</a>
	        </div>
	    </div>
	</div>
</form>


<script>
	document.getElementById("form").addEventListener("submit", function(event) {
	  event.preventDefault();
	  Swal.fire({
	    icon: 'success',
	    title: '글 등록이 완료되었습니다.',
	    confirmButtonText: '확인'
	  }).then(() => {
	    this.submit();
	  });
	});
	
	$(document).ready(function() {
	      $("#container").sortable({
	        update: function(event, ui) {
	          var imgboxes = $("#container .imgbox");
	          imgboxes.each(function(index) {
	            var imgbox = $(this);
	            var img = imgbox.find("img");
	            var newImgboxId = "imgbox" + (index + 1);
	            imgbox.attr("id", newImgboxId);
	            imgbox.find(".delete-btn").attr("onclick", "deleteImgBox('" + newImgboxId + "')");
	            imgbox.find("input").attr("name", newImgboxId);
	          });
	        }
	      });
	    });
	  
	    var imgboxCount = container.getElementsByClassName("imgbox").length; // 이미지 박스 개수를 저장하는 변수
	    
	    function addImgBox() {
	      var fileInput = document.getElementById("fileInput");
	      var files = fileInput.files;
	      if (files.length > 0) {
	        var container = document.getElementById("container");
	        var newImgBox = document.createElement("div");
	        newImgBox.className = "imgbox";
	        
	        imgboxCount++; // 이미지 박스 개수 증가
	        var newImgboxId = "imgbox" + imgboxCount; // 새로운 아이디 생성
	        
	        var newImage = document.createElement("img");
	        newImage.src = URL.createObjectURL(files[0]); // 첫 번째 파일의 URL을 설정, 파일 객체를 URL로 변환
	        newImage.onload = function() { 				  // 이미지가 로드될 때 호출되는 함수 정의
	          URL.revokeObjectURL(this.src); // 생성한 URL을 해제, 메모리 누수 방지를 위함
	        };
	        newImgBox.appendChild(newImage); // newImgBox 요소에 newImage를 자식 요소로 추가합니다.
	        
	        // 삭제 버튼 생성
	        var deleteBtn = document.createElement("span");
	        deleteBtn.className = "delete-btn";
	        deleteBtn.textContent = "X";
	        deleteBtn.onclick = function() {
	          deleteImgBox(newImgboxId);
	        };
	        newImgBox.appendChild(deleteBtn);
	        
	        container.appendChild(newImgBox);
	        newImgBox.id = newImgboxId; // 새로운 아이디 설정
	        
	        //드래그 앤 드롭 기능 추가, .imgbox를 핸들로 설정하여 이미지 박스 전체를 드래그할 수 있도록 함
	        $(newImgBox).sortable({
	          handle: ".imgbox"
	        });

	        // 추가한 이미지가 입력되어 있는 상태로 복사하여 붙임
	        var clonedInput = fileInput.cloneNode(true); // fileInput 즉 input 태그를 그대로 복사함
	        clonedInput.id = "fileInput-" + newImgboxId; // 고유한 id 부여
	        clonedInput.name = newImgboxId;
	        clonedInput.style.display = "none";
	        newImgBox.appendChild(clonedInput);
	        fileInput.value = ""; // 파일 입력 필드 초기화
	      }
	    }

	    function deleteImgBox(imgboxId) {
	      var imgbox = document.getElementById(imgboxId);
	      if (imgbox) {
	        imgbox.remove();
	        // 이미지 박스가 삭제되면 아이디 재조정
	        var container = document.getElementById("container");
	        var imgboxes = container.getElementsByClassName("imgbox");
	        for (var i = 0; i < imgboxes.length; i++) {
	          var id = "imgbox" + (i + 1);
	          imgboxes[i].id = id;
	          imgboxes[i].querySelector(".delete-btn").onclick = function() {
	            deleteImgBox(id);
	          };
	          imgboxes[i].querySelector("input").name = id;
	        }
	        imgboxCount = imgboxCount - 1;
	      }
	    }
</script>
</body>
</html>