Simple Shop API with JWT Authenticaion:

Clone this repo
* run <b>bundle install</b>
* run <b>rails db:create db:migrate db:seed </b>
* run <b>rails s </b>
* to run rspec test run <b>rspec spec</b>

<!-- TOC depthFrom:1 depthTo:6 withLinks:1 orderedList:0 -->

- Information
	- To Get JWT of customer
	- To Get JWT of admin
	- Display all Regions
	- Show Region
	- Create Region
	- Update Region
	- Delete Region
	- Display Products
	- Show Product
	- Create Product
	- Update Product
	- Create Order
	- Show Order
	- Update Order
	- Delete Order
	
<!-- /TOC -->


## Information
Run this in Postman or any application of API Testing.
Create a JSON file for the parameters for getting the JWT<br>
## To get JWT
Sample customer email and password generated from seeds
```
POST http://localhost:3000/api/v1/authentications
{
    "email": "customer@gmail.com",
    "password": "customershop"
}
```
Sample admin email and password generated from seeds
```
POST http://localhost:3000/api/v1/authentications
{
    "email": "adminshop@gmail.com",
    "password": "adminshop"
}
```
## Region Modules
Display all region if the user role is admin<br>
Add your Authorization Bearer <JWT> in your header<br>
<b>Sample Output</b>
```
GET http://localhost:3000/api/v1/regions
  
{
    "regions": [
        {
            "id": 1,
            "title": "NCR",
            "country": "Philippines",
            "currency": "PHP",
            "tax": "0.12",
            "created_at": "2021-11-25T06:52:38.805Z",
            "updated_at": "2021-11-25T06:52:38.805Z"
        },
        {
            "id": 2,
            "title": "Southern Thailand",
            "country": "Thailand",
            "currency": "THB",
            "tax": "0.1",
            "created_at": "2021-11-25T06:52:38.810Z",
            "updated_at": "2021-11-25T06:52:38.810Z"
        }
    ]
}
  
```
  
Show region if the user role is admin<br>
Add your Authorization Bearer <JWT> in your header<br>
<b>Sample Output</b>
```
GET http://localhost:3000/api/v1/regions/1
  
{
    "region": {
        "id": 1,
        "title": "NCR",
        "country": "Philippines",
        "currency": "PHP",
        "tax": "0.12",
        "created_at": "2021-11-25T06:52:38.805Z",
        "updated_at": "2021-11-25T06:52:38.805Z"
    }
}
  
```
Create region if the user role is admin<br>
Add your Authorization Bearer <JWT> in your header<br>
<b>Sample Input JSON </b>
```
POST http://localhost:3000/api/v1/regions
  
{
    "region": {
        "title": "Central Region",
        "country": "Singapore",
        "currency": "SGD",
        "tax": "0.12"
    }
}
  
``` 
Update region if the user role is admin<br>
Add your Authorization Bearer <JWT> in your header<br>
<b>Sample Input JSON </b>
```
PUT http://localhost:3000/api/v1/regions/3
  
{
    "region": {
        "title": "East Malaysia",
        "country": "Malaysia",
        "currency": "MYR",
        "tax": "0.12"
    }
}
  
```  
Delete region if the user role is admin<br>
Add your Authorization Bearer <JWT> in your header<br>

```
DELETE http://localhost:3000/api/v1/regions/3
  
```  	
## Product Modules	

