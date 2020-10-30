import Dao.ManagerDao;
import Entity.Manager;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.ResultSet;
import java.util.HashMap;
import java.util.Map;

public class ResetStudentServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String id = req.getParameter("id");
        String name = new String(req.getParameter("name").getBytes("iso-8859-1"),"utf-8");
        String phoneNumber = req.getParameter("phoneNumber");
        String QQ = req.getParameter("QQ");
        String mail = req.getParameter("mail");
        String password = req.getParameter("password");
        Map<String,String> map = new HashMap<>();
        map.put("name",name);
        map.put("phoneNumber",phoneNumber);
        map.put("QQ",QQ);
        map.put("mail",mail);
        map.put("password",password);
        try {
            int state = ManagerDao.resetInfo(id,map);
            // state = 5 修改用户成功 6 不成功
            if(state==0) {
                resp.sendRedirect(req.getContextPath()+"/SingleStudent.jsp?name="+name+"&state=5&id="+id);
            }else{
                resp.sendRedirect(req.getContextPath()+"/SingleStudent.jsp?name="+name+"&state=6&id="+id);
            }
        }catch (Exception e) {
            e.printStackTrace();
        }
    }
}
