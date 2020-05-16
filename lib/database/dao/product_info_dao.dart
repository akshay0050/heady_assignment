import 'package:heady_assignement/database/db_helper.dart';
import 'package:heady_assignement/database/schema/db_schema.dart';
import 'package:heady_assignement/database/schema/table_product_info.dart';
import 'package:heady_assignement/models/product_info_model.dart';
import 'package:sqflite/sqflite.dart';

class ProductInfoDao {
static Future<List<dynamic>> insertProductInfo(List<ProductInfoModel> productInfoModelList) async{
  final Database db = await DbHelper.instance.database;
  Batch batch = db.batch();
  productInfoModelList.forEach((productInfoObj) {
    batch.insert(DbSchema.TBL_PRODUCT_INFO, productInfoObj.toJson(),conflictAlgorithm: ConflictAlgorithm.replace,);
  });
  return await batch.commit();
}


static Future<ProductInfoModel> getProductById(String prodId) async {
  final Database db = await DbHelper.instance.database;

  final List<Map<String, dynamic>> maps =
  await db.query(DbSchema.TBL_PRODUCT_INFO,
      where: "productId=?",
      whereArgs: [prodId],
      orderBy: ' 1 desc');

    int i= 0;
    return ProductInfoModel(
        iId: maps[i][TblProductInfo.COL_ID],
        productId: maps[i][TblProductInfo.COL_PRODUCT_ID],
        categoryName: maps[i][TblProductInfo.COL_CATEGORY_NAME] != null ? maps[i][TblProductInfo.COL_CATEGORY_NAME].toString():"",
        productJson: maps[i][TblProductInfo.COL_PRODUCT_JSON] != null ? maps[i][TblProductInfo.COL_PRODUCT_JSON]: "",
    );
}
}