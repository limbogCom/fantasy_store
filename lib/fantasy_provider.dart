import 'package:fantasy_store/fantasy_store_bloc.dart';
import 'package:flutter/cupertino.dart';

class FantasyProvider extends InheritedWidget{

  final FantasyStoreBLoC bloc;
  final Widget child;

  FantasyProvider({@required this.bloc, @required this.child}) : super(child: child);

  static FantasyProvider of(BuildContext context) => context.dependOnInheritedWidgetOfExactType<FantasyProvider>();

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;
  }