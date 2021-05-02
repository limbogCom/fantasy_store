import 'package:fantasy_store/fantasy_product.dart';
import 'package:flutter/material.dart';

enum FantasyState {
  normal,
  details,
  cart,
}

class FantasyStoreBLoC with ChangeNotifier {
  FantasyState fantasyState = FantasyState.normal;
  List<FantasyProduct> catalog = List.unmodifiable(fantasyProduct);
  List<FantasyProductItem> cart = [];

  void changeToNormal(){
    fantasyState = FantasyState.normal;
    notifyListeners();
  }

  void changeToCart(){
    fantasyState = FantasyState.cart;
    notifyListeners();
  }

  void addProduct(FantasyProduct product){
    for(FantasyProductItem item in cart){
      if (item.product.name == product.name){
        item.increment();
        notifyListeners();
        return;
      }
    }
    cart.add(FantasyProductItem(product: product));
    notifyListeners();
  }

  void deleteProduct(FantasyProductItem productItem){
    cart.remove(productItem);
    notifyListeners();
  }

  int totalCartElements() => cart.fold<int>(0, (previousValue, element) => previousValue + element.quantity);

  double totalPriceElements() => cart.fold<double>(0.0, (previousValue, element) => previousValue + (element.quantity*element.product.price));
}

class FantasyProductItem {
  FantasyProductItem({this.quantity = 1, @required this.product});
  int quantity;
  final FantasyProduct product;

  void increment(){
    quantity++;
  }

  void decrement(){}
}