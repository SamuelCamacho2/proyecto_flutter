const UserControlle = require('../controller/users_controller');

module.exports = (app) => {
    app.get('/api/users/getAll', UserControlle.getAll);
    app.post('/api/users/register', UserControlle.register);
    app.post('/api/users/login', UserControlle.login);
};