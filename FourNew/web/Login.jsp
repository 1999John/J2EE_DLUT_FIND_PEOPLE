<%@ page import="java.net.URLDecoder" %><%--
  Created by IntelliJ IDEA.
  User: John
  Date: 2020/10/15
  Time: 19:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%
        System.out.println(request.getContextPath());
    %>
    <title>登录</title>
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

        .box {
            align-content: center;
            position: absolute;
            top: 25%;
            left: 40%;
            width: 300px;
            height: 200px;
        }
        .input{
            width: 278px;
            height: 50px;
            margin-bottom: 10px;
            outline: none;
            padding: 10px;
            font-size: 13px;
            color: #fff;
            text-shadow:1px 1px 1px;
            border-top: 1px solid #312E3D;
            border-left: 1px solid #312E3D;
            border-right: 1px solid #312E3D;
            border-bottom: 1px solid #56536A;
            border-radius: 4px;
            background-color: #2D2D3F;

        }
        .button{
            width: 300px;
            min-height: 20px;
            display: block;
            background-color: #4a77d4;
            border: 1px solid #3762bc;
            color: #fff;
            padding: 9px 14px;
            font-size: 15px;
            line-height: normal;
            border-radius: 5px;
            margin: 0;
        }
    </style>
</head>
<body>
<div class="box">
<h1 align="center">登录</h1>
<form action="/FourNew_war_exploded/login" method="post" align="center">
    <input type="text" required="required" placeholder="用户名/学号" name="user" class="input">
    <br/>
    <input type="password" required="required" placeholder="密码" name="password" class="input">
    <br/>
    <button align="center" type="submit" class="button">登录</button>
</form>
</div>
</body>
</html>
