import Dao.ManagerDao;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.swing.text.html.HTML;
import java.io.IOException;

public class DeleteStudentsServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String id = req.getParameter("id");
        if(ManagerDao.deleteUser(id)==0){
            // state 3 删除成功 state 4删除不成功
            resp.sendRedirect(req.getContextPath()+"/ManagerHome.jsp?state=3");
        }else{
            resp.sendRedirect(req.getContextPath()+"/ManagerHome.jsp?state=4");
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req,resp);
    }
}
