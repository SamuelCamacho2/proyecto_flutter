const categoriesControlles =  require('../controller/category.controller')
const passport = require('passport');

module.exports = (app) =>{
    app.get('/api/categories/getAll', passport.authenticate('jwt', {session: false}), categoriesControlles.getAll)
    app.post('/api/categories/create', passport.authenticate('jwt', {session: false}), categoriesControlles.create)
}