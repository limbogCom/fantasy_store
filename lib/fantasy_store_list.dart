import 'package:fantasy_store/fantasy_provider.dart';
import 'package:fantasy_store/fantasy_store_details.dart';
import 'package:flutter/material.dart';

import 'main.dart';

class FantasyStoreList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = FantasyProvider.of(context).bloc;
    return Container(
      color: backgroundColor,
      padding: const EdgeInsets.only(top: cartBarHeight, left: 20, right: 20),
      child: StaggeredDualView(
        spacing: 25,
        aspectRatio: 0.7,
        offsetPercent: 0.3,
        itemBuilder: (context, index){
          final product = bloc.catalog[index];
          return GestureDetector(
            onTap: (){
              Navigator.of(context).push(
                  PageRouteBuilder(
                      transitionDuration: const Duration(milliseconds: 600),
                      pageBuilder: (context, animation, _){
                          return FadeTransition(
                            opacity: animation,
                            child: FantasyStoreDetails(
                                product: product,
                                onProductAdded: (){
                                  bloc.addProduct(product);
                                }
                            ),
                          );
                      }
                  )
              );
            },
            child: Card(
              clipBehavior: Clip.hardEdge,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 10,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        child: Hero(
                            tag: 'list_${product.name}',
                            child: Image.asset(
                              product.image, fit: BoxFit.contain,
                            )
                        ),
                    ),
                    Text('${product.price} บาท', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),),
                    Text(product.name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black),)
                  ],
                ),
              ),
            ),
          );
        },
        itemCount: bloc.catalog.length,

      ),
    );
    /*return ListView.builder(
        padding: const EdgeInsets.only(top: cartBarHeight),
        itemCount: bloc.catalog.length,
        itemBuilder: (context, index){
          return Container(
            height: 100,
            width: 100,
            color: Colors.primaries[index % Colors.primaries.length],
          );
        },
    );*/
  }
}

class StaggeredDualView extends StatelessWidget {

  const StaggeredDualView({
    Key key,
    @required this.itemBuilder,
    @required this.itemCount,
    this.spacing = 0.0,
    this.aspectRatio = 0.5,
    this.offsetPercent = 0.5,
  }) : super (key: key);

  final IndexedWidgetBuilder itemBuilder;
  final int itemCount;
  final double spacing;
  final double aspectRatio;
  final double offsetPercent;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints){
      final width = constraints.maxWidth;
      final itemHeight = (width * 0.5) / aspectRatio;
      final height = constraints.maxHeight + itemHeight;
      return OverflowBox(
        maxWidth: width,
        minWidth: width,
        minHeight: height,
        maxHeight: height,
        child: GridView.builder(
          padding: EdgeInsets.only(top: itemHeight / 2, bottom: itemHeight),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: aspectRatio,
            crossAxisSpacing: spacing,
            mainAxisSpacing: spacing,
          ),
          itemCount: itemCount,
          itemBuilder: (context, index){
            return Transform.translate(
              offset: Offset(0.0, index.isOdd ? itemHeight * offsetPercent : 0.0),
              child: itemBuilder(context, index),
            );
          },
        ),
      );
    });
  }
}

