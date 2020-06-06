import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

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
        "stalessWidget_page_3": (context) => StatelessWidgetPage3(),
        "context_1": (context) => Context1(),
        "counter": (context) {
          return CounterWidget();
          // return Text("saucxs");
        },
        "state_management_A": (context) => StateMangementA(),
        "state_management_B": (context) {
          return ParentWidget();
        },
        "state_management_C": (context) {
          return ParentWidgetC();
        },
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
            ),
            // FlatButton(
            //   child: Text('StatelessWidget'),
            //   textColor: Colors.blue,
            //   onPressed: () {
            //     Navigator.pushNamed(context, 'stalessWidget_page_3');
            //   },
            // ),
            FlatButton(
              child: Text('Context1'),
              textColor: Colors.blue,
              onPressed: () {
                Navigator.pushNamed(context, 'context_1');
              },
            ),
            FlatButton(
              child: Text('counter'),
              textColor: Colors.blue,
              onPressed: () {
                Navigator.pushNamed(context, 'counter');
              },
            ),
            FlatButton(
              child: Text('状态管理A'),
              textColor: Colors.blue,
              onPressed: () {
                Navigator.pushNamed(context, 'state_management_A');
              },
            ),
            FlatButton(
              child: Text('状态管理B'),
              textColor: Colors.blue,
              onPressed: () {
                Navigator.pushNamed(context, 'state_management_B');
              },
            ),
            FlatButton(
              child: Text('状态管理C'),
              textColor: Colors.blue,
              onPressed: () {
                Navigator.pushNamed(context, 'state_management_C');
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


// StatelessWidget 显字符串
class Echo extends StatelessWidget {
  const Echo({
    Key key,  
    @required this.text,
    this.backgroundColor:Colors.green,
  }):super(key:key);

  final String text;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: backgroundColor,
        child: Text(text),
      ),
    );
  }
}

class StatelessWidgetPage3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("StatelessWidget"),
      ),
      body: Center(
        child: Echo(text: '回显字符串'),
      ),
    );
  }
}

// Context
class Context1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Context测试-saucxs')),
      body: Container(
        child: Builder(builder: (context) {
          // 在Widget树中向上查找最近的父级Scaffold widget
          Scaffold scaffold = context.findAncestorWidgetOfExactType<Scaffold>();
          // 直接返回 AppBar的title，此处实际上Text('Context测试')
          return (scaffold.appBar as AppBar).title;
        }),
      ),
    );
  }
}


// State生命周期
class CounterWidget extends StatefulWidget {
  const CounterWidget({
    Key key,
    this.initValue: 0,
  });

  final int initValue;

  @override
  _CounterWidgetState createState() => new _CounterWidgetState();
}

// _CounterWidgetState
class _CounterWidgetState extends State<CounterWidget> {
  int _counter;

  @override
  void initState() {
    super.initState();
    // 初始化状态
    _counter=widget.initValue;
    print('initState');
  }

  @override
  Widget build(BuildContext context) {
    print('build');
    return Scaffold(
      body: Center(
        child: FlatButton(
          child: Text('$_counter'),
          // 点击后计数器自增
          onPressed: () => setState(() => ++_counter),
        )
      ),
    );
  }

  @override
  void didUpdateWidget(CounterWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    print('didUpdateWidget');
  }

  @override 
  void deactivate() {
    super.deactivate();
    print('deactivate');
  }

  @override
  void dispose() {
    super.dispose();
    print('dispose');
  }

  @override
  void reassemble() {
    super.reassemble();
    print('reassemble');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('didChangeDependencies');
  }

}


// StateMangementA 管理自身的状态
class StateMangementA extends StatefulWidget {
  StateMangementA({Key key}) : super(key: key);
  @override
  _StateMangementAState createState() => new _StateMangementAState();
}

class _StateMangementAState extends State<StateMangementA> {
  bool _active = false;
  void _handleTap() {
    setState(() {
      _active = !_active;
    });
  }

  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: _handleTap,
      child: new Container(
        color: Colors.white,
        child: new Center(
           child: new ClipRRect(
            borderRadius: const BorderRadius.all(const Radius.circular(30.0)),
            child: new Container(
              width: 180.0,
              height: 180.0,
              color: _active ? Colors.lightGreen[700] : Colors.grey[600],
              child: new Center(
                child: new Text(
                  _active ? 'Active' : 'Inactive',
                  style: new TextStyle(fontSize: 32.0, color: Colors.white),
                )
              )
            ),
          ),
        ),
      ),
    );
  }
}

