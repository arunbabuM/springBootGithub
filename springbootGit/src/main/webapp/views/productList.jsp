<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
   
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

<div class="row">
  <div class="col-md-4 " id="type_select">
      <h5>Select Product Type</h5>
          <hr />
      <select class="type_select mb-3" id="product_type">
         
      </select>
  </div>
</div>

<table id="products">
  <tr>
    <th>Product Id</th>
    <th>Product Name</th>
    <th>Product Type</th>
    <th>Prize</th>
    <th>Photo</th>
    <th>Action</th>
  </tr>

  <tbody id="productData">

  </tbody>
  </table>


  <!-- Button trigger modal -->
<!-- <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#exampleModal">
  Edit
</button> -->

<!-- Modal -->
<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Modal title</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <label>Product Name :-</label>
        <input type="text" name="productType" id="productType"><br>
        <label>Product Type :-</label>
        <input type="text" name="productName" id="productName"><br>
        <label>Product Prize :-</label>
        <input type="text" name="productPrize" id="productPrize">
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary">Save changes</button>
      </div>
    </div>
  </div>
</div>

<script>
  $('#myModal').on('shown.bs.modal', function () {
  $('#myInput').trigger('focus')
})
    

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
        if(info.active == true){
         div+=   `<td><button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#exampleModal">
  Edit
</button> <button data-id = "\${info.id}" class="Deactiveuser btn btn-danger">D</button></td>
         `
         
            }else{
                div+=`<td><button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#exampleModal">
  Edit
</button> <button  class='activeuser btn btn-success' data-id = "\${info.id}" class="activeuser">A</button></td>`

         }            
        div += `</tr>
        `   

               
    

    document.querySelector("#productData").innerHTML = div;
    }


let type = ajaxGet("/getAllType");
  console.log("Type>>",type);
  let divToAppend =`<option selected disabled>--Select Product Type--</option>`;
  for(let typeproduct of type){
    
    divToAppend += `
    <option value='\${typeproduct.producttype}'>\${typeproduct.producttype}</option>
    `
    document.querySelector("#product_type").innerHTML = divToAppend;
  }

  $('#product_type').on('change',function(e){
    const filter =$(this).val();
    console.log("filter",filter);


    let data = ajaxGet('/allDetails?filter='+filter);
    console.log("DataFrontFilter>>",data)
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
        if(info.active == true){
         div+=   `<td> <button data-id = "\${info.id}" class="Deactiveuser btn btn-danger">D</button></td>`
         
            }else{
                div+=`<td> <button  class='activeuser btn btn-success' data-id = "\${info.id}" class="activeuser">A</button></td>`

         }             
        div += `</tr>
        `   

               
    

    document.querySelector("#productData").innerHTML = div;

    }
    $(".Deactiveuser").click(function() {
    var id = $(this).data('id') // $(this) refers to button that was clicked
    console.log(id);
    let action = ajaxPost("\setDeactive?id="+id);
    console.log(id);   
  console.log("okk");
}); 

$(".activeuser").click(function() {
    var id = $(this).data('id') // $(this) refers to button that was clicked
    console.log(id);
    let action = ajaxPost("\setActive?id="+id);
    console.log(id);
    console.log("okk2");
});
  })

//   $(".Deactiveuser").click(function() {
//     var id = $(this).data('id') // $(this) refers to button that was clicked
//     console.log(id);
//     let action = ajaxPost("\setDeactive?id="+id);
//     console.log(id);   
//   console.log("okk");
// }); 

// $(".activeuser").click(function() {
//     var id = $(this).data('id') // $(this) refers to button that was clicked
//     console.log(id);
//     let action = ajaxPost("\setActive?id="+id);
//     console.log(id);
//     console.log("okk2");
// });

$(".Deactiveuser").click(function() { 
        var id = $(this).data('id') // $(this) refers to button that was clicked
        console.log(id);
        let action = ajaxPost("\setDeactive",id);       
        

    });
    

    $(".activeuser").click(function() {
        var id = $(this).data('id') // $(this) refers to button that was clicked
        console.log(id);
        let action = ajaxPost("\setActive",id);
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


