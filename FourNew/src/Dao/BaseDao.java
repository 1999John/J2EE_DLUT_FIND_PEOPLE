package Dao;

import Entity.Manager;
import Entity.People;
import Entity.Student;

import java.io.IOException;
import java.io.InputStream;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;
import java.util.Properties;

public class BaseDao {
    private static String url;
    private static String user;
    private static String password;
    private static String driver;
    static {
        try {
            url="jdbc:mysql://localhost:3306/SEFINDPEOPLE?serverTimezone=CTT";
            user="root";
            password="123456";
            driver="com.mysql.cj.jdbc.Driver";
            //4. 注册驱动
            Class.forName(driver);
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }
    public static Connection getConnection() throws SQLException {
        //System.out.println(url);
        return DriverManager.getConnection(url, user, password);
    }

    public static void close(Connection conn, ResultSet rs, PreparedStatement pstmt ) throws SQLException {
        if (rs!=null)rs.close();
        if(pstmt!=null)pstmt.close();
        if(conn!=null){
            conn.close();
            //System.out.println("数据库关闭成功！");
        }
    }

    public static void close(Connection conn) throws SQLException {
        close(conn,null,null);
    }
    public static ResultSet queryAll(String table) throws SQLException {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn  = BaseDao.getConnection();
            String sql = "select * from " + table+";";
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return rs;
    }
    public static List<People> readAllPeople() {
        List<People> list = new ArrayList<>();
        try {
            ResultSet rs = BaseDao.queryAll("Students");
            while(rs.next()) {
                String name = rs.getString(1);
                String id = rs.getString(2);
                String phoneNumber = rs.getString(3);
                String QQ = rs.getString(4);
                String mail = rs.getString(5);
                String passward = rs.getString(6);
                People p = new Student(name,id,phoneNumber,QQ,mail,passward);
                list.add(p);
            }
        }catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public static List<People> readAllManager() {
        List<People> list = new ArrayList<>();
        try {
            ResultSet rs = BaseDao.queryAll("Managers");
            while(rs.next()) {
                String name = rs.getString(1);
                String id = null;
                String phoneNumber = null;
                String QQ = null;
                String mail = null;
                String passward = rs.getString(2);
                People p = new Manager(name,id,phoneNumber,QQ,mail,passward);
                list.add(p);
            }
        }catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

}
