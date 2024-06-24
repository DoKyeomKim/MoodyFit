<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>채팅 애플리케이션</title>
<style>
.modal {
    display: none;
    position: fixed;
    z-index: 999;
    top: calc(50% - 175px);
    left: calc(100% - 300px);
    width: 300px;
    max-width: 100%;
    padding: 20px;
}
.modal-content {
    border-radius: 8px;
    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
    width: 300px;
    height: 450px;
    max-width: 100%;
    margin: 0 auto;
}

.username-page-container, .chat-container {
    background-color: #fff;
    padding: 0 20px;
    border-radius: 8px;
    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
    width: 300px;
    max-width: 100%;
}

.username-page-container{
	height:450px;
    display: flex; /* Flexbox를 이용하여 내부 요소를 가운데 정렬 */
    justify-content: center; /* 수평 가운데 정렬 */
    align-items: center; /* 수직 가운데 정렬 */
    flex-direction: column; /* 세로 방향으로 요소 배치 */
}

.title {
    margin-bottom: 20px;
    font-size: 1.5em;
    text-align: center;
}
.form-group {
    margin-bottom: 15px;
}
.form-control {
    width: calc(100% - 10px);
    padding: 10px;
    margin: 0;
    border: 1px solid #ccc;
    border-radius: 4px;
    font-size: 1em;
}
.accent {
    background-color: #007bff;
    color: white;
    padding: 10px 15px;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    font-size: 1em;
    width: 100%;
}
.accent:hover {
    background-color: #0056b3;
}
.hidden {
    display: none;
}
.chat-container {
    display: flex;
    flex-direction: column;
    height: 450px;
}
.chat-header {
    text-align: center;
    font-size: 1.2em;
    margin-bottom: 15px;
}
#messageArea {
    flex-grow: 1;
    overflow-y: auto;
    border: 1px solid #ccc;
    border-radius: 4px;
    padding: 10px;
    margin-bottom: 10px;
    list-style: none;
    background-color: #f9f9f9;
    padding-left: 0;
}
#messageArea li {
    margin-bottom: 10px;
}
.input-group {
    display: flex;
}
.input-group .form-control {
    flex-grow: 1;
    border-top-right-radius: 0;
    border-bottom-right-radius: 0;
}
.primary {
    background-color: #007bff;
    color: white;
    padding: 10px 15px;
    border: none;
    border-top-left-radius: 0;
    border-bottom-left-radius: 0;
    cursor: pointer;
    font-size: 1em;
}
.primary:hover {
    background-color: #0056b3;
}

.user-avatar {
    display: inline-block;
    width: 30px;
    height: 30px;
    border-radius: 50%;
    text-align: center;
    line-height: 30px;
    font-size: 14px;
    margin-right: 10px;
    color: white;
}

.message-content {
    display: inline-block;
    padding: 8px;
    background-color: #e2e2e2;
    border-radius: 8px;
    max-width: 70%;
}

.message-sent {
    text-align: right;
    align-self: flex-end;
}

.message-received {
    text-align: left;
    align-self: flex-start;
}

.username {
    font-weight: bold;
    margin-right: 5px;
}

