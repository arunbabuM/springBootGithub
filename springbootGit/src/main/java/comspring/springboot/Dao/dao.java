package comspring.springboot.Dao;


import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class dao {
    @Autowired
    JdbcTemplate jdbcTemplate;

    @Autowired
    HttpSession httpSession;

    public int insert (String data){
        JSONObject json = new JSONObject(data);
        String username = json.getString("username");
        String email = json.getString("email");
        String password = json.getString("password");
        System.out.println(username+email+password);
        String sql ="insert into users(username,email,password) values (?,?,?)";
        System.out.println("jdbc>>>>>>>>>>>>"+jdbcTemplate);
        return jdbcTemplate.update(sql,username,email,password);
    }

    public String verifyLogin(String username){
    try{

        String sql = "select password from users where username =?";
        String password = jdbcTemplate.queryForObject(sql,String.class, username);
        return password;
        }
        catch(Exception e){
        return e.getMessage();
        }
        }

        public List<Map<String, Object>> details(String username)
        {
            String sql = "select * from users where username =?";
            List<Map<String, Object>> details = jdbcTemplate.queryForList(sql,username);
            return details;
        }       


    public int resetPassword(String data) {
        System.out.println("Dao>>>>>"+data);
        
        JSONObject json = new JSONObject(data);
        String emailValue = json.getString("email");
        System.out.println("Json>>>>>"+emailValue);
        String sql = "select id from users where email = ?";
        int id = 0;
        try {
            id = (int) jdbcTemplate.queryForObject(sql, Integer.class, emailValue);
        } catch (Exception e) {
            return 0;
        }
        if (id != 0) {
            int tokenGenerated = (int) Math.floor(100000 + Math.random() * 900000);
            httpSession.setAttribute("token", tokenGenerated);
            httpSession.setAttribute("email", emailValue);
            return id;
        }
        return 0;

    }
    }
