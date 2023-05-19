<%--
  Created by IntelliJ IDEA.
  User: ezen
  Date: 2023-05-15
  Time: 오후 5:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

    <script>
        $(document).ready(function () {
            var roomName = [[${roomName}]];
            if(roomName != null)
                alert(roomName + "방이 개설되었습니다.");

            $(".btn-create").on("click", function (e) {
                e.preventDefault();

                var name = $("input[name='name']").val();

                if (name == "")
                    alert("Please write the name.")
                else
                    $("form").submit();
            });
        });

    </script>
    <title>Title</title>
</head>
<body>
<div class="container">
  <div>
<c:forEach var="room" items="${list}">
    <ul>
      <li><a href= "<c:url value= '/chat/room?roomId=${room.roomId}'/>">[[${room.name}]]</a></li>
    </ul>
</c:forEach>
  </div>
</div>
<form action="${pageContext.request.contextPath}/chat/room" method="post">
  <input type="text" name="name" class="form-control">
  <button class="btn btn-secondary">개설하기</button>
</form>
</body>
</html>
