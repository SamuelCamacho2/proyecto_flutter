const db = require('../config/config')

const Order = {}

Order.orden = (status) => {
    const sql = `SELECT 
    o.id, 
    o.id_client, 
    o.id_addres, 
    o.id_delivery, 
    o.status, 
    o.timestamp, 
        JSON_AGG(
            JSON_BUILD_OBJECT('id', pr.id, 'name', pr.name, 'description', pr.description, 'price', pr.price,  'image1', pr.image1, 'quantity', ohp.quantity) 
        )AS productos,
        JSON_BUILD_OBJECT('id', u.id, 'name', u.name, 'lastname', u.lastname, 'image', u.image) AS cliente,
        JSON_BUILD_OBJECT('id', a.id, 'address', a.address, 'neighborhood', a.neighborhood, 'lat', a.lat, 'lng', a.lng) AS address
    FROM 
        orders AS o INNER JOIN users AS u ON o.id_client = u.id
        INNER JOIN address AS a ON a.id = o.id_addres 
        INNER JOIN order_has_product AS ohp ON ohp.id_order = o.id
        INNER JOIN products AS pr ON ohp.id_product = pr.id
    WHERE 
        o.status = $1
    group by u.id, a.id, o.id`;
    
    return db.manyOrNone(sql, [status])

}

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