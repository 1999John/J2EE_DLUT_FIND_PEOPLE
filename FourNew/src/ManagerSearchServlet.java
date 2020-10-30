import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class ManagerSearchServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String id = req.getParameter("searchid");
        String name = new String(req.getParameter("searchname").getBytes("iso-8859-1"),"utf-8");
        String phoneNumber = req.getParameter("searchphoneNumber");
        String QQ = req.getParameter("searchQQ");
        String mail = req.getParameter("searchmail");
        System.out.println(req);
        req.setAttribute("searchid",id);
        req.setAttribute("searchname",name);
        req.setAttribute("searchphoneNumber",phoneNumber);
        req.setAttribute("searchQQ",QQ);
        req.setAttribute("searchmail",mail);
        System.out.println(id+" "+name);
        req.getRequestDispatcher("/ManagerHome.jsp?state=0&listNum=10&page=0").forward(req,resp);
    }
}


