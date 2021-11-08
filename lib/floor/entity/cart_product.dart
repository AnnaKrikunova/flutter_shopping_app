// @dart=2.12
import 'package:floor/floor.dart';

@entity
class Cart{
  @primaryKey
  final int productId;
  final String uid,name,imageUrl,size,code;
  double price;
  int quantity;

  @ignore
  Cart({required this.productId, required this.uid, required this.name, required this.imageUrl, required this.size,
    required this.code, required this.price, required this.quantity
  });
}