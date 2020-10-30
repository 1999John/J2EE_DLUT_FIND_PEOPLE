<%@ page import="java.io.File" %>
<%@ page import="java.net.URLDecoder" %><%--
  Created by IntelliJ IDEA.
  User: John
  Date: 2020/10/14
  Time: 15:15
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<%
  String id = request.getParameter("id");
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
  <head>
    <title>Home</title>
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
      .s_ipt_wr {
        position: absolute;
        width: 546px;
        height: 40px;
        top: 35%;
        left: 30%;
      }
      .s_b {
        position: absolute;
        width: 80px;
        height: 41px;
        top: 35%;
        left: 66%;
      }
      .round_icon{
        position: absolute;
        top:50%;
        left: 30%;
        width: 100px;
        height: 100px;
        display: flex;
        border-radius: 50%;
        align-items: center;
        justify-content: center;
        overflow: hidden;
      }
      .meet{
        position: absolute;
        top:50%;
        left: 60%;
        width: 100px;
        height: 100px;
        display: flex;
        border-radius: 50%;
        align-items: center;
        justify-content: center;
        overflow: hidden;
      }
    </style>
  </head>
  <body>

  <form action="/FourNew_war_exploded/home?id=<%=id%>"  method="post">
    <h1 style="position: absolute;top: 25%;left: 45%">软院找人</h1>
    <input type="text" required="required" name="name" placeholder="姓名" id="input1" class="s_ipt_wr"/>
    <button type="submit"  class="s_b">搜索</button>
  </form>
  <a href="SingleStudent.jsp?id=<%=id%>"><img src="/HTMLImage/userHead/<%=headPath%>" class="round_icon"></a>
  <a href="meet.jsp?id=<%=id%>"><img src="/HTMLImage/Meet.png" class="meet"></a>
  </body>
</html>
