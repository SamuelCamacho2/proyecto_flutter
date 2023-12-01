import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:project/models/product_model.dart';
import 'package:project/pages/client/detail/cliente_product_detail_controller.dart';

class CienteProducDetail extends StatefulWidget {
  Product product;
  CienteProducDetail({super.key, required this.product});

  @override
  State<CienteProducDetail> createState() => _CienteProducDetailState();
}

class _CienteProducDetailState extends State<CienteProducDetail> {

  CienteProducDetailController _con = CienteProducDetailController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context, refresh, widget.product);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height*(0.87),
      child:Column(
        children: [
          _imageSlidershow(),
          _textname(),
          _textdesc(),
          const Spacer(),
          _addAndRemove(),
          _boton()
        ],
      )
    );
  }

  Widget _boton(){
    return Container(
      margin: const EdgeInsets.only(left: 30, right: 30, top: 30, bottom: 30),
      child: ElevatedButton(
        onPressed: _con.addToBag, 
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.primary,
          padding: const EdgeInsets.symmetric(vertical: 5)
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                height: 50,
                alignment: Alignment.center,
                child: const Text(
                  'Agregar al carrito',
                  style:  TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                margin: const EdgeInsets.only(left: 50, top: 9),
                height: 30,
                child: Image.asset('assets/img/carrito.png'),
              ),
            )
          ],
        )
      ),
    );
  }

  Widget _textdesc(){
    return Container(
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.only(right: 30, left:30, top:15),
      child: Text(
        _con.product?.description ?? '',
        style: const TextStyle(
          fontSize: 15,
          color: Colors.grey,
          fontWeight: FontWeight.bold
        ),
      ),
    );
  }

  Widget _addAndRemove(){
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 17),
      child: Row(
        children: [
          IconButton(
            onPressed: _con.addItem, 
            icon: const Icon(
              Icons.add_circle_outline,
              color: Colors.grey,
              size: 30
            )
          ),
          Text (
            '${_con.counter}',
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: Colors.grey
            ),
          ),
          IconButton(
            onPressed: _con.removeItem, 
            icon: const Icon(
              Icons.remove_circle_outline,
              color: Colors.grey,
              size: 30
            )
          ),
          const Spacer(),
          Container(
            margin: const EdgeInsets.only(right: 0),
            child: Text(
              '\$ ${_con.productPrice ?? ''}',
              style:  const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _textname(){
    return Container(
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.only(right: 30, left:30, top:30),
      child: Text(
        _con.product?.name ?? '',
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold
        ),
      ),
    );
  }

  Widget _imageSlidershow(){
    return Stack(
      children: [
        ImageSlideshow(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.4,
              initialPage: 0,
              indicatorColor: Colors.blue,
              indicatorBackgroundColor: Colors.grey,
              onPageChanged: (value) {
                print('Page changed: $value');
              },
              autoPlayInterval: 3000,
              isLoop: true,
              children: [
                FadeInImage(
                          placeholder: const  AssetImage('assets/img/nota.png'), 
                          image: _con.product?.image1 != null
                            ? NetworkImage(_con.product!.image1!) as ImageProvider<Object>
                            : const AssetImage('assets/img/nota.png'),
                          fit: BoxFit.fill,
                          fadeInDuration: const Duration(milliseconds: 50),
                        ),
                FadeInImage(
                          placeholder: const  AssetImage('assets/img/nota.png'), 
                          image: _con.product?.image2 != null
                            ? NetworkImage(_con.product!.image2!) as ImageProvider<Object>
                            : const AssetImage('assets/img/nota.png'),
                          fit: BoxFit.fill,
                          fadeInDuration: const Duration(milliseconds: 50),
                        ),
                FadeInImage(
                          placeholder: const  AssetImage('assets/img/nota.png'), 
                          image: _con.product?.image3 != null
                            ? NetworkImage(_con.product!.image3!) as ImageProvider<Object>
                            : const AssetImage('assets/img/nota.png'),
                          fit: BoxFit.fill,
                          fadeInDuration: const Duration(milliseconds: 50),
                        ),
              ],
            ),
            Positioned(
              left: 10,
              top: 10,
              child: IconButton(
                onPressed: _con.close,
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color:Colors.black,
                ),
              ),
            )
      ],
    );
  }

  void refresh(){
    setState(() {
      
    });
  }
}