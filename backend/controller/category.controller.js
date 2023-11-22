const Category = require('../models/categories')

module.exports = {

    async getAll(req, res, next){
        try {
            const data = await Category.getAll()
            res.status(201).json(data)
        } catch (error) {
            console.log(`Error ${error}`);
            res.status(501).json({
                message: 'error al listar las cartegorias',
                success: false,
                error: error
            })
        }
    },

    async create(req, res, next){
        try {
            const category = req.body;
            console.log(`categoria: ${JSON.stringify(category)}`);
            const data = await Category.create(category);
            return res.status(201).json({
                success: true,
                message: 'Se agrego la categoria',
                data: data.id
            });
        } catch (error) {
            console.log(`Error: ${error}`);
            return res.status(501).json({
                success: false,
                message: 'Error al guardar los datos',
                error: error
            });
        }
    }
}