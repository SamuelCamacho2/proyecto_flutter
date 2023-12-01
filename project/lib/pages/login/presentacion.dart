import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Presentacion extends StatefulWidget {
  const Presentacion({super.key});

  @override
  State<Presentacion> createState() => _PresentacionState();
}

class _PresentacionState extends State<Presentacion> {
  final controller = PageController();
  bool isLastpage = false;
  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

    Widget page({
    required Color color,
    required String title,
    required String description,
    required String image,
    })=> Container(
      color: color,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            image,
            fit: BoxFit.cover,
            width: 300,
          ),
          const SizedBox(height: 30,),
          Text(title, style: const TextStyle(fontSize: 24, fontFamily: 'ptsbold', color: Colors.black),),
          const SizedBox(height: 30,),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Text(description, textAlign: TextAlign.center, style: const TextStyle(fontSize: 16),),
          )
        ],
      ),
    );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(bottom: 80),
        child: PageView(
          controller: controller,
          onPageChanged: (index){
            setState(()=> isLastpage = index == 2);
          },
          children: [
            page(
              color: const Color.fromARGB(200, 222, 223, 241),
              title: 'Mundo Movil',
              description: 'Bienvenido a Mundo Móvil, tu destino exclusivo donde encuentras todo lo que necesitas para mantenerte a la vanguardia de la última tecnología.',
              image: 'assets/img/MUNDO.png'
            ),
            page(
              color: const Color.fromARGB(200, 222, 223, 241),
              title: 'Productos',
              description: 'Explora nuestra tienda y descubre una amplia selección de dispositivos y accesorios de alta calidad que te ayudarán a estar siempre conectado y actualizado.',
              image: 'assets/img/onb1.png'
            ),
            page(
              color: const Color.fromARGB(200, 222, 223, 241),
              title: '¡Descubre el futuro!',
              description: 'En Mundo Móvil, nos esforzamos por ofrecerte lo mejor en tecnología, brindándote una experiencia de compra única y satisfactoria. ',
              image: 'assets/img/inventario.png'
            ),
          ],
        ),
      ),
      bottomSheet: isLastpage 
      ? TextButton(
        style: TextButton.styleFrom(
          backgroundColor: Colors.blue,
          primary: Colors.white,
          minimumSize: const Size.fromHeight(80),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: const Text('Empezar',
        style: TextStyle( fontSize: 24),
        ),
        onPressed: ()async{
          Navigator.pushReplacementNamed(context, '/login');
        },
      )
      : Container(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
              TextButton(onPressed: () => controller.jumpToPage(2), child: const Text('SKIP')),
              Center(
                child: SmoothPageIndicator(
                  controller: controller,
                  count: 3,
                  effect: const WormEffect(
                    spacing: 16,
                    dotColor: Colors.black,
                    activeDotColor: Colors.blue
                  ),
                  onDotClicked: (index) => controller.animateToPage(
                    index, 
                    duration: const Duration(milliseconds: 500), 
                    curve: Curves.easeIn
                  ),
                ),
              ),
              TextButton(onPressed: ()=> controller.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.easeInOut), child: const Text('NEXT'))
          ],
        ),
      ),
    );
  }
}