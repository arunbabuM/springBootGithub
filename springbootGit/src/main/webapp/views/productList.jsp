<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
    <title>Document</title>
</head>  
<style>
#products {
  font-family: Arial, Helvetica, sans-serif;
  border-collapse: collapse;
  width: 100%;
}

#products td, #products th {
  border: 1px solid #ddd;
  padding: 8px;
}

#products tr:nth-child(even){background-color: #f2f2f2;}

#products tr:hover {background-color: #ddd;}

#products th {
  padding-top: 12px;
  padding-bottom: 12px;
  text-align: left;
  background-color: #04AA6D;
  color: white;
}
</style>

<body>

<h1>Product List</h1>

<table id="products">
  <tr>
    <th>Product Id</th>
    <th>Product Name</th>
    <th>Product Type</th>
    <th>Prize</th>
    <th>Photo</th>
    <th>Live</th>
  </tr>

  <tbody id="productData">

  </tbody>
  </table>

<script>
    

    let data = ajaxGet('/allDetails');
    console.log("DataFront>>",data)
    let div = ``;
    

    for(let info of data){
    
    div += `
    <tr>
        <td>\${info.id}</td>
        <td>\${info.productname}</td>
        <td>\${info.producttype}</td>
        <td>\${info.prize}</td>
        <td>\${info.image}</td>
        `
        if(info.enable == 'Y'){
         div+=   `<td> <button data-email = "\${info.email}" class="Deactiveuser btn btn-danger">Yes</button></td>`
         
            }else{
                div+=`     <td> <button  class='activeuser btn btn-success' data-email = "\${info.email}" class="activeuser">No</button></td>`

         }            
        div += `</tr>
        `   

               
    

    document.querySelector("#productData").innerHTML = div;
    }


$(".Deactiveuser").click(function() {
    var email = $(this).data('email') // $(this) refers to button that was clicked
    console.log(email);
    let action = ajaxPost("\setDeactive",email);       
    

});

$(".activeuser").click(function() {
    var email = $(this).data('email') // $(this) refers to button that was clicked
    console.log(email);
    let action = ajaxPost("\setActive",email);



});


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

function ajaxPost(URL, DATA){
    let resp = null;
    $.ajax({
    url: URL,
    type: 'POST',
    async: false,
    contentType:false,
    data: DATA,
    success: function (response) {
        location. reload() 
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