// 父widget 为 StateMangementB 管理状态
class ParentWidget extends StatefulWidget {
  @override
  _ParentWidgetState createState() => new _ParentWidgetState();
}

class _ParentWidgetState extends State<ParentWidget> {
  bool _active = false;
  void _handleTapboxChanged(bool newValue) {
    setState(() {
      _active = newValue;
    });
  }
  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new StateMangementB(
        active: _active,
        onChanged: _handleTapboxChanged,
      )
    );
  }
}


// StateMangementB
class StateMangementB extends StatelessWidget {
  StateMangementB({ Key key, this.active: false, @required this.onChanged }) : super(key: key);
  final bool active;
  final ValueChanged<bool> onChanged;

  void _handleTap() {
    onChanged(!active);
  }

 Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: _handleTap,
      child: new Container(
        color: Colors.white,
        child: new Center(
           child: new ClipRRect(
            borderRadius: const BorderRadius.all(const Radius.circular(30.0)),
            child: new Container(
              width: 180.0,
              height: 180.0,
              color: active ? Colors.lightGreen[700] : Colors.grey[600],
              child: new Center(
                child: new Text(
                  active ? 'Active' : 'Inactive',
                  style: new TextStyle(fontSize: 32.0, color: Colors.white),
                )
              )
            ),
          ),
        ),
      ),
    );
  }

}

 
// 管理「混合」状态  StateManagementC
class ParentWidgetC extends StatefulWidget {
  @override
  _ParentWidgetCState createState() => new _ParentWidgetCState();
}

class _ParentWidgetCState extends State<ParentWidgetC> {
  bool _active = false;
  void _handleTapboxChanged(bool newValue) {
    setState(() {
      _active = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new StateManagementC(
        active: _active,
        onChanged: _handleTapboxChanged,
      ),
    );
  }
}


// StateManagementC
class StateManagementC extends StatefulWidget {
  StateManagementC({ Key key, this.active: false, @required this.onChanged}) : super(key: key);
  final bool active;
  final ValueChanged<bool> onChanged;
  @override
  _StateManagementCState createState() => new _StateManagementCState();
}

class _StateManagementCState extends State<StateManagementC> {
  bool _highlight = false;

  void _handleTapDown(TapDownDetails details) {
    setState(() {
      print('$_highlight down');
      _highlight = true;
    });
  }
  void _handleTapUp(TapUpDetails details) {
    setState(() {
       print('$_highlight up');
      _highlight = false;
    });
  }
  void _handleTapCancel() {
    setState(() {
      _highlight = false;
    });
  }
  void _handleTap() {
    widget.onChanged(!widget.active);
  }

  BoxDecoration myBoxDecoration(_active, _highlight) {
  return BoxDecoration(
    color: _active ? Colors.lightGreen[700] : Colors.grey[600],
    borderRadius: const BorderRadius.all(const Radius.circular(30.0)),
    border: _highlight ? new Border.all( color: Colors.teal[700], width: 10.0,) : null,
  );
}

  Widget build(BuildContext context) {
    return new GestureDetector(
      onTapDown: _handleTapDown, // 处理按下事件
      onTapUp: _handleTapUp, // 处理抬起事件
      onTap: _handleTap,
      onTapCancel: _handleTapCancel,
      child: new Container(
        color: Colors.white,
        child: new Center(
           child: new ClipRRect(
            borderRadius: const BorderRadius.all(const Radius.circular(30.0)),
            child: new Container(
              width: 180.0,
              height: 180.0,
              decoration: myBoxDecoration(widget.active, _highlight),
              child: new Center(
                child: new Text(
                  widget.active ? 'Active' : 'Inactive',
                  style: new TextStyle(fontSize: 32.0, color: Colors.white),
                )
              )
            ),
          ),
        ),
      ),
    );
  }

}
