const User = require('../models/user_model');
const JWT = require('jsonwebtoken');
const key = require('../config/keys');
const Rol = require('../models/rol_model')
const storage = require('../utils/cloud_storage');


module.exports = {
    async getAll(req, res, next){
        try {
            const data = await User.getAll();
            return res.status(201).json(data);
        } catch (error) {
            console.log(`Error: ${error}`);
            return res.status(501).json({
                succes: false,
                message: 'Error al obtener los usuarios'
            });
        }
    },

    async findId(req, res, next){
        try {
            const id = req.params.id;
            const data = await User.findUserId(id);
            console.log(`Usuario: ${data}`)
            return res.status(201).json(data);
        } catch (error) {
            console.log(`Error: ${error}`);
            return res.status(501).json({
                succes: false,
                message: 'Error al obtener el usuario por ID'
            });
        }
    },

    async register(req, res, next){
        try {
            const user = req.body;
            console.log(user)
            const data = await User.create(user);
            await Rol.create(data.id, 1);
            
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

    async registerWithImage(req, res, next){
        try {
            const user = JSON.parse(req.body.user);
            console.log(`Datos enviado del usuario ${user}`);
            const files = req.files;
            if(files.length > 0){
                const pathImage = `image_${Date.now()}`; //NOMBRE DEL ARCHIVO 
                const url = await storage(files[0], pathImage);

                if(url != undefined && url != null){
                    user.image = url;
                }
            }
            const data = await User.create(user);
            await Rol.create(data.id, 1);
            
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

    async update(req, res, next){
        try {
            const user = JSON.parse(req.body.user);
            console.log(`Datos enviado del usuario ${JSON.stringify(user)}`);
            // console.log(user)
            const files = req.files;
            if(files.length > 0){
                const pathImage = `image_${Date.now()}`; //NOMBRE DEL ARCHIVO 
                const url = await storage(files[0], pathImage);

                if(url != undefined && url != null){
                    user.image = url;
                }
            }
            await User.update(user);
            
            res.status(201).json({
                success: true,
                message: 'Los datos se actualizaron correctamente'
            });
        } catch (error) {
            console.log(`Error: ${error}`);
            return res.status(501).json({
                succes: false,
                message: 'Error al actualizar el usuario',
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
                    session_token: `JWT ${token}`,
                    roles: myuser.roles
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