Display all products per region<br>
Add your Authorization Bearer <JWT> in your header<br>
<b>Sample Input</b>
```
GET http://localhost:3000/api/v1/products
 {
    "region_id": "1"
}
Sample Output	
{
    "products": [
        {
            "id": 1,
            "region_id": 1,
            "title": "PH Tshirt",
            "description": "Pilipinas  T shirt",
            "image_url": "https://static.nike.com/a/images/t_PDP_1280_v1/f_auto,q_auto:eco/e18dd982-179c-4e8b-8057-2b5736226086/philippines-dri-fit-basketball-t-shirt-ttrxhH.png",
            "price": "2500.0",
            "sku": "DT5R5GV1",
            "stock": 20,
            "created_at": "2021-11-25T06:52:38.838Z",
            "updated_at": "2021-11-25T06:52:38.838Z"
        },
        {
            "id": 2,
            "region_id": 1,
            "title": "Jordan  IV",
            "description": "Nike shoes jordan 4",
            "image_url": "https://cdn.shopify.com/s/files/1/0603/3031/1875/products/408452-160_ta_1512x.jpg?v=1636516369",
            "price": "4000.0",
            "sku": "8C5FG8GA",
            "stock": 20,
            "created_at": "2021-11-25T06:52:38.845Z",
            "updated_at": "2021-11-25T06:52:38.845Z"
        },
        {
            "id": 3,
            "region_id": 1,
            "title": "Dior Jordan",
            "description": "Jordan 1 Retro High",
            "image_url": "https://images.stockx.com/images/Air-Jordan-1-Retro-High-Dior-Product.jpg?fit=fill&bg=FFFFFF&w=700&h=500&auto=format,compress&q=90&dpr=2&trim=color&updated_at=1607043976",
            "price": "25000.0",
            "sku": "56KF1AFY",
            "stock": 10,
            "created_at": "2021-11-25T06:52:38.851Z",
            "updated_at": "2021-11-25T06:52:38.851Z"
        }
    ]
}
  
```
Show product<br>
Add your Authorization Bearer <JWT> in your header<br>
<b>Sample Output</b>
```
GET http://localhost:3000/api/v1/products/1
  
{
    "product": {
        "id": 1,
        "region_id": 1,
        "title": "PH Tshirt",
        "description": "Pilipinas  T shirt",
        "image_url": "https://static.nike.com/a/images/t_PDP_1280_v1/f_auto,q_auto:eco/e18dd982-179c-4e8b-8057-2b5736226086/philippines-dri-fit-basketball-t-shirt-ttrxhH.png",
        "price": "2500.0",
        "sku": "DT5R5GV1",
        "stock": 20,
        "created_at": "2021-11-25T06:52:38.838Z",
        "updated_at": "2021-11-25T06:52:38.838Z"
    }
}
  
```	
Create product if the user role is admin<br>
Add your Authorization Bearer <JWT> in your header<br>
<b>Sample Input JSON </b>
```
POST http://localhost:3000/api/v1/products
  
 {
      "product": {
        "region_id": "2",
        "title": "Jordan  IV",
        "image_url": "https://cdn.shopify.com/s/files/1/0603/3031/1875/products/408452-160_ta_1512x.jpg?v=1636516369",
        "description": "Nike shoes jordan 4",
        "sku": "6HP6BI0Q",
        "stock": 10 ,
        "price":  1500
      }
 }
  
``` 
	
Update product if the user role is admin<br>
Add your Authorization Bearer <JWT> in your header<br>
<b>Sample Input JSON </b>
```
PUT http://localhost:3000/api/v1/products/7
  
   {
      "product": {
        "title": "Jordan  V",
        "image_url": "https://cdn.shopify.com/s/files/1/0603/3031/1875/products/408452-160_ta_1512x.jpg?v=1636516369",
        "description": "Nike shoes jordan 5",
        "sku": "IRE9GK63",
        "stock": 5 ,
        "price":  2500
      }
    }
  
``` 	
## Order Modules
		
Create order <br>
Add your Authorization Bearer <JWT> in your header<br>
<b>Sample Input JSON </b>
```
POST http://localhost:3000/api/v1/orders
  
{
    "order": {
        "shipping_address": "Apt. 958 608 Wolff Glens, Crooksport, WV 84098",
        "order_dtls": [
            {
                "product_id": "1",
                "total_order": "5"
            },
            {
                "product_id": "2",
                "total_order": "5"
            }
        ]
    }
}
  
```
Show Order<br>
Add your Authorization Bearer <JWT> in your header<br>
<b>Sample Output</b>
```
GET http://localhost:3000/api/v1/orders/3
  
{
    "order": {
        "id": 3,
        "user_id": 2,
        "shipping_address": "Apt. 958 608 Wolff Glens, Crooksport, WV 84098",
        "order_total": 2,
        "total_price": 14560,
        "paid_at": null,
        "paid": false,
        "created_at": "2021-11-26T03:25:04.724Z",
        "updated_at": "2021-11-26T03:25:04.820Z"
    },
    "order_details": [
        {
            "id": 3,
            "order_id": 3,
            "product_id": 1,
            "total_price": "5600.0",
            "total_order": 2,
            "created_at": "2021-11-26T03:25:04.765Z",
            "updated_at": "2021-11-26T03:25:04.765Z"
        },
        {
            "id": 4,
            "order_id": 3,
            "product_id": 2,
            "total_price": "8960.0",
            "total_order": 2,
            "created_at": "2021-11-26T03:25:04.799Z",
            "updated_at": "2021-11-26T03:25:04.799Z"
        }
    ]
}
  
```
Update order <br>
Add your Authorization Bearer <JWT> in your header<br>
<b>Sample Input JSON </b>
```
PUT http://localhost:3000/api/v1/orders/1
  
{
    "order": {
        "shipping_address": "24923 Jackqueline Circles, Sammyville, ID 65731",
        "order_dtls": [
            {
                "product_id": "1",
                "total_order": "2"
            },
            {
                "product_id": "2",
                "total_order": "2"
            },
            {
                "product_id": "3",
                "total_order": "2"
            }
        ]
    }
}
  
``` 
Delete order <br>
Add your Authorization Bearer <JWT> in your header<br>

```
DELETE http://localhost:3000/api/v1/orders/1
	
```  	