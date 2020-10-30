package Dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class LoginDao extends BaseDao{
    public static boolean loginStudents(String id,String password){
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn  = BaseDao.getConnection();
            String sql = "select password from " +"Students where id=\'"+id+"\';";
            System.out.println(sql);
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            rs.next();
            if(rs.getString(1).equals(password)) {
                return true;
            }
            return false;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    public static boolean loginManager(String name,String password) {
        Connection conn=null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try{
            conn = BaseDao.getConnection();
            String sql = "select passward from Managers where name=\""+name+"\";";
            System.out.println(sql);
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            rs.next();
            System.out.println(rs.getString(1));
            if(rs.getString(1).equals(password)){
                return true;
            }
            return false;
        }catch (SQLException e) {
            e.printStackTrace();;
            return false;
        }
    }
    public static void main(String[] args) {
        if(loginStudents("201892455","123456")) {
            System.out.println("ok");
        }
    }
}
