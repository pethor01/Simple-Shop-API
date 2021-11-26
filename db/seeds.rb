# Users
User.create([ {email: 'customer@gmail.com', password: 'customershop', first_name: Faker::Name.unique.first_name , last_name: Faker::Name.unique.last_name, role: 0 },
              {email: 'adminshop@gmail.com', password: 'adminshop', first_name: Faker::Name.unique.first_name , last_name: Faker::Name.unique.last_name, role: 1 }
])

# Regions
ph = Region.create(title:'NCR', country: 'Philippines',currency:'PHP', tax:0.12 )
thailand = Region.create(title:'Southern Thailand', country: 'Thailand', currency:'THB', tax:0.1 )

# Products
Product.create([ { region_id: ph.id, title: 'PH Tshirt', description: 'Pilipinas  T shirt',
                  image_url: 'https://static.nike.com/a/images/t_PDP_1280_v1/f_auto,q_auto:eco/e18dd982-179c-4e8b-8057-2b5736226086/philippines-dri-fit-basketball-t-shirt-ttrxhH.png',
                  sku: Faker::Alphanumeric.alphanumeric(number: 8, min_alpha: 5, min_numeric: 3).upcase,
                  stock: 20 ,price: 2500
                },
                { region_id: ph.id,title: 'Jordan  IV', description: 'Nike shoes jordan 4',
                  image_url: 'https://cdn.shopify.com/s/files/1/0603/3031/1875/products/408452-160_ta_1512x.jpg?v=1636516369',
                  sku: Faker::Alphanumeric.alphanumeric(number: 8, min_alpha: 5, min_numeric: 3).upcase,
                  stock: 20 ,price: 4000
              },
              {   region_id: ph.id,title: 'Dior Jordan', description: 'Jordan 1 Retro High',
                  image_url: 'https://images.stockx.com/images/Air-Jordan-1-Retro-High-Dior-Product.jpg?fit=fill&bg=FFFFFF&w=700&h=500&auto=format,compress&q=90&dpr=2&trim=color&updated_at=1607043976',
                  sku: Faker::Alphanumeric.alphanumeric(number: 8, min_alpha: 5, min_numeric: 3).upcase,
                  stock: 10 ,price: 25000
              },

              { region_id: thailand.id, title: 'Thai Tshirt', description: 'Thailand  T shirt',
                image_url: 'https://m.media-amazon.com/images/I/A13usaonutL._CLa%7C2140%2C2000%7C917t3C8w3lL.png%7C0%2C0%2C2140%2C2000%2B0.0%2C0.0%2C2140.0%2C2000.0_AC_UX342_.png',
                sku: Faker::Alphanumeric.alphanumeric(number: 8, min_alpha: 5, min_numeric: 3).upcase,
                stock: 20 ,price: 2500
              },
              { region_id: thailand.id,title: 'Jordan  VI', description: 'Nike air jordan 6',
                image_url: 'https://static.highsnobiety.com/thumbor/vt4AZxTxYvpc8vjuDfw6UdPFuNw=/1600x1067/static.highsnobiety.com/wp-content/uploads/2019/07/29105623/travis-scott-nike-air-jordan-6-release-date-price-product-02.jpg',
                sku: Faker::Alphanumeric.alphanumeric(number: 8, min_alpha: 5, min_numeric: 3).upcase,
                stock: 20 ,price: 3500
            },
            {   region_id: thailand.id,title: 'Dior Jordan', description: 'Jordan 1 Retro High',
                image_url: 'https://images.stockx.com/images/Air-Jordan-1-Retro-High-Dior-Product.jpg?fit=fill&bg=FFFFFF&w=700&h=500&auto=format,compress&q=90&dpr=2&trim=color&updated_at=1607043976',
                sku: Faker::Alphanumeric.alphanumeric(number: 8, min_alpha: 5, min_numeric: 3).upcase,
                stock: 10 ,price: 25000
            }
])
