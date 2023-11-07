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
    }
};