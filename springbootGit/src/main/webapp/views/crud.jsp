<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
    <title>Document</title>
</head>
<body>
    <h1>Hello</h1>
    <button type="submit" id="details">Profile Info</button>
    <button type="submit" id="addProduct" onclick="window.location.href='addProduct'">Add Product</button>
    <button type="submit" id="productDetails">Product List </button>
    <div id="personal"></div>
<script>
    document.getElementById('details').addEventListener('click',function(){
        console.log("Hiii");
        let data = ajaxGet('/details');
        console.log(data);
        //data = JSON.parse(data);
        let div = `
        <b>Name : \${data[0].username}</b><br>
        <b>Email : \${data[0].email}</b>
        
        `
        document.querySelector("#personal").innerHTML = div;
    })

    document.querySelector('#addProduct').addEventListener('click',function(){
      console.log("clicked add product")
      
    })
 


    function ajaxGet(URL){
        let resp = null;
        $.ajax({
        url: URL,
        type: 'GET',
        async: false,
        contentType:false,
        success: function (response) {
          resp = response;
        },
        error: function (error) {
          resp = error;           
        },
      });
      return resp;
    }


    function ajax(URL, TYPE, DATA){
        let resp = null;
        $.ajax({
        url: URL,
        type: TYPE,
        async: false,
        contentType:false,
        data: JSON.stringify(DATA),
        success: function (response) {
          resp = response;
        },
        error: function (error) {
          resp = error;           
        },
      });
      return resp;
    }


</script>
</body>
</html>