package comspring.springboot.controller;

import java.io.Console;
import java.io.File;
import java.io.IOException;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import comspring.springboot.Dao.dao;

import comspring.springboot.Service.passwordhashService;
import comspring.springboot.model.products;
import comspring.springboot.Service.Userservice;







@Controller
public class controller {

    @Autowired
    dao dao;

    @Autowired
    Userservice userservice;

    @Autowired
    passwordhashService passwordhashService;

    @Autowired
    HttpSession httpSession;
   
    @GetMapping("/home")
    public String home(){
        return "home";
    }

    @GetMapping("/login")
    public String login(){
        return "login";
    }

    @GetMapping("/register")
    public String register(){
        return "register";
    }     
    
    @GetMapping("/resetPassword")
    public String resetPassword(){
        return "resetPassword";
    } 
   
    @GetMapping("/crud")
    public String detailsview(){
        return "crud";
    }

    @GetMapping("/addProduct")
    public String addProductView(){
        return "addProduct";
    }

    @GetMapping("/productList")
    public String ProductList(){
        return "productList";
    }
    // @PostMapping(value = "/insertregister")
    // public String register (@RequestBody String data)
    // {
    //     System.out.println("Data>>>>>>"+data);
    //     JSONObject json = new JSONObject(data);
    //     String password = json.getString("password");
    //     String hashedPassword = passwordhashService.encodePassword(password);
    //     json.put("password", hashedPassword);
    //     System.out.println("CONTROLLER MEIN AAYA HASHE PASSWORD:::::::::::" + json.toString());
    //     dao.insert(json.toString());
    //     return "register";      
    // }

     @PostMapping(value = "/insertregister")
    public String register (@RequestBody String data)
    {
            System.out.println("Data>>>>>>"+data);
             dao.insert(data);
        return "register";      
    }


    
    
    
        @PostMapping(value = "/verify_login")
        @ResponseBody
        public ResponseEntity<?> userdata(@RequestBody String data)
        {
            JSONObject json = new JSONObject(data);
            String f_password = json.getString("password");
            String username = json.getString("username");
            System.out.println("f_password>>>>>>>"+ f_password +"f_name>>>>>>>"+username );
            String passwordDao = dao.verifyLogin(username);
            System.out.println("f_password>>>>>>>"+ f_password +"f_name>>>>>>>"+username +"Dao_password>>>>>" + passwordDao);
            if( f_password.equals(passwordDao))
            {
                httpSession.setAttribute("username", username);
                return ResponseEntity.ok("login successfully");
            }
                return ResponseEntity.status(HttpStatus.NOT_ACCEPTABLE).body("login Error");
            
        }
    
        // @PostMapping(value = "/verify_login")
        // @ResponseBody
        // public ResponseEntity<?> userdata(@RequestBody String data)
        // {
        //     JSONObject json = new JSONObject(data);
        //     String f_password = json.getString("password");
        //     String username = json.getString("username");
        //     System.out.println("f_password>>>>>>>"+ f_password +"f_name>>>>>>>"+username );
        //     String passwordDao = dao.verifyLogin(username);
        //     System.out.println("f_password>>>>>>>"+ f_password +"f_name>>>>>>>"+username +"Dao_password>>>>>" + passwordDao);
        //     if( passwordhashService.verifyPassword(passwordDao, f_password))
        //     {
        //         return ResponseEntity.ok("login successfully");
        //     }
        //         return ResponseEntity.status(HttpStatus.NOT_ACCEPTABLE).body("login Error");
            
        // }

            
        @ResponseBody
        @GetMapping(value = "/details")
        public List<Map<String, Object>> details()
        {
            String username= (String) httpSession.getAttribute("username");
            List<Map<String, Object>> details = dao.details(username);
            System.out.println("data>>"+details);
            return details;      
        }

