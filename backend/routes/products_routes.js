const ProductController = require('../controller/product_controller')
const passport = require('passport')

module.exports = (app, upload) => {
    app.get('/api/products/findcategoy/:id_categoria', passport.authenticate('jwt', {session: false}), ProductController.findByCategory);
    app.post('/api/products/create', passport.authenticate('jwt', {session: false}), upload.array('image', 3), ProductController.create);
}