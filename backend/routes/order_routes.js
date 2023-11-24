const orderController =  require('../controller/orderController')
const passport = require('passport');

module.exports = (app) =>{
    // app.get('/api/address/findByUser/:id_user',  addressController.findByUser)
    app.post('/api/orden/create', orderController.create)

    app.get('/api/orden/find/:status', orderController.finbystatus)

}