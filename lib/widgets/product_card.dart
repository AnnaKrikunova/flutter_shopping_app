import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shopping_app/model/product.dart';
import 'package:flutter_shopping_app/state/state_management.dart';
import 'package:flutter_riverpod/all.dart';

class ProductCard extends StatelessWidget{
  final Product product;
  ProductCard({Key, key, this.product}):super(key:key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(child: Card(
        elevation: 12,
        child: Column(
          children: [
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Image.network(product.productImages[0].imgUrl,
                  fit: BoxFit.fill,),
                product.productIsSale == true ?
                Column(
                  children: [
                    Container(
                        color: Color(0xDD333639),
                        child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Text(product.productSaleText,
                              style: TextStyle(color: Colors.white),)

                        )
                    )
                  ],
                )
                    :
                Container()
              ],
            ),
            Container(
                padding: const EdgeInsets.all(16),
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AutoSizeText('${product.productName}',
                      maxLines: 2,
                      textAlign:  TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold),),
                    SizedBox(height: 4.0,),
                    product.productSubText == null ? Container() :
                    Text('${product.productSubText}'),
                    SizedBox(height: 4.0,),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text.rich(TextSpan(children: [
                          TextSpan(
                              text: product.productOldPrice == 0 ? '' : '\$${product.productOldPrice}',
                              style: TextStyle(color: Colors.grey,
                                  decoration: TextDecoration.lineThrough)
                          ),
                          TextSpan(
                              text: '\$${product.productNewPrice}',
                              style: TextStyle(fontSize: 18)
                          )
                        ]))
                      ],
                    )
                  ],
                )
            )
          ],
        )
    ), onTap: (){
      context.read(productSelected).state = product;
      Navigator.of(context).pushNamed('/productDetail');
    },);
  }

}