import Dao.ManagerDao;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

public class AddStudentsServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req,resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String name = new String(req.getParameter("name").getBytes("iso-8859-1"),"utf-8");
        String id = req.getParameter("id");
        String phoneNumber = req.getParameter("phoneNumber");
        String QQ = req.getParameter("QQ");
        String mail = req.getParameter("mail");
        String password = req.getParameter("password");
        System.out.println(name+" "+id+" "+phoneNumber+" "+QQ+" "+mail+" "+password);
        Map<String,String> map = new HashMap<>();
        map.put("name",name);
        map.put("phoneNumber",phoneNumber);
        map.put("QQ",QQ);
        map.put("mail",mail);
        map.put("password",password);
        int state = ManagerDao.addUser(id,map)==0?1:2;
        // 1 添加用户成功，2 添加用户不成功
        resp.sendRedirect(req.getContextPath()+"/ManagerHome.jsp?state="+state);
    }
}
