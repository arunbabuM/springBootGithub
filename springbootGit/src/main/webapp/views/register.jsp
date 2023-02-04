<!DOCTYPE html>
<!-- Coding By CodingNepal - youtube.com/codingnepal -->
<html lang="en" dir="ltr">
  <head>
    <meta charset="utf-8">
    <title>Register Page</title>
    <link rel="stylesheet" href="loginregister.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
  </head>
  <body>
    <div class="center">
      <h1>Register</h1>
      <form method="">
        <div class="txt_field">
          <input type="text" name="username" id="username" required>
          <span></span>
          <label>Username</label>
        </div>
        <div class="txt_field">
          <input type="text" name="email" id="email" required>
          <span></span>
          <label>Email</label>
        </div>
        <div class="txt_field">
          <input type="password" name="password" id="password" required>
          <span></span>
          <label>Password</label>
        </div>
        
        <input type="submit" id="submit" value="Register">
        <div class="signup_link">
          Already a Member <a href="/login">Sign-in</a>
        </div>
      </form>
    </div>



    <script>
      document.querySelector('#submit').addEventListener('click',function(e){
        e.preventDefault();
        console.log("Clicked Register")
        let username = document.querySelector("#username").value;
        let email = document.querySelector("#email").value;
        let password = document.querySelector("#password").value;

        let obj ={
          username : username,
          email : email ,
          password : password
        }

        console.log("object>>>>>>>>>>>>>",obj);

        $.ajax({
                    url: '/insertregister',
                    type: 'POST',
                    data: JSON.stringify(obj) ,
                    contentType: false,                                        
                    success: function (response) {                                           
                        // let object = JSON.stringify(obj);
                      console.log("response"+ obj.username) ;              
                            console.log("hiiiiiiiiiiii")
                            alert("Register Successfully");
                      
                            location.href = '/login';                                       
                    },
                    error: function (error) {
						        console.log("Error>>>>>>>>");
                    alert("Something went wrong");
                    }

                })

      })
     

    </script>
  </body>
</html>
