<!DOCTYPE html>
<!-- Coding By CodingNepal - youtube.com/codingnepal -->
<html lang="en" dir="ltr">
  <head>
    <meta charset="utf-8">
    <title>Login Page</title>
    <link rel="stylesheet" href="loginregister.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
  </head>
  <body>
    <div class="center">
      <h1>Login</h1>
      <form method="">
        <div class="txt_field">
          <input type="text" id="username" required>
          <span></span>
          <label>Username</label>
        </div>
        <div class="txt_field">
          <input type="password" id="password" required>
          <span></span>
          <label>Password</label>
        </div>
        <div class="pass"><a href="/resetPassword">Forgot Password?</a></div>
        <input type="submit" id="login" value="Login">
        <div class="signup_link">
          Not a member? <a href="/register">Signup</a>
        </div>
      </form>
    </div>

    <script>
      document.querySelector('#login').addEventListener('click',function(e){
        console.log("Clicked Login");
        let username = document.querySelector('#username').value;
        let password = document.querySelector('#password').value;
        let obj ={
          username : username,
          password : password
        }

        e.preventDefault();
        
        console.log("register>>>",obj)
        $.ajax({
                    url: '/verify_login',
                    type: 'POST',
                    data: JSON.stringify(obj) ,
                    contentType: false,                                        
                    success: function (response) {                                           
                        
                      console.log("response"+ response) ;              
                            console.log("hiiiiiiiiiiii")
                            alert("Login Successfully");
                            location.href = '/crud';
                      
                        
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
