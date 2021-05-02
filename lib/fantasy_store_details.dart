import 'package:fantasy_store/fantasy_product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FantasyStoreDetails extends StatefulWidget {
  const FantasyStoreDetails({Key key, @required this.product, this.onProductAdded}) : super(key: key);
  final FantasyProduct product;
  final VoidCallback onProductAdded;

  @override
  _FantasyStoreDetailsState createState() => _FantasyStoreDetailsState();
}

class _FantasyStoreDetailsState extends State<FantasyStoreDetails> {

  String heroTag = '';

  void _addToCart(BuildContext context){

    setState(() {
      heroTag = 'details';
    });

    widget.onProductAdded();
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.black,),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Hero(
                        tag: 'list_${widget.product.name}$heroTag',
                        child: Image.asset(
                          widget.product.image,
                          fit: BoxFit.cover,
                          height: MediaQuery.of(context).size.height * 0.4,
                        ),
                      ),
                    ),
                    Text(
                      widget.product.name,
                      style: Theme.of(context).textTheme.headline5.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    const SizedBox(height: 15,),
                    /*Text(
                      product.name,
                      style: Theme.of(context).textTheme.headline4.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.bold
                      ),
                    ),*/
                    Row(
                      children: [
                        Spacer(),
                        Text(
                          '${widget.product.price} บาท',
                          style: Theme.of(context).textTheme.headline4.copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15,),
                    Text(
                      'โภชนาการ',
                      style: Theme.of(context).textTheme.subtitle1.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    const SizedBox(height: 10,),
                    Text(
                      widget.product.description,
                      style: Theme.of(context).textTheme.subtitle1.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.w200
                      ),
                    ),
                  ],
                ),
              )
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: IconButton(
                      icon: Icon(
                        Icons.favorite_border,
                        color: Colors.black,
                      ),
                      onPressed: ()=> null,
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: RaisedButton(
                      color: Color(0xFFF4C459),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                        child: Text(
                          'สั่งรายการ',
                          style: TextStyle(
                            color: Colors.black
                          ),
                        ),
                      ),
                      onPressed: ()=> _addToCart(context)
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
