package Dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;

public class ManagerDao {
    public static int resetInfo(String id, Map<String,String> map) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        Object[] keyset = map.keySet().toArray();

        try {
            conn  = BaseDao.getConnection();
            String setString = "";
            for (int i=0;i<keyset.length;i++) {
                setString += keyset[i]+"=\'"+map.get(keyset[i])+"\',";
            }
            setString = setString.substring(0,setString.length()-1);
            String sql = "update Students set "+setString+" where id=\'"+id+"\';";
            System.out.println(sql);
            pstmt = conn.prepareStatement(sql);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            return 1;
        }
        return 0;
    }
    public static int addUser(String id,Map<String,String> map) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        Object[] keySet = map.keySet().toArray();
        try{
            conn = BaseDao.getConnection();
            String name = map.get("name");
            String phoneNumber = map.get("phoneNumber");
            String QQ = map.getOrDefault("QQ","");
            String mail = map.getOrDefault("mail","");
            String password = map.getOrDefault("password","");
            String sql = "insert into Students values(\'"+name+"\',\'"+id+"\',\'"+phoneNumber+"\',\'"
                    +QQ+"\',\'"+mail+"\',\'"+password+"\');";
            pstmt = conn.prepareStatement(sql);
            pstmt.execute();
        }catch (SQLException e) {
            e.printStackTrace();
            return 1;
        }
        return 0;
    }
    public static int deleteUser(String id) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        try{
            conn = BaseDao.getConnection();
            String sql = "delete from Students where id like \'"+id+"%\';";
            pstmt = conn.prepareStatement(sql);
            pstmt.execute();
        }catch (SQLException e) {
            e.printStackTrace();
            return 1;
        }
        return 0;
    }
    public static ResultSet getStudent(String id) {
        ResultSet rs = null;
        try {
            Connection conn = BaseDao.getConnection();
            String sql = "select * from Students where id=\'"+id+"\';";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
        }catch (SQLException e){
            e.printStackTrace();
        }
        return rs;
    }
    public static void main(String[] args) {
        Map<String,String> map= new HashMap<>();
        map.put("name","–Ï÷æ");
        map.put("phoneNumber","13203339249");
        ManagerDao.addUser("201892383",map);
    }

}
