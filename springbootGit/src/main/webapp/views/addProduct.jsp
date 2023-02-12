<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<style>
    body {
        margin: 0;
        padding: 0;
        background-color: aqua;
        height: 100vh;
    }

    .center {
        position: absolute;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%);
        width: 400px;
        background: white;
        border-radius: 10px;
    }

    .center h1 {
        text-align: center;
        padding: 0 0 20px 0;
        border-bottom: 1px solid silver;
    }

    .center .submit {
        display: flex;
        justify-content: center;
        align-items: center;

    }

    .textDiv {
        padding: 0px 40px 10px;
    }

 
</style>

<body>
    <div class="center">
        <form enctype='multipart/form-data' method="POST" action="/add-product" id="product-form">

            <h1>Add New Product</h1>
            <div class="textDiv">
            <div class="pName">
                <label>Product Name :-</label>
                <input type="text" name="productName" id="productName">
            </div><br>
            <div class="pType">
                <label>Product Type :-</label>
                <select type="text" id="productName" name="productType">
                    <option value="">-Select-</option>
                    <option value="Clothing">Clothing</option>
                    <option value="Mobiles">Mobiles</option>
                    <option value="Appliances">TV & Appliances</option>
                    <option value="Footwears">Footwears</option>
                    <option value="Electronics">Electronics & Accessories</option>
                    <option value="Grocery">Grocery</option>
                </select>
            </div><br>
            <div class="pValue">
                <label>Product Prize :-</label>
                <input type="text" id="productPrize" name="prize">
            </div><br>
            <div class="pImage">
                <label>Image :-</label>
                <input type="file" id="productImage" name="file">
            </div><br>
            <div class="submit" >
                <input type="submit" class="submit" id="submit" value="Submit">
            </div>
        </div>
    </form>
    </div>

    <script>
  
    </script>
</body>

</html>