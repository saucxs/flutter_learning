import 'package:flutter/material.dart';

void main() => {};

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: new MyHomePage(title: 'Fultter Demo',),
      // 注册路由表
      routes: {
        "new_page": (context) => NewRoutePage(),
        "echo_page": (context) => EchoRoutePage(),
        "testB": (context) {
          return RouterParamsTestB(params: ModalRoute.of(context).settings.arguments);
        },
        "bg_page_1": (context) => BgPage1(),
        "bg_page_2": (context) => BgPage2(),
        "/":(context) => MyHomePage(title: 'Fultter Demo'), //注册首页路由
      },
    );
  }
}

Map<String, WidgetBuilder> routers = {

};

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(
              'You have pushed the button this many times:',
            ),
            new Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline,
            ),
            FlatButton(
              child: Text('打开新页面'),
              textColor: Colors.blue,
              onPressed: () {
                Navigator.pushNamed(context, 'new_page');
                // Navigator.push(context, MaterialPageRoute(builder: (context){
                //   return NewRoutePage();
                // }));
              },
            ),
            FlatButton(
              child: Text('打开新页面EchoPage'),
              textColor: Colors.blue,
              onPressed: () {
                Navigator.of(context).pushNamed('echo_page', arguments: 'saucxs');
              },
            ),
            FlatButton(
              child: Text('路由传参'),
              textColor: Colors.blue,
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return RouterParamsTestA();
                }));
              },
            ),
            FlatButton(
              child: Text('背景图片'),
              textColor: Colors.blue,
              onPressed: () {
                Navigator.pushNamed(context, 'bg_page_2');
              },
            )
          ],
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: new Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

// 新路由
class NewRoutePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("一个新页面"),
      ),
      body: Center(
        child: Text('这是一个新页面'),
      ),
    );
  }
}

class EchoRoutePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
     //获取路由参数  
    var args=ModalRoute.of(context).settings.arguments;
    print('获取路由参数：$args');
    return Scaffold(
      appBar: AppBar(
        title: Text("一个新页面"),
      ),
      body: Center(
        child: Text('命名路由参数传递'),
      )
    );
  }
}


// 新路由Test
class RouterParamsTestA extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: RaisedButton(
        onPressed: () async {
        var result = await Navigator.push(
          context,
          MaterialPageRoute(builder: (context){
            return RouterParamsTestB(params: '页面传参值， A->B',);
          })
        );
        print('路由返回值：$result');
      },
      child: Text('打开提示页RouterParamsTestB'),
      ),
    );
  }
}

// 新路由 路由传值
class RouterParamsTestB extends StatelessWidget {
  RouterParamsTestB({
    Key key,
    @required this.params,    // 接收一个text参数
  }) : super(key: key);
  final String params;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('提示'),),
      body: Padding(
        padding: EdgeInsets.all(18),
        child: Center(
          child: Column(children: <Widget>[
            Text(params),
            RaisedButton(
              onPressed: () => Navigator.pop(context, '返回值saucxs，B->A'),
              child: Text('返回A页面'),
              )
          ],)
        ),
      ),
    );
  }
}

// 资源管理 背景图 AssetImage
class BgPage1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new DecoratedBox(
    decoration: new BoxDecoration(
      image: new DecorationImage(
        image: new AssetImage('asset/images/bg.jpeg'),
      ),
    ),
  );
  }
}

// 资源管理 背景图 Image.asset
class BgPage2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Image.asset('asset/images/bg.jpeg');
  }
}