const bd = require('../config/config');
const crypto = require('crypto');

const User = {};

User.getAll = () => {
    const sql = 'SELECT * FROM users';
    return bd.manyOrNone(sql);
};

User.getById = (id, callback) =>{
    const sql =`
    SELECT id, email ,name, lastname, image ,phone, password, session_token FROM users WHERE id = $1`;
    return bd.oneOrNone(sql, id).then( user =>{ callback(null, user); });
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

User.isPassworMatch = (canPassword, hash) =>{
    const mypasswordhashed = crypto.createHash('md5').update(canPassword).digest('hex');
    if (hash === mypasswordhashed) {
        return true;
    }else{
        return false;
    }
}
module.exports = User;