        @PostMapping("/send-otp")
        @ResponseBody
        public String  verifyEmail(@RequestBody String data){

            System.out.println("INSIDE ::::::::::::::");
            System.out.println("Email ::::::::::::::" + data);
            
        JSONObject json = new JSONObject(data);
        String emailValue = json.getString("email");
        httpSession.setAttribute("email", emailValue);
        System.out.println("Json>>>>>"+emailValue);
        int id = dao.sendOtp(data);
        if(id != 0)
        { 
             
            System.out.println("id>>"+id);              
        int otp = (int) Math.floor(100000 + Math.random() * 900000);
        System.out.println("otp>>>"+otp);
        httpSession.setAttribute("otp", otp);
        int otpFromSession = (int)httpSession.getAttribute("otp");  
        System.out.println("otpsession>>"+otpFromSession);
         userservice.sendEmail("Your Otp for Email Verification is: " + otp, emailValue, 3);
         return "success";
        }
        System.out.println("null>>");
         return "/login";
        }
    
        

    
    @PostMapping(value = "/resetPassword")
    @ResponseBody
    public ResponseEntity<?> resetPassword(@RequestBody String data)
    {
        System.out.println("Controler email");
        JSONObject json = new JSONObject(data);
        String f_token = json.getString("f_token");
        String password = json.getString("password");
        System.out.println("f_token>>>>>>>"+ f_token +"password>>>>>>>"+password );
        
        String email= (String) httpSession.getAttribute("email");        
        System.out.println("email>>>"+email);
        
        if (email != "")
        {
            int otpFromSession = (int)httpSession.getAttribute("otp");  
            if(Integer.parseInt(f_token)==(otpFromSession)){
                dao.resetEmailPassword(data);
            return ResponseEntity.ok("Password reset successfully");
            }            
        }              
            return ResponseEntity.status(HttpStatus.NOT_ACCEPTABLE).body("Reset Error");
    }
    
    @ResponseBody
    @PostMapping(value = "/updateProduct")
     public String updateProduct(@RequestBody String data){
        // dao.editData(data);
        int id= (int) httpSession.getAttribute("id");
      
        System.out.println("idToUpdate :"+id);
        System.out.println("editdata"+data);
        dao.editData(data);
        return "Success";
     }
        
    @PostMapping("/add-product")
    public String AddProduct(@ModelAttribute products product ){

       
        String filePath =  System.getProperty("user.dir") + "/src/main/imagedata";
        String fullpath = filePath+"/" + "-" + new Date().getTime() + product.getFile().getOriginalFilename(); 
         File f1 = new File(fullpath);
         try {
             product.getFile().transferTo(f1);
             product.setImage(fullpath);
             dao.insertProduct(product);
             System.out.println(product);
             return "redirect:/crud";
         } catch (IllegalStateException | IOException e) {
             // TODO Auto-generated catch block
             e.printStackTrace();
             return "error";
         }
    }

    @ResponseBody
    @GetMapping(value = "/allDetails")
    public List<Map<String, Object>> Alldetails(@RequestParam(required = false) String filter) {
        System.out.println("filter>"+filter);
        List<Map<String, Object>> allDetails = dao.allProductdata();

        if(filter == null)
        {
            System.out.println("Alldata>>" + allDetails);
            allDetails = dao.allProductdata();
        }
        else{           
            allDetails = dao.filter(filter);
        }
       
        
        return allDetails;
    }

    @ResponseBody
    @GetMapping(value = "/getAllType")
    public List<Map<String, Object>> getAllType() {

        List<Map<String, Object>> getAllType = dao.getAllType();
        System.out.println("Alldata>>" + getAllType);
        return getAllType;
    }

    //  Active & Deactive
     @ResponseBody
     @PostMapping(value = "/setDeactive")
     public String setDeactive(@RequestParam(required = false) int id) {
         System.out.println("id1 : " + id);
         dao.setDeactive(id);
         return "Success";
     }
 
     @ResponseBody
     @PostMapping(value = "/setActive")
     public String setActive(@RequestParam int id) {
        System.out.println("id2 : " + id);
         dao.setActive(id);
         return "Success";
     }

         // Active & Deactive
    // @ResponseBody
    // @PostMapping(value = "/setDeactive")
    // public String setDeactive1(@RequestBody int id) {
    //     System.out.println("Email : " + id);
    //     dao.setDeactive1(id);
    //     return "Success";
    // }

    // @ResponseBody
    // @PostMapping(value = "/setActive")
    // public String setActive2(@RequestBody int id) {
    //     dao.setActive1(id);
    //     return "Success";
    // }

    
    @ResponseBody
    @GetMapping(value = "/viewEdit")
    public List<Map<String, Object>> viewEdit(@RequestParam(required = false) int id) {

        List<Map<String, Object>> viewEdit = dao.vieweditdata(id);
        httpSession.setAttribute("id", id);
        System.out.println("Alldata>>" + viewEdit);
        return viewEdit;
    }

    
    @GetMapping("/mainDash")
    public String mainDashboard(){
        return"mainDash";
    }

    @GetMapping("/header")
    public String header(){
        return "header";
    }
}



    
 


