<%@ page import="java.util.regex.Pattern" %>
<%@ page import="Entity.People" %>
<%@ page import="Dao.BaseDao" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %><%--
  Created by IntelliJ IDEA.
  User: John
  Date: 2020/10/15
  Time: 21:07
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>ManagerHome</title>
    <link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://cdn.staticfile.org/jquery/2.1.1/jquery.min.js"></script>
    <script src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
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
    </style>
</head>
<body>
<%

    int state = 0;
    String searchid = "";
    String searchname = "";
    String searchphoneNumber = "";
    String searchQQ = "";
    String searchmail = "";
    try {
        state = Integer.parseInt(request.getParameter("state"));
    } catch (Exception e) {
        e.printStackTrace();
        state = 0;
    }
    try {
        searchid = request.getParameter("searchid");
    } catch (Exception e) {
        e.printStackTrace();
    }
    try {
        searchname = new String(request.getParameter("searchname").getBytes("iso-8859-1"), "utf-8");
    } catch (Exception e) {
        e.printStackTrace();
    }
    try {
        searchphoneNumber = request.getParameter("searchphoneNumber");
    } catch (Exception e) {
        e.printStackTrace();
    }
    try {
        searchQQ = request.getParameter("searchQQ");
    } catch (Exception e) {
        e.printStackTrace();
    }
    try {
        searchmail = request.getParameter("searchmail");
    } catch (Exception e) {
        e.printStackTrace();
    }
    if (searchid == null) {
        searchid = "";
    }
    if (searchname == null) {
        searchname = "";
    }
    if (searchphoneNumber == null) {
        searchphoneNumber = "";
    }
    if (searchQQ == null) {
        searchQQ = "";
    }
    if (searchmail == null) {
        searchmail = "";
    }
    System.out.println("搜索的内容是: " + searchid + " " + searchname + " " + searchphoneNumber + " " + searchQQ + " " + searchmail);
    List<People> list = BaseDao.readAllPeople();
    List<People> rightPeople = new ArrayList<>();
    for (int i = 0; i < list.size(); i++) {
        People p = list.get(i);
        boolean idma = (Pattern.matches(".*" + searchid + ".*", p.getId()) || searchid.equals(""));
        boolean namema = (Pattern.matches(".*" + searchname + ".*", p.getName()) || searchname.equals(""));
        boolean pnma = (Pattern.matches(".*" + searchphoneNumber + ".*", p.getPhoneNumber()) || searchname.equals(""));
        boolean qqma = (Pattern.matches(".*" + searchQQ + ".*", p.getQQNumber()) || searchQQ.equals(""));
        boolean mailma = (Pattern.matches(".*" + searchmail + ".*", p.getMail()) || searchmail.equals(""));
        if (idma && namema && pnma && qqma && mailma) {
            rightPeople.add(p);
        }
    }
    //取得提交的数字，并显示
    int n = 10;
    int pageNum = 10;
    int currentPage = 0;
    try {
        n = Integer.parseInt(request.getParameter("listNum"));
        pageNum = rightPeople.size() / n + 1;
        currentPage = Integer.parseInt(request.getParameter("page"));
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
<% if (state == 1) { %>
<div> 添加学生成功</div>
<%} else if (state == 2) { %>
<div>添加学生不成功</div>
<%} else if (state == 3) {%>
<div>删除学生成功</div>
<%} else if (state == 4) {%>
<div>删除学生不成功</div>
<%
} else if (state == 5) {
    String name = new String(request.getParameter("name").getBytes("iso-8859-1"), "utf-8");
%>
<div>修改<%=name%>的信息成功</div>
<%}%>

<form action="/FourNew_war_exploded/ManagerSearch" method="post">
    学号: <input name="searchid" value="<%=searchid%>">
    姓名: <input name="searchname" value="<%=searchname%>">
    电话: <input name="searchphoneNumber" value="<%=searchphoneNumber%>">
    QQ: <input name="searchQQ" value="<%=searchQQ%>">
    Mail: <input name="searchmail" value="<%=searchmail%>">
    <button type="submit">确认</button>
</form>
<div>共有<%=rightPeople.size()%>个人,共有<%=pageNum%>页</div>

<form method=post action="ManagerHome.jsp?&page=<%=currentPage%>"><!-- 提交给自身 -->
    每页显示<select name="listNum">
        <% if (n == 10) { %>
        <option selected="selected" value=10>10</option>
        <option value=20>20</option>
        <%} else {%>
        <option value=10>10</option>
        <option selected="selected" value=20>20</option>
        <%}%>
    </select>

    <input type="submit" value="提交" name="submit">
</form>


<%-- 显示list--%>
<table border="10" cellpadding="10">
    <tr>
        <td>学号</td>
        <td>姓名</td>
        <td>电话</td>
        <td>QQ</td>
        <td>邮箱</td>
    </tr>
    <% for (int i = currentPage * n; i < currentPage * n + n && i < rightPeople.size(); i++) {
        People p = rightPeople.get(i);
    %>
    <tr>
        <td><a href="SingleStudent.jsp?id=<%=p.getId()%>"><%=p.getId()%>
        </a>
        </td>
        <td><%=p.getName()%>
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

<%--显示下面的button--%>
<%
    String url = "ManagerHome.jsp?&state=0&listNum=" + n;
    if (!searchid.equals("")) {
        url += "&searchid=" + searchid;
    }
    if (!searchname.equals("")) {
        url += "&searchname=" + searchname;
    }
    if (!searchphoneNumber.equals("")) {
        url += "&searchphoneNumber=" + searchphoneNumber;
    }
    if (!searchQQ.equals("")) {
        url += "&searchQQ=" + searchQQ;
    }
    if (!searchmail.equals("")) {
        url += "&searchmail=" + searchmail;
    }
%>
<form action="<%=url%>" method="post">
    <% if (currentPage == 0) {%>
    <button type="button" disabled="disabled">上一页</button>
    <% } else {
        int lastpage = currentPage - 1;%>
    <button type="submit" value="<%=lastpage%>" name="page">上一页</button>
    <%}%>
    <% for (int i = 0; i < pageNum; i++) { %>
    <% if (currentPage == i) {%>
    <button type="button" disabled="disabled"><%=i%>
    </button>
    <% } else {%>
    <button type="submit" value="<%=i%>" name="page"><%=i%>
    </button>
    <%}%>
    <%}%>
    <% if (pageNum == 1 || currentPage >= pageNum - 1) {%>
    <button type="button" disabled="disabled">下一页</button>
    <% } else {
        int nextpage = currentPage + 1;
    %>
    <button type="submit" value="<%=nextpage%>" name="page">下一页</button>
    <%}%>
</form>

<%-- 添加用户 --%>
<div class="panel-group" id="accordion">
    <div class="panel panel-default">
        <div class="panel-heading" style="background-color: rgba(0,0,0,0.2);display: block;">
            <h4 class="panel-title">
                <a data-toggle="collapse" data-parent="#accordion"
                   href="#collapseOne">
                    添加新同学
                </a>
            </h4>
        </div>
        <div id="collapseOne" class="panel-collapse collapse in">
            <div class="panel-body" style="background-color: rgba(0,0,0,0.2);display: block;">
                <form method="post" action="/FourNew_war_exploded/AddStudents">
                    <input name="id" placeholder="学号">
                    <input name="name" placeholder="姓名">
                    <input name="phoneNumber" placeholder="电话号码">
                    <input name="QQ" placeholder="QQ">
                    <input name="mail" placeholder="电子邮箱">
                    <input name="password" placeholder="账号密码">
                    <button type="submit" name="button">提交</button>
                </form>
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading" style="background-color: rgba(0,0,0,0.2);display: block;">
            <h4 class="panel-title">
                <a data-toggle="collapse" data-parent="#accordion"
                   href="#collapseTwo">
                    删除同学
                </a>
            </h4>
        </div>
        <div id="collapseTwo" class="panel-collapse collapse">
            <div class="panel-body" style="background-color: rgba(0,0,0,0.2);display: block;">
                <form method="post" action="/FourNew_war_exploded/DeleteStudents">
                    <input name="id" placeholder="学号/支持模糊匹配">
                    <button name="button">确定</button>
                </form>
            </div>
        </div>
    </div>
</div>
</body>
</html>
