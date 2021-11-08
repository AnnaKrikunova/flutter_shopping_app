import 'package:firebase_auth/firebase_auth.dart' as FirebaseAuth;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_shopping_app/model/category.dart';
import 'package:flutter_shopping_app/model/product.dart';
import 'package:flutter_shopping_app/model/product_size.dart';

final subCategorySelected = StateProvider((ref) => SubCategories());
final productSelected = StateProvider((ref) => Product());
final productSizeSelected = StateProvider((ref) => ProductSizes());
final userLogged = StateProvider((ref) => FirebaseAuth.FirebaseAuth.instance.currentUser);