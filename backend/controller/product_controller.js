const Product = require('../models/product_model')
const storage = require('../utils/cloud_storage')
const asyncForEach = require('../utils/async_foreach')

module.exports ={
    
    async findByCategory(req, res, next){       
        try {
            const id_categoria = req.params.id_categoria;
            const data = await Product.findById(id_categoria);
            return res.status(201).json(data);
        } catch (error) {
            console.log(`ERROR: ${error}`);
            return res.status(501).json({
                message: `Error al listar los productos por categoria`,
                success: false,
                error: error
            })
        }
    },

    async findByCategoryAndName(req, res, next){       
        try {
            const id_categoria = req.params.id_categoria;
            const product_name = req.params.product_name;
            const data = await Product.findByNameAndCateg(id_categoria, product_name);
            return res.status(201).json(data);
        } catch (error) {
            console.log(`ERROR: ${error}`);
            return res.status(501).json({
                message: `Error al listar los productos por categoria`,
                success: false,
                error: error
            })
        }
    },

    async create(req, res, next){
        let product = JSON.parse(req.body.product);
        console.log(JSON.stringify(product));
        const files = req.files;
        let inserts = 0;

        if(files.length === 0){
            return res.status(501).json({
                message : 'Error al registrar el producto sin imagen',
                success: false
            })
        }else{ 
            try {
                const data = await Product.create(product);
                product.id = data.id;
                const start = async () => {
                    await asyncForEach(files, async(file) => {
                        const pathImage = `image_${Date.now()}`;
                        const url = await storage(file, pathImage)

                        if(url !== undefined && url !== null){
                            if(inserts == 0){
                                product.image1 = url
                            }else if(inserts ==1){
                                product.image2 = url
                            }else if(inserts ==2){
                                product.image3 = url
                            }
                        }
                        await Product.update(product)
                        inserts = inserts + 1 ;
                        if(inserts == files.length){
                            return res.status(201).json({
                                success: true,
                                message: 'El producto se ha registrado correctamente'
                            })
                        }
                    })
                }
                start();
            } 
            catch (error) {
                console.log(`Error: ${error}`)
                return res.status(501).json({
                    message: `Error al registrar el producto ${error}`,
                    success: false,
                    error: error
                })
            }
        }
    }
}