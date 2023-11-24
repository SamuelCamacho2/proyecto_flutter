const db = require('../config/config')

const Order = {}

Order.create = (Order) => {
    const sql = `INSERT INTO orders(id_client, id_addres, status, timestamp, created_at, updated_at)
                    VALUES($1, $2, $3, $4, $5, $6 ) RETURNING id`;
    return db.oneOrNone(sql, [
        Order.id_client,
        Order.id_addres,
        Order.status,
        Date.now(),
        new Date(),
        new Date()
    ]);
}

module.exports = Order;