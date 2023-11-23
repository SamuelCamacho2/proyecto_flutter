const addressController =  require('../controller/addressController')
const passport = require('passport');

module.exports = (app) =>{
    // app.get('/api/address/getAll', passport.authenticate('jwt', {session: false}), categoriesControlles.getAll)
    app.post('/api/address/create', addressController.create)
}