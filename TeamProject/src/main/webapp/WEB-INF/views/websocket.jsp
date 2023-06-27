<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        /* 알림창 스타일 */
        .notification {
        	display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 30px;
            background-color: #f1f1f1;
            z-index: 9999;
        }

        /* X 버튼 스타일 */
        .notification button {
            position: absolute;
            top: 0;
            right: 5px;
            width: 30px;
            height: 30px;
            background: none;
            border: none;
            color: #000;
            font-size: 18px;
        }
    </style>
    <title>Document</title>
</head>
<body>

	<div id="notification" class="notification"></div>
	
<script type="text/javascript">
	let socket = null

	$(document).ready(function(){
		connectWS()
	})
   
   function connectWS() {
	  var ws = new SockJS("/withdang/replyEcho")
	  //var ws = new WebSocket("ws://withdang.shop/withdang/replyEcho")
      socket = ws
      
      ws.onopen = function() {
         console.log('Info: connection opened.')
      }
      
      ws.onmessage = function(event) {
         console.log("ReceiveMessage:", event.data+'\n')
         
          let message = JSON.parse(event.data)
          let cmd = message.cmd
          
          if (cmd === "sendchat") {
              var notification = document.getElementById('notification');

              // 기존 알림 삭제
              if (notification) {
            	  notification.parentNode.removeChild(notification);
              }

              // 새로운 알림 생성
              notification = document.createElement('div');
              notification.className = 'notification';
			  notification.style.display = 'block';
			  
              var removeBtn = document.createElement('button');
              removeBtn.type = 'button';
              removeBtn.id = 'removeBtn'
              removeBtn.textContent = 'X';

              notification.appendChild(removeBtn);

              var messageText = document.createElement('span');
              messageText.textContent = message.sender_nickname + '에게 채팅이 왔습니다.';
              notification.appendChild(messageText);

              document.body.appendChild(notification);
              
              removeBtn.addEventListener('click', function() {
            	  notification.parentNode.removeChild(notification);
              });
           }
      }
      
      ws.onclose = function (event){ 
         console.log('Info: connection closed')   
      }
      ws.onerror = function (err){ console.log('Error: ', err) }
   }
</script>
</body>
</html>