const bd = require('../config/config');

const User = {};

User.getAll = () => {
    const sql = 'SELECT * FROM users';
    return bd.manyOrNone(sql);
};

module.exports = User;