<%@ page import="java.sql.ResultSet" %>
<%@ page import="Dao.ManagerDao" %>
<%@ page import="java.io.File" %>
<%@ page import="java.net.URLDecoder" %><%--
  Created by IntelliJ IDEA.
  User: John
  Date: 2020/10/16
  Time: 22:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%
        String id = request.getParameter("id");
        Integer state = 0;
        try{
            state = Integer.parseInt(request.getParameter("state"));
        }catch (Exception e){
            e.printStackTrace();
        }
        String name = "";
        String phoneNumber = "";
        String QQ = "";
        String mail = "";
        String password = "";
        try {
            ResultSet rs = ManagerDao.getStudent(id);
            rs.next();
            name = rs.getString(1);
            phoneNumber = rs.getString(3);
            QQ = rs.getString(4);
            mail = rs.getString(5);
            password = rs.getString(6);
        }catch (Exception e) {
            e.printStackTrace();
        }

        File file = new File(URLDecoder.decode("E:\\大三上\\FourNew\\web\\HTMLImage\\userHead\\","utf-8"));
        File[] tempList = file.listFiles();
        String headPath = "";
        for (File f:tempList) {
            if(f.isFile()&&f.getName().startsWith(id)){
                headPath = f.getName();
            }
        }
        if(headPath.equals("")) {
            headPath = URLDecoder.decode("head.jpg","utf-8");
        }
        System.out.println(headPath);
    %>
    <title><%=name%></title>
    <style type="text/css">
        .round_icon{
            width: 150px;
            height: 150px;
            display: flex;
            border-radius: 50%;
            align-items: center;
            justify-content: center;
            overflow: hidden;
        }
        body {
            width: 100%;
            height: 100%;
            font-family: 'Open Sans', sans-serif;
            margin: 0;
            background-image: url('HTMLImage/Image1.jpg');
            background-size: cover;
            overflow: hidden;
        }
        .info {
            height: 400px;
            width: 900px;
            overflow: auto;
            position: absolute;
            top: 50%;
            left:30%;
        }
        .he{
            position: absolute;
            left: 40%;
            top: 5%;
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
            position: absolute;
            left: 5%;
            top: 20%;
        }
        input{
            background-color: rgba(147, 147, 147, 0.44);
        }
    </style>
</head>
<body>
<% if(state==6) {%>
<div>编辑失败，请重新检查</div>
<%}%>
<div class="he">
<img src="/HTMLImage/userHead/<%=headPath%>" class="round_icon">
<form action="/FourNew_war_exploded/uploadUserHead?id=<%=id%>" enctype="multipart/form-data" method="post">
    <input type="file" name="userHead">
    <br/><br>
    <input type="submit" value="上传">
</form>
</div>
<div class="info">
<form action="/FourNew_war_exploded/ResetStudent" method="post" style="align-content: center">
    姓名:<input name="name" value="<%=name%>">
    学号:<input name="id" value="<%=id%>">
    <br/>
    电话:<input name="phoneNumber" value="<%=phoneNumber%>">
    QQ:<input name="QQ" value="<%=QQ%>">
    <br/>
    mail:<input name="mail" value="<%=mail%>">
    账号密码:<input name="password" value="<%=password%>">
    <br/>
    <button type="submit" name="button" class="button">确定修改</button>
</form>
</div>
</body>
</html>
