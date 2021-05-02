import 'package:fantasy_store/fantasy_provider.dart';
import 'package:fantasy_store/fantasy_store_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'fantasy_store_cart.dart';
import 'fantasy_store_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: MyHomePage(),
    );
  }
}

const backgroundColor = Color(0XFFF6F5F2);
const cartBarHeight = 100.0;
const _panelTransition = Duration(milliseconds: 500);

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final bloc = FantasyStoreBLoC();

  void _onVerticalGesture(DragUpdateDetails details){
    print(details.primaryDelta);
    if(details.primaryDelta < -7){
      bloc.changeToCart();
    } else if (details.primaryDelta > 12) {
      bloc.changeToNormal();
    }
  }

  double _getTopForWhitePanel(FantasyState state, Size size){
    if(state == FantasyState.normal){
      return -cartBarHeight + kToolbarHeight;
    } else if (state == FantasyState.cart){
      return -(size.height - kToolbarHeight + cartBarHeight / 2);
    }
    return 0.0;
  }

  double _getTopForBlackPanel(FantasyState state, Size size){
    if(state == FantasyState.normal){
      return size.height - cartBarHeight;
    } else if (state == FantasyState.cart){
      return cartBarHeight / 2;
    }
    return 0.0;
  }

  double _getTopForAppBar(FantasyState state){
    if(state == FantasyState.normal){
      return 0.0;
    } else if (state == FantasyState.cart){
      return -cartBarHeight;
    }
    return 0.0;
  }

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return FantasyProvider(
      bloc: bloc,
      child: AnimatedBuilder(
        animation: bloc,
        builder: (context, _) {
          return Scaffold(
            backgroundColor: Colors.black,
            body: Stack(
              children: [
                AnimatedPositioned(
                  duration: _panelTransition,
                  curve: Curves.decelerate,
                  left: 0,
                  right: 0,
                  top: _getTopForWhitePanel(bloc.fantasyState, size),
                  height: size.height - kToolbarHeight,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      child: FantasyStoreList(),
                    ),
                  ),
                ),
                AnimatedPositioned(
                  duration: _panelTransition,
                  curve: Curves.decelerate,
                  left: 0,
                  right: 0,
                  top: _getTopForBlackPanel(bloc.fantasyState, size),
                  height: size.height - kToolbarHeight,
                  child: GestureDetector(
                    onVerticalDragUpdate: _onVerticalGesture,
                    child: Container(
                      color: Colors.black,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(25.0),
                            child: AnimatedSwitcher(
                              duration: _panelTransition,
                              child: SizedBox(
                                height: kToolbarHeight,
                                child: bloc.fantasyState == FantasyState.normal ? Row(
                                children: [
                                  Text(
                                    'Order',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20
                                    ),
                                  ),
                                  Expanded(
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                        child: Row(
                                          children: List.generate(
                                              bloc.cart.length,
                                              (index) => Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                                child: Stack(
                                                  children: [
                                                    Hero(
                                                      tag: 'list_${bloc.cart[index].product.name}details',
                                                      child: CircleAvatar(
                                                        backgroundColor: Colors.white,
                                                        backgroundImage: AssetImage(bloc.cart[index].product.image),
                                                      ),
                                                    ),
                                                    Positioned(
                                                      right: 0,
                                                      child: CircleAvatar(
                                                        radius: 10,
                                                        backgroundColor: Colors.red,
                                                        child: Text(
                                                            bloc.cart[index].quantity.toString(),
                                                            style: TextStyle(
                                                              color: Colors.white,
                                                            ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  CircleAvatar(
                                    backgroundColor: Colors.red,
                                    child: Text(
                                      bloc.totalCartElements().toString(),
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  )
                                ],
                                ) : const SizedBox.shrink(),
                              ),
                            ),
                          ),
                          Expanded(child: FantasyStoreCart()),
                        ],
                      ),
                    ),
                  ),
                ),
                AnimatedPositioned(
                  duration: _panelTransition,
                  curve: Curves.decelerate,
                  left: 0,
                  right: 0,
                  top: _getTopForAppBar(bloc.fantasyState),
                  child: _AppBarFantasy()
                ),
              ],
            ), // This trailing comma makes auto-formatting nicer for build methods.
          );
        }
      ),
    );
  }
}

class _AppBarFantasy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: kToolbarHeight,
      color: backgroundColor,
      child: Row(
        children: [
          /*BackButton(
            color: Colors.black,
            onPressed: () => Navigator.of(context).pop(),
          ),*/
          SizedBox(width: 30),
          Expanded(
            child: Text(
              'ร้านอีสานแซบอีลี่',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 25
              ),
            ),
          ),
          IconButton(icon: Icon(Icons.settings), onPressed: ()=>{})
        ],
      ),
    );
  }
}

