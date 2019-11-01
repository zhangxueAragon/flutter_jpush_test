import 'package:flutter/material.dart';
import 'package:jpush_flutter/jpush_flutter.dart';
import 'package:jmessage_flutter/jmessage_flutter.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  String text="界面打开之后稍等一点时间再点击去订阅";

  void _incrementCounter() {
    addTags();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    JPush().setup(appKey: "6da0cdeaa4d433a05cb268a4", production: false, debug: true);
    JmessageFlutter().init(isOpenMessageRoaming: true, appkey: "6da0cdeaa4d433a05cb268a4");
    JPush().applyPushAuthority();
    print("JmessageFlutter.init");
    JPush().addEventHandler(onReceiveMessage: onReceiveMessage,onOpenNotification: onOpenNotification,onReceiveNotification: onReceiveNotification);
  }


  addTags() async{
    String rid=await JPush().getRegistrationID();
    print("addTags---rid="+rid);
    JPush().addTags(["Insomniac_Announcements"]).then((map){
      text="订阅Insomniac_Announcements成功";
      setState(() {

      });
    }).catchError((error){
      print("error=$error");
    });
  }

  Future<dynamic> onReceiveNotification(Map<String, dynamic> event){
    print("onReceiveNotification event=${event}");
  }

  Future<dynamic> onOpenNotification(Map<String, dynamic> event){
    print("onOpenNotification event=${event}");
  }

  Future<dynamic> onReceiveMessage(Map<String, dynamic> event){
    print("onReceiveMessage event=${event}");
  }


  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Container(
          color: Colors.blue,
          child: InkWell(
            onTap: (){addTags();},
            child: Text(text),
          ),
        )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
