import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_shopping_app/const/const.dart';
import 'package:flutter_shopping_app/const/utils.dart';
import 'package:flutter_shopping_app/floor/dao/cart_dao.dart';
import 'package:flutter_shopping_app/floor/entity/cart_product.dart';
import 'package:flutter_shopping_app/model/category.dart';
import 'package:flutter_shopping_app/model/product.dart';
import 'package:flutter_shopping_app/network/api_request.dart';
import 'package:flutter_shopping_app/state/state_management.dart';
import 'package:flutter_shopping_app/widgets/product_card.dart';
import 'package:flutter_shopping_app/widgets/size_widget.dart';

class ProductDetailPage extends ConsumerWidget{
  final CartDAO dao;

  ProductDetailPage({this.dao}); // ignore: top_level_function_literal_block
  final _fetchProductById = FutureProvider.family<Product, int>((ref, id) async {
    var result = await fetchProductsDetail(id);
    return result;
  });


  @override
  Widget build(BuildContext context, watch) {

    var productsApiResult = watch(_fetchProductById(context.read(productSelected).state.productId));
    var _productSizeSelected = watch(productSizeSelected).state;

    return Scaffold(
        body: Builder(builder: (context){
          return SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: productsApiResult.when(
                      loading: () => const Center(child: CircularProgressIndicator(),),
                      error: (error, stack) => Center(child: Text('$error'),),
                      data: (product) => SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                CarouselSlider(items: product.productImages.map((e) => Builder(
                                  builder: (context){
                                    return Container(child: Image(image: NetworkImage(e.imgUrl),fit: BoxFit.fill),);
                                  },
                                )).toList(),
                                    options: CarouselOptions(
                                        height: MediaQuery.of(context).size.height/3*2.5,
                                        autoPlay: true,
                                        viewportFraction: 1,
                                        initialPage: 0
                                    ))
                              ],),
                            /*Name of Product*/
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: Text('${product.productName}', style: TextStyle(fontSize: 20),),
                            ),
                            /*Price of Product*/
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child:
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text.rich(TextSpan(children: [
                                    TextSpan(
                                        text: product.productOldPrice == 0 ? '' : '\₴${product.productOldPrice}',
                                        style: TextStyle(color: Colors.grey,
                                            decoration: TextDecoration.lineThrough)
                                    ),
                                    TextSpan(
                                        text: '\₴${product.productNewPrice}',
                                        style: TextStyle(fontSize: 18)
                                    )
                                  ]))
                                ],
                              ),
                            ),
                            /*Detail Short*/
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: Text('${product.productShortDescription}', style: TextStyle(fontSize: 16),
                                textAlign: TextAlign.justify,),
                            ),
                            /*SIZE*/
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: Text('Size', style: TextStyle(fontSize: 20,
                                  decoration: TextDecoration.underline),
                                textAlign: TextAlign.justify,),
                            ),
                            product.productSizes != null ? Wrap(
                              children: product.productSizes
                                  .map((size) => GestureDetector(onTap: size.number > 0 ? (){
                                //If size number > 0, we will add event
                                context.read(productSizeSelected).state = size;

                              }: null, child: SizeWidget(
                                  SizeModel(_productSizeSelected.size == size.size, size), size),))
                                  .toList(),
                            )
                                : Container(),
                            /* Warning Text*/
                            _productSizeSelected.number != null && _productSizeSelected.number <= 5 ?
                            Center(child: Text('Only ${_productSizeSelected.number} left in stock',
                              style: TextStyle(fontSize: 20, color: Colors.red),),) : Container(),
                            /*Button*/
                            Column(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(left: 8, right: 8),
                                  width: double.infinity,
                                  child: RaisedButton(
                                    color: Colors.black,
                                    onPressed: _productSizeSelected.size == null ? null : () async{
                                      try{
                                        //get product
                                        var cartProduct = await dao.getItemInCartByUid(NOT_SIGN_IN, product.productId);
                                        if (cartProduct != null){
                                          cartProduct.quantity++;
                                          await dao.updateCart(cartProduct);
                                          showSnackBarWithViewCart(context, 'Update item in cart success');
                                        } else {
                                          Cart cart = new Cart(
                                            productId: product.productId,
                                            price: product.productNewPrice,
                                            quantity: 1,
                                            size: _productSizeSelected.size.sizeName,
                                            imageUrl: product.productImages[0].imgUrl,
                                            name: product.productName,
                                            uid: NOT_SIGN_IN, code: ''
                                          );
                                          await dao.insertCart(cart);
                                          showSnackBarWithViewCart(context, 'Add item to cart success');
                                        }
                                      }catch(e){
                                        showOnlySnackBar(context, '$e');
                                      }
                                    },
                                    child: Text('Add To Bag', style: TextStyle(color: Colors.white),),
                                  ),
                                ),
                                Container(
                                    margin: const EdgeInsets.only(left: 8, right: 8),
                                    width: double.infinity,
                                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                      Expanded(child: RaisedButton(
                                        color: Colors.black,
                                        child: Text('Wishlist', style: TextStyle(color: Colors.white),),
                                      ),),
                                      SizedBox(width: 20,),
                                      Expanded(child: RaisedButton(
                                        color: Colors.black,
                                        child: Text('Notify Me', style: TextStyle(color: Colors.white),),
                                      ),)
                                    ],)
                                ),
                              ],
                            ),
                            /*Detail*/
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: Text('Material', style: TextStyle(fontSize: 20,
                                  decoration: TextDecoration.underline),
                                textAlign: TextAlign.justify,),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: Text('${product.productDescription}', style: TextStyle(
                                fontSize: 14,
                              ),
                                textAlign: TextAlign.justify,),
                            ),
                          ],
                        ),)
                  ),
                )
              ],
            ),);
        },)
    );
  }




}