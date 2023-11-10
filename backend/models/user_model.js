const bd = require('../config/config');
const crypto = require('crypto');

const User = {};

User.getAll = () => {
    const sql = 'SELECT * FROM users';
    return bd.manyOrNone(sql);
};

User.create = (user) => {
    const mypasswordhashed = crypto.createHash('md5').update(user.password).digest('hex');
    user.password = mypasswordhashed;
    
    const sql = `insert into users( email, name, lastname, phone, password, created_at, updated_at) 
        values($1,$2,$3,$4,$5,$6,$7) returning id`;
    return bd.oneOrNone(sql, [
        user.email,
        user.name,
        user.lastname,
        user.phone,
        user.password,
        new Date(),
        new Date()
    ]);
};

module.exports = User;