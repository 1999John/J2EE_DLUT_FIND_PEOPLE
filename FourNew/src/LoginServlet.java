import Dao.BaseDao;
import Dao.LoginDao;
import Entity.People;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.util.List;

public class LoginServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String userName = req.getParameter("user");
        String userPassword = req.getParameter("password");
        System.out.println(userName+" "+userPassword);
        if(LoginDao.loginStudents(userName,userPassword)) {
            resp.sendRedirect(req.getContextPath()+"/Home.jsp?id="+userName);
        }else if(LoginDao.loginManager(userName,userPassword)) {
            resp.sendRedirect(req.getContextPath()+"/ManagerHome.jsp?state=0&listNum=10&page=0");
        }else {
            resp.sendRedirect(req.getContextPath()+"/Login.jsp");
        }
    }
}
