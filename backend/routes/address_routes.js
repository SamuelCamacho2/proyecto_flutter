const addressController =  require('../controller/addressController')
const passport = require('passport');

module.exports = (app) =>{
    app.get('/api/address/findByUser/:id_user',  addressController.findByUser)
    app.post('/api/address/create', addressController.create)
}