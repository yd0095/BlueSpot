import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' ;
import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:vector_math/vector_math_64.dart' as vect;


class ARPage extends StatefulWidget {
  @override
  _ARPageState createState() => _ARPageState();
}

class _ARPageState extends State<ARPage> {

  ArCoreController arCoreController;

  _onArCoreViewCreated(ArCoreController _arCoreController){
    arCoreController = _arCoreController;
    _addSphere(arCoreController);
  }

  _addSphere(ArCoreController _arCoreController){
    
    vect.Vector3 pos = vect.Vector3(0, 0, -1);
    
    final material = ArCoreMaterial(color: Colors.deepOrange);
    final sphere = ArCoreSphere(materials: [material], radius: 0.2);
    final node = ArCoreNode(shape: sphere, position: vect.Vector3(0,0,-1));

    _arCoreController.addArCoreNode(node);
  }

  @override
  void dispose() {
    arCoreController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ArCoreView(onArCoreViewCreated: _onArCoreViewCreated,),
    );
  }


}
