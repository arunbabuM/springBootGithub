<!DOCTYPE html>

<html lang="en" dir="ltr">
  <head>
    <meta charset="utf-8">
    <title>Login Page</title>
    <link rel="stylesheet" href="loginregister.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
      integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous" />
  </head>
  <body>
    <div class="center">
      <h2>Reset Password</h2>
      <form method="">
        <div class="txt_field"  id="emailid">
          <input type="text" id="email" name="emailid" required>
          <span></span>
          <label>Enter Your Email</label>
        </div>
        <div class="txt_field token d-none" id="tokenId">
          <input type="token"id="token"  required>
          <span></span>
          <label>Verify Token</label>
        </div>
        <div class="txt_field password d-none" id="passwordId">
            <input type="password" id="password" required>
            <span></span>
            <label>Password</label>
          </div>
          <div class="txt_field password2 d-none" id="password2Id">
            <input type="password2" id="password2"  required>
            <span></span>
            <label>Confirm Password</label>
          </div>
        <input type="submit" id="sendotp" value="Send Otp">
        <input type="submit" class="d-none" id="resetId" value="Reset">
        <div class="signup_link">
          Not a member? <a href="/register">Signup</a>
        </div>
      </form>
    </div>


    <script>
        document.getElementById('sendotp').addEventListener('click',function(e){
            console.log("Button Clicked");
            let email_value = document.querySelector('#email').value;
            let email={email: email_value};            
        e.preventDefault();
        console.log("register>>>",email)
        
         $.ajax({                    
                    url: '/send-otp',
                    type: 'POST',
                    data: JSON.stringify(email) ,
                    contentType: false,                                        
                    success: function (response) {                                                                   
                        
            document.getElementById('emailid').classList.add('d-none');
            document.getElementById('tokenId').classList.remove('d-none');            
            document.getElementById('passwordId').classList.remove('d-none');            
            document.getElementById('password2Id').classList.remove('d-none');
            document.getElementById('sendotp').classList.add('d-none');
            document.getElementById('resetId').classList.remove('d-none');                                           
                        
                    },
                    error: function (error) {
						        console.log("Error>>>>>>>>");
                    alert("Something went wrong");
                    }
                  })

        })


        document.querySelector('#resetId').addEventListener('click',function(e){
          console.log("Reset Clicked")
          let f_token = document.getElementById('token').value;
          let password = document.getElementById('password').value;
          let password2 = document.getElementById('password2').value;

          let resetObj ={
            f_token : f_token,
            password : password,
            password2 : password2
          }
          console.log("resetObj>>",resetObj)
          e.preventDefault();
          
          $.ajax({
                    url: '/resetPassword',
                    type: 'POST',
                    data: JSON.stringify(resetObj) ,
                    contentType: false,                                        
                    success: function (response) {                                           
                        
                                  
                            console.log("hiiiiiiiiiiii")
                            alert("Reset password Successfully");
                      
                            location.href = '/login';                                       
                    },
                    error: function (error) {
						        console.log("Error>>>>>>>>");
                    alert(error.responseText);
                    }

                })
        })
    </script>
 
  </body>
</html>
