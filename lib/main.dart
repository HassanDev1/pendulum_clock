import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  _getTime(){
    String minutesBeforeTen = DateTime.now().minute.toString().padLeft(2,'0');
    int hour = DateTime.now().hour;
    String min = '${DateTime.now().minute <= 9 ?minutesBeforeTen:DateTime.now().minute}';
    return ('$hour : $min');
  }
  AnimationController _controller;
  Animation _animation;

  @override
  void initState() {
  //  _getTime();
    super.initState();
    _controller = AnimationController(vsync: this, duration: Duration(seconds: 1));
    _controller.addListener((){
      if(_controller.isCompleted){
          _controller.reverse();
        }
        else if(_controller.isDismissed){
          _controller.forward();
        }
      setState(() {
        
        
      });
    });
    _controller.forward();

  }
  @override
  Widget build(BuildContext context) {
   _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
   _animation = Tween(begin: -0.5,end: 0.5).animate(_animation);
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Colors.deepOrange,
        title: Text('Clock',
        style: TextStyle(
          fontSize:30.0
        ),
        )
      ),
      body: Material(
        color: Colors.deepOrange,
        child:Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children:[
              Material(
                  elevation: 20.0,
                  borderRadius: BorderRadius.circular(50),
                  color:Colors.brown[600],
                  child: Container( 
                    width:450.0,
                    height:450.0,
                    child: Center(
                      child: ShaderMask(
                        shaderCallback: (bounds)=>
                        RadialGradient(
                          center: Alignment.topLeft,
                           radius: 1.0,
                           colors:[
                             Colors.yellow,
                             Colors.deepOrange
                           ],
                           tileMode: TileMode.mirror
                         ).createShader(bounds),
                        child: Text(_getTime(),
                        textAlign:TextAlign.center,
                        style: TextStyle(                       
                          fontSize:70.0,
                          color:Colors.white,
                        
                    ),),
                      ),
                  ),
                  

                ),
              ),
              
              Transform(
                alignment: FractionalOffset(0.5, 0.2),
                transform: Matrix4.rotationZ(_animation.value),
                child: Image.asset('assets/images/pendulum.png',
                height: 350.0,
                ),
              )

            ]
          ),
        )
      ),
      
    );
  }
}
