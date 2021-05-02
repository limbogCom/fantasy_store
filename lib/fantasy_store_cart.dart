import 'package:fantasy_store/fantasy_provider.dart';
import 'package:flutter/material.dart';

class FantasyStoreCart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = FantasyProvider.of(context).bloc;
    return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text('Order', style: Theme.of(context).textTheme.headline4.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),),
                    Expanded(
                        child: ListView.builder(
                            itemCount: bloc.cart.length,
                            itemBuilder: (context, index){
                              final item = bloc.cart[index];
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 15.0),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: Colors.white,
                                      backgroundImage: AssetImage(
                                        bloc.cart[index].product.image
                                      ),
                                    ),
                                    const SizedBox(width: 15,),
                                    Text(item.quantity.toString()),
                                    const SizedBox(width: 10,),
                                    Text('X'),
                                    const SizedBox(width: 10,),
                                    Text(item.product.name),
                                    Spacer(),
                                    Text('${(item.product.price*item.quantity).toStringAsFixed(2)} บาท'),
                                    IconButton(icon: Icon(Icons.delete), onPressed: () {
                                      bloc.deleteProduct(item);
                                    }),
                                  ],
                                ),
                              );
                            }
                        )
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 15,),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  Text('รวม', style: TextStyle(color: Colors.grey, fontSize: 20, fontWeight: FontWeight.w600),),
                  Spacer(),
                  Text('${bloc.totalPriceElements()} บาท', style: Theme.of(context).textTheme.headline4.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),)
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: RaisedButton(
                  color: Color(0xFFF4C459),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    child: Text(
                      'ยืนยัน',
                      style: TextStyle(
                          color: Colors.black
                      ),
                    ),
                  ),
                  onPressed: ()=> null
              ),
            ),
        ],
    );
  }
}
