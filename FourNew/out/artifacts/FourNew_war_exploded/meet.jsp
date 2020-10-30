<%--
  Created by IntelliJ IDEA.
  User: John
  Date: 2020/10/20
  Time: 19:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>聊天室</title>
    <style>
        body {
            width: 100%;
            height: 100%;
            font-family: 'Open Sans', sans-serif;
            margin: 0;
            background-image: url('HTMLImage/Image1.jpg');
            background-size: cover;
            overflow: hidden;
        }
        .same{
            padding: 0;
            margin: 0;
            box-sizing: border-box;
            border: 0;
            height: 30px;
        }
        .div{
            position: fixed;
            bottom: 5%;
            left: 30%;
            width: 600px;
            height: 50px;
            border: solid 1px #000000;
        }
        .text{
            width: 80%;
            height: 100%;
            background-color: rgba(147, 147, 147, 0.44);
        }
        .btn{
            width: 20%;
            height: 100%;
            background-color: #59b3f3;
        }

        /*.s_ipt_wr {*/
        /*    position: fixed;*/
        /*    width: 546px;*/
        /*    height: 40px;*/
        /*    bottom: 5%;*/
        /*    left: 30%;*/
        /*}*/

        /*.s_b {*/
        /*    position: fixed;*/
        /*    bottom: 5%;*/
        /*    width: 80px;*/
        /*    height: 46px;*/
        /*    left: 63%;*/
        /*}*/

        .message_content {
            height: 300px;
            width: 800px;
            overflow: auto;
            position: absolute;
            top: 20%;
            left:20%;
        }
    </style>
</head>
<body>
<br/>
<div class="same div"><input id="text" type="text" class="same text"/><button onclick="send()" class="same btn">发送消息</button>
</div>
<div id="message" class="message_content"></div>
</body>
<%
    String id = request.getParameter("id");
%>
<script type="text/javascript">
    var websocket = null;
    //判断当前浏览器是否支持WebSocket
    if ('WebSocket' in window) {
        websocket = new WebSocket("ws://10.6.51.218:8089/FiveTest_war_exploded/websocket/<%=id%>");
    } else {
        alert('当前浏览器 Not support websocket');
    }

    //连接发生错误的回调方法
    websocket.onerror = function () {
        setMessageInnerHTML("WebSocket连接发生错误");
    };

    //连接成功建立的回调方法
    websocket.onopen = function () {
        // setMessageInnerHTML("WebSocket连接成功");
    }

    //接收到消息的回调方法
    websocket.onmessage = function (event) {
        setMessageInnerHTML(event.data);
    }

    //连接关闭的回调方法
    websocket.onclose = function () {
        setMessageInnerHTML("WebSocket连接关闭");
    }

    //监听窗口关闭事件，当窗口关闭时，主动去关闭websocket连接，防止连接还没断开就关闭窗口，server端会抛异常。
    window.onbeforeunload = function () {
        closeWebSocket();
    }

    //将消息显示在网页上
    function setMessageInnerHTML(innerHTML) {
        document.getElementById('message').innerHTML += '<b>' + innerHTML.substr(0, 9) + '</b>' + '<br />' + innerHTML.substr(9) + '<br/>';
    }

    //关闭WebSocket连接
    function closeWebSocket() {
        websocket.close();
    }

    //发送消息
    function send() {
        var message = document.getElementById('text').value;
        websocket.send(message);
    }
</script>
</html>