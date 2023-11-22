const db = require('../config/config')

const Product = {}

Product.create = (product) => {
    const sql = `
        insert into products(name, description, price, image1, image2, image3, id_categoria, created_at, updated_at )
            values($1, $2, $3, $4, $5, $6, $7, $8, $9) returning id`;
        return db.oneOrNone(sql, [product.name, product.description, product.price, 
            product.image1, product.image2, product.image3, product.id_categoria, new Date(), new Date()])
}

Product.update = (product) => {
    const sql = `update products 
    set name = $2 , description= $3, price= $4, image1= $5, image2= $6, image3= $7, id_categoria= $8, updated_at= $9
    where id = $1`;
    return db.none(sql, [product.id, product.name, product.description, product.price, 
        product.image1, product.image2, product.image3, product.id_categoria, new Date(),])
}

Product.findById = (id) =>{
    const sql = `select p.id, p.name, p.description, p.price, p.image1, p.image2, p.image3, p.id_categoria
        from products as p inner join categories as c on c.id = p.id_categoria
        where c.id = $1`;
        return db.manyOrNone(sql, id)
}

module.exports = Product; 