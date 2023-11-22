import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:project/pages/client/detail/cliente_product_detail_controller.dart';

class CienteProducDetail extends StatefulWidget {
  const CienteProducDetail({super.key});

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
      _con.init(context, refresh);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('ddddddddd'),
    );
  }

  void refresh(){
    setState(() {
      
    });
  }
}