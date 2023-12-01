const promise = require('bluebird');
const options = {
    promiseLib: promise,
    query: (e) => {
        console.log(e.query);
    }
};

const pgp = require('pg-promise')(options);
const types = pgp.pg.types;
types.setTypeParser(1114, function(stringValue){
    return stringValue;
});

const databaseConfig ={
    'host': '127.0.0.1',
    'port': 5432,
    'database': 'delibery_db',
    'user': 'postgres',
    'password': 'postgres123',
}

// const databaseConfig ={
//     'host': '127.0.0.1',
//     'port': 5432,
//     'database': 'delivery_db',
//     'user': 'postgres',
//     'password': '18abril2001',
// }

const db = pgp(databaseConfig);

module.exports = db;