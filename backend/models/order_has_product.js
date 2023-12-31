const db = require('../config/config')

const OrderHasProduct = {}

OrderHasProduct.create = (id_order, id_product, quantity) => {
    const sql = `INSERT INTO order_has_product(id_order, id_product, quantity, created_at, updated_at)
                    VALUES($1, $2, $3, $4, $5 )`;
    return db.none(sql, [
        id_order,
        id_product,
        quantity,
        new Date(),
        new Date()
    ]);
}

module.exports = OrderHasProduct;