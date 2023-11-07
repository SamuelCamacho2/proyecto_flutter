const UserControlle = require('../controller/users_controller');

module.exports = (app) => {
    app.get('/api/users/getAll', UserControlle.getAll);
};