// @dart=2.12
import 'dart:async';
import 'package:floor/floor.dart';
import 'package:flutter_shopping_app/floor/dao/cart_dao.dart';
import 'package:flutter_shopping_app/floor/entity/cart_product.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'database.g.dart';
@Database(version:1,entities: [Cart])
abstract class AppDatabase extends FloorDatabase{
  CartDAO get cartDao;
}