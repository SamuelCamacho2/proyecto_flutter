//psql -d postgres postgres123 proyecto123

const express = require('express');
const app = express();
const http = require('http');
const server = http.createServer(app)
const logger = require('morgan');
const cors = require('cors');
const multer = require('multer');
const admin = require('firebase-admin');
const serviceAccount = require('./serviceAccountKey.json');
const passport =  require('passport')
const session = require('express-session');
const key = require('./config/keys');


/**
 * INICIALIZAR FIREBASE ADMIN
 */
admin.initializeApp({
    credential: admin.credential.cert(serviceAccount)
})

const upload = multer({
    storage: multer.memoryStorage()
})

//rutas
const users = require('./routes/user_routes');
const category = require('./routes/category_routes');
const product = require('./routes/products_routes');
const address = require('./routes/address_routes');
const orders = require('./routes/order_routes');



const port = process.env.PORT || 3000;

app.use(logger('dev'));
app.use(express.json());
app.use(express.urlencoded({extended: true}));
app.use(cors());

app.use(session({
    secret: key.secretOrKey,
    resave: false,
    saveUninitialized: true
}))
app.use(passport.initialize());
require('./config/passport')(passport);

app.disable('x-powered-by');

app.set('port', port);

// llamada de rutas
users(app, upload);
category(app);
address(app);
product(app, upload)
orders(app)


// users(app);

// server.listen(3000,'192.168.100.126'|| 'localhost', function(){
//     console.log('Aplicaion de Nodejs iniciada...')
// });


server.listen(3000,'192.168.100.17'|| 'localhost', function(){
    console.log('Aplicaion de Nodejs iniciada...')
});


app.use((err, req, res, next) => {
    console.log(err);
    res.status(err.status || 500).send(err.stack);
});

module.exports = {
    app: app,
    server: server
};