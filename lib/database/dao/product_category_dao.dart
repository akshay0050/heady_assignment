import 'package:heady_assignement/database/db_helper.dart';
import 'package:heady_assignement/database/schema/db_schema.dart';
import 'package:heady_assignement/database/schema/table_product_category.dart';
import 'package:heady_assignement/models/product_category_model.dart';
import 'package:sqflite/sqflite.dart';

class ProductCategoryDao {
static Future<List<dynamic>> insertProductCategory(List<ProductCategoryModel> productCategoryModelList) async{
  final Database db = await DbHelper.instance.database;
  Batch batch = db.batch();
  productCategoryModelList.forEach((productCategoryObj) {
    batch.insert(DbSchema.TBL_PRODUCT_CATEGORY, productCategoryObj.toJson(),conflictAlgorithm: ConflictAlgorithm.replace,);
  });
  return await batch.commit();
}


static Future<ProductCategoryModel> getProductCategoryById(String categoryId) async {
  final Database db = await DbHelper.instance.database;

  final List<Map<String, dynamic>> maps =
  await db.query(DbSchema.TBL_PRODUCT_CATEGORY,
      where: "categoryId=?",
      whereArgs: [categoryId],
      orderBy: ' 1 desc');

    int i= 0;
return ProductCategoryModel(
  iId: maps[i][TblProductCategory.COL_ID],
  categoryId: maps[i][TblProductCategory.COL_CATEGORY_ID],
  categoryName: maps[i][TblProductCategory.COL_CATEGORY_NAME] != null ? maps[i][TblProductCategory.COL_CATEGORY_NAME].toString():"",
  categoryJson: maps[i][TblProductCategory.COL_CATEGORY_JSON] != null ? maps[i][TblProductCategory.COL_CATEGORY_JSON]: "",
);
      

}
}