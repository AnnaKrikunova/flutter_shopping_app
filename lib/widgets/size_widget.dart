import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shopping_app/model/product.dart';
import 'package:flutter_shopping_app/model/product_size.dart';
import 'package:flutter_shopping_app/state/state_management.dart';
import 'package:flutter_riverpod/all.dart';

class SizeWidget extends StatelessWidget{
  final SizeModel sizeModel;
  final ProductSizes productSizes;


  SizeWidget(this.sizeModel, this.productSizes);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(2.0),
      child: Container(
        width: 50.0, height: 50.0,
        child: Center(child: Text(sizeModel.productSizes.size.sizeName, style: TextStyle(
          color: sizeModel.productSizes.number == 0 ? Colors.white : sizeModel.isSelected ? Colors.white : Colors.black,
          fontSize: 18.0
        ),),),
        decoration: BoxDecoration(
          color: sizeModel.productSizes.number == 0 ? Colors.grey : sizeModel.isSelected ? Colors.black : Colors.transparent,
          border: Border.all(
            width: 1.0,
            color: sizeModel.isSelected ? Colors.black : Colors.grey
          ),
          borderRadius: const BorderRadius.all(const Radius.circular(2.0))
        ),
      ),
    );
  }

}

class SizeModel{
  bool isSelected;
  final ProductSizes productSizes;

  SizeModel(this.isSelected, this.productSizes);
}