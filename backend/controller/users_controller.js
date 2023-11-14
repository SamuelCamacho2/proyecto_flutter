const User = require('../models/user_model');
const JWT = require('jsonwebtoken');
const key = require('../config/keys');

module.exports = {
    async getAll(req, res, next){
        try {
            const data = await User.getAll();
            console.log(`usuarios: ${data}`);
            return res.status(201).json(data);
        } catch (error) {
            console.log(`Error: ${error}`);
            return res.status(501).json({
                succes: false,
                message: 'Error al obtener los usuarios'
            });
        }
    },

    async register(req, res, next){
        try {
            const user = req.body;
            const data = await User.create(user);
            res.status(201).json({
                success: true,
                message: 'Usuario creado exitosamente',
                data: data.id
            });
        } catch (error) {
            console.log(`Error: ${error}`);
            return res.status(501).json({
                succes: false,
                message: 'Error al registrar el usuarios',
                error: error
            });
        }
    },

    async login(req, res, next){
        try {
            const email = req.body.email;
            const password = req.body.password;
            const myuser = await User.findEmail(email);

            if(!myuser){
                return res.status(401).json({
                    success: false,
                    message: 'Email no encontrado'
                });
            }

            if(User.isPassworMatch(password, myuser.password)){
                const token = JWT.sign({id: myuser.id, email: myuser.email}, key.secretOrKey, {expiresIn: '1h'});

                const data = {
                    id: myuser.id,
                    email: myuser.email,
                    name: myuser.name,
                    lastname: myuser.lastname,
                    image: myuser.image,
                    phone: myuser.phone,
                    password: myuser.password,
                    session_token: `JWT ${token}`
                }
                return res.status(201).json({
                    success: true,
                    data: data,
                    message: 'Usuario logueado exitosamente'
                });
            }
            else{
                return res.status(401).json({
                    success: false,
                    message: 'Contraseña incorrecta'
                });
            }
        } catch (error) {
            console.log(`Error: ${error}`);
            return res.status(501).json({
                succes: false,
                message: 'Error al ingresar',
                error: error
            });
        }
    }
};