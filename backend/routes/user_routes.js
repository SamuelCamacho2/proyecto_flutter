const UserControlle = require('../controller/users_controller');

// module.exports = (app) => {
module.exports = (app, upload) => {
    app.get('/api/users/getAll', UserControlle.getAll);
    app.post('/api/users/register', upload.array('image', 1), UserControlle.registerWithImage);
    // app.post('/api/users/register', UserControlle.register);
    app.post('/api/users/login', UserControlle.login);
};