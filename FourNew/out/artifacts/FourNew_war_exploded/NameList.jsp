<%@ page import="Entity.People" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.regex.Pattern" %>
<%@ page import="Dao.BaseDao" %><%--
  Created by IntelliJ IDEA.
  User: John
  Date: 2020/10/14
  Time: 16:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<%
    String name = request.getParameter("name");
    String pattern = ".*" + name + ".*";
    List<People> rightList = new ArrayList<>();
    List<People> list = BaseDao.readAllPeople();
    for (int i = 0; i < list.size(); i++) {
        People p = list.get(i);
        if (Pattern.matches(pattern, p.getName())) {
            rightList.add(p);
        }
    }
    //取得提交的数字，并显示
    int n = Integer.parseInt(request.getParameter("listNum"));
    int pageNum = rightList.size() / n + 1;
    int currentPage = Integer.parseInt(request.getParameter("page"));
%>
<head>
    <title>name</title>
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
            position: relative;
            width: 546px;
            height: 40px;
        }
        .s_b {
            position: relative;
            width: 80px;
            height: 41px;
        }
    </style>
</head>
<body>
<form action="/FourNew_war_exploded/home?listNum=<%=n%>&page=0" method="post">
    <input type="text" required="required" name="name" value="<%=name%>" class="s_ipt_wr" id="input1"/>
    <button type="submit" class="s_b">确定</button>
</form>


<div>共有<%=rightList.size()%>个人,共有<%=pageNum%>页</div>

<form method=post action="NameList.jsp?name=<%=name%>&page=<%=currentPage%>"><!-- 提交给自身 -->
    每页显示<select name="listNum">
        <% if (n == 5) { %>
        <option selected="selected" value=5>5</option>
        <option value=10>10</option>
        <%} else {%>
        <option value=5>5</option>
        <option selected="selected" value=10>10</option>
        <%}%>
    </select>

    <input type="submit" value="提交" name="submit">
</form>
<table border="10" cellpadding="10">
    <tr>
        <td>姓名</td>
        <td>学号</td>
        <td>电话</td>
        <td>QQ</td>
        <td>邮箱</td>
    </tr>
    <% for (int i = currentPage*n; i < currentPage*n+n && i < rightList.size(); i++) {
        People p = rightList.get(i);
    %>
    <tr>
        <td><%=p.getName()%>
        </td>
        <td><%=p.getId()%>
        </td>
        <td><%=p.getPhoneNumber()%>
        </td>
        <td><%=p.getQQNumber()%>
        </td>
        <td><%=p.getMail()%>
        </td>
    </tr>
    <%}%>
</table>
<form action="NameList.jsp?name=<%=name%>&listNum=<%=n%>" method="post">
<% if (currentPage == 0) {%>
    <button type="button" disabled="disabled">上一页</button>
<% }else {
    int lastpage = currentPage-1;%>
    <button type="submit" value="<%=lastpage%>" name="page">上一页</button>
<%}%>
<% for (int i = 0; i < pageNum; i++) { %>
    <% if (currentPage == i) {%>
    <button type="button" disabled="disabled"><%=i%></button>
    <% }else {%>
    <button type="submit" value="<%=i%>" name="page"><%=i%></button>
    <%}%>
<%}%>
    <% if(pageNum==1 || currentPage>=pageNum-1) {%>
    <button type="button" disabled="disabled">下一页</button>
    <% }else {
    int nextpage = currentPage + 1;
    %>
    <button type="submit" value="<%=nextpage%>" name="page">下一页</button>
    <%}%>
</form>
</body>
</html>
