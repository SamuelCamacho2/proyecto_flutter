const UserControlle = require('../controller/users_controller');
const passport =  require('passport')

// module.exports = (app) => {
module.exports = (app, upload) => {
    app.get('/api/users/getAll', UserControlle.getAll);
    app.get('/api/users/findId/:id', passport.authenticate('jwt', {session:false}) ,UserControlle.findId);//

    //GUARDAR DATOS
    app.post('/api/users/register', upload.array('image', 1), UserControlle.registerWithImage);
    // app.post('/api/users/register', UserControlle.register);
    app.post('/api/users/login', UserControlle.login);
    app.post('/api/users/logout', UserControlle.logout);


    //ACTUALIZAR DATOS
    app.put('/api/users/update', passport.authenticate('jwt', {session:false}), upload.array('image', 1), UserControlle.update)
};