const bd = require('../config/config');
const crypto = require('crypto');

const User = {};

User.getAll = () => {
    const sql = 'SELECT * FROM users';
    return bd.manyOrNone(sql);
};

User.getById = (id, callback) => {
    const sql = `
    SELECT id, email ,name, lastname, image ,phone, password, session_token FROM users WHERE id = $1`;
    return bd.oneOrNone(sql, id).then(user => { callback(null, user); });
}

User.findEmail = (email) => {
    const sql = `
    SELECT 
        U.id, U.email , U.name, U.lastname, U.image , U.phone, U.password, U.session_token,
        json_agg(json_build_object( 'id', R.id, 'name', R.name, 'image', R.image, 'route', R.route)) as roles
            FROM users U inner join user_has_rol UHR on U.id=UHR.id_user
                inner join roles R on R.id = UHR.id_rol
                WHERE U.email = $1
                    GROUP BY U.id`;
    return bd.oneOrNone(sql, email);
}

User.findUserId = (id) => {
    const sql = `
    SELECT 
        U.id, U.email , U.name, U.lastname, U.image , U.phone, U.password, U.session_token,
        json_agg(json_build_object( 'id', R.id, 'name', R.name, 'image', R.image, 'route', R.route)) as roles
            FROM users U inner join user_has_rol UHR on U.id=UHR.id_user
                inner join roles R on R.id = UHR.id_rol
                WHERE U.id = $1
                    GROUP BY U.id`;
    return bd.oneOrNone(sql, id);
}

User.create = (user) => {
    const mypasswordhashed = crypto.createHash('md5').update(user.password).digest('hex');
    user.password = mypasswordhashed;

    const sql = `insert into users( email, name, lastname, phone, image, password, created_at, updated_at) 
        values($1,$2,$3,$4,$5,$6,$7,$8) returning id`;
    return bd.oneOrNone(sql, [
        user.email,
        user.name,
        user.lastname,
        user.phone,
        user.image,
        user.password,
        new Date(),
        new Date()
    ]);
};

User.update = (user) => {
    const sql = `UPDATE users
                SET name = $2, lastname = $3, phone = $4, image = $5, updated_at = $6 
                WHERE id= $1`;
    return bd.none(sql, [
        user.id,
        user.name,
        user.lastname,
        user.phone,
        user.image,
        new Date()
    ]);
}

User.updateToken = (id, token) => {
    const sql = `UPDATE users
                SET session_token = $2
                WHERE id= $1`;
    return bd.none(sql, [
        id,
        token
    ]);
}

User.isPassworMatch = (canPassword, hash) => {
    const mypasswordhashed = crypto.createHash('md5').update(canPassword).digest('hex');
    if (hash === mypasswordhashed) {
        return true;
    } else {
        return false;
    }
}
module.exports = User;