.welcome-message {
    text-align: center;
    font-weight: bold;
    margin-left :15px;
}
</style>
</head>
<body>
    <div id="username-page">
        <!-- 닉네임 입력 폼을 없애고 바로 채팅 시작 버튼으로 변경 -->
        <div class="username-page-container">
            <h1 class="title">채팅에 입장합니다</h1>
            <button id="enterChatBtn" class="accent">채팅 시작하기</button>
        </div>
    </div>

    <div id="chat-page" class="hidden">
        <!-- 채팅 화면 -->
        <div class="chat-container">
            <div class="chat-header" style="margin-top:15px;">
                실시간 채팅
            </div>
            <ul id="messageArea">
                <!-- 메시지가 표시될 영역 -->
            </ul>
            <form id="messageForm" name="messageForm">
                <div class="form-group">
                    <div class="input-group clearfix">
                        <input type="text" id="message" placeholder="메세지를 입력해주세요" autocomplete="off" class="form-control"/>
                        <button type="submit" class="primary">입력</button>
                    </div>
                </div>
            </form>
        </div>
    </div>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.1.4/sockjs.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
    <script>
        var usernamePage = document.querySelector('#username-page');
        var chatPage = document.querySelector('#chat-page');
        var enterChatBtn = document.querySelector('#enterChatBtn');
        var messageForm = document.querySelector('#messageForm');
        var messageInput = document.querySelector('#message');
        var messageArea = document.querySelector('#messageArea');
        var connectingElement = document.querySelector('.connecting');

        var stompClient = null;
        var username = null;

        var colors = [
            '#2196F3', '#32c787', '#00BCD4', '#ff5652',
            '#ffc107', '#ff85af', '#FF9800', '#39bbb0'
        ];

        function enterChat() {
            var nickName = '<c:out value="${nickName}" />';
            username = nickName.trim();

            if (username) {
                usernamePage.classList.add('hidden');
                chatPage.classList.remove('hidden');

                var socket = new SockJS('/ws');
                stompClient = Stomp.over(socket);

                stompClient.connect({}, onConnected, onError);
            }
        }

        function onConnected() {
            stompClient.subscribe('/topic/public', onMessageReceived);

            stompClient.send("/app/chat.addUser",
                {},
                JSON.stringify({sender: username, type: 'JOIN'})
            );

            connectingElement.classList.add('hidden');
        }

        function onError(error) {
            connectingElement.textContent = '웹소켓 서버에 접속할 수 없습니다. 다시 시도해주세요';
            connectingElement.style.color = 'red';
        }

        function sendMessage(event) {
            var messageContent = messageInput.value.trim();
            if (messageContent && stompClient) {
                var chatMessage = {
                    sender: username,
                    content: messageInput.value,
                    type: 'CHAT'
                };
                stompClient.send("/app/chat.sendMessage", {}, JSON.stringify(chatMessage));
                messageInput.value = '';
            }
            event.preventDefault();
        }

        function onMessageReceived(payload) {
            var message = JSON.parse(payload.body);

            if (message.type === 'JOIN') {
                var welcomeMessageElement = document.createElement('li');
                welcomeMessageElement.classList.add('chat-message', 'message-received', 'welcome-message');

                var welcomeTextElement = document.createElement('p');
                welcomeTextElement.textContent = message.sender + "님이 입장하셨습니다.";
                welcomeTextElement.classList.add('message-content');

                welcomeMessageElement.appendChild(welcomeTextElement);
                messageArea.appendChild(welcomeMessageElement);
                messageArea.scrollTop = messageArea.scrollHeight;
                return;
            }

            if (!message.content.trim()) {
                return;
            }

            var messageElement = document.createElement('li');

            var userAvatar = document.createElement('span');
            userAvatar.textContent = message.sender[0];
            userAvatar.classList.add('user-avatar');
            userAvatar.style.backgroundColor = getAvatarColor(message.sender);

            var usernameElement = document.createElement('span');
            usernameElement.textContent = message.sender;
            usernameElement.classList.add('username');

            var lineBreak = document.createElement('br'); // br 요소 생성

            var textElement = document.createElement('p');
            textElement.textContent = message.content;
            textElement.classList.add('message-content');

            if (message.sender === username) {
                messageElement.classList.add('chat-message', 'message-sent');
                textElement.style.marginTop = '10px';
                messageElement.appendChild(userAvatar);
                messageElement.appendChild(usernameElement);
                messageElement.appendChild(lineBreak); // br 요소 추가
                messageElement.appendChild(textElement);
            } else {
                messageElement.classList.add('chat-message', 'message-received');
                textElement.style.marginTop = '10px';
                textElement.style.marginLeft = '20px';
                userAvatar.style.marginLeft = '10px'; 
                messageElement.appendChild(userAvatar);
                messageElement.appendChild(usernameElement);
                messageElement.appendChild(lineBreak); // br 요소 추가
                messageElement.appendChild(textElement);
            }

            messageArea.appendChild(messageElement);
            messageArea.scrollTop = messageArea.scrollHeight;
        }


        enterChatBtn.addEventListener('click', enterChat);
        messageForm.addEventListener('submit', sendMessage);

        function getAvatarColor(messageSender) {
            var hash = 0;
            for (var i = 0; i < messageSender.length; i++) {
                hash = 31 * hash + messageSender.charCodeAt(i);
            }
            var index = Math.abs(hash % colors.length);
            return colors[index];
        }
    </script>
</body>
</html>        