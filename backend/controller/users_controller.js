const User = require('../models/user_model');

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
    }
};