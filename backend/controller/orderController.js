const Order = require('../models/order');
const OrderHasProduct = require('../models/order_has_product');


module.exports = {

    async create(req, res, next){
        try {
            let order = req.body;
            order.status = 'PAGADO';
            console.log(order);
            const data = await Order.create(order);
            for (const product of order.productos) {
                await OrderHasProduct.create(data.id, product.id, product.quantity); 
                
            }
            return res.status(201).json({
                success: true,
                message: 'La orden se creo correctamente',
                data: data
            });
        }catch (error){
            console.log(`Error ${error}`);
            return res.status(501).json({
                success: false,
                message: 'Hubo un error creando la orden',
                error: error
            });
        }
    },

    async finbystatus(req, res, next){
        try {
            const status = req.params.status;
            console.log(status);
            const data = await Order.orden(status);
            console.log(`${JSON.stringify(data)}`)
            return res.status(201).json(data);
        }catch (error){
            console.log(`Error ${error}`);
            return res.status(501).json({
                success: false,
                message: 'Hubo un error obtener la orden en estados',
                error: error
            });
        }
    }
}