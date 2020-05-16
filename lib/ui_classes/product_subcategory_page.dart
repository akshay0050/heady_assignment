import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heady_assignement/bloc/bloc.dart';
import 'package:heady_assignement/bloc/product_data_bloc.dart';
import 'package:heady_assignement/bloc/product_data_state.dart';
import 'package:heady_assignement/data/product_icons.dart';
import 'package:heady_assignement/database/dao/product_category_dao.dart';
import 'package:heady_assignement/models/all_product_data_model.dart';
import 'package:heady_assignement/models/product_category_model.dart';
import 'package:heady_assignement/style/Style.dart';
import 'package:heady_assignement/ui_classes/popular_product_list.dart';
import 'package:heady_assignement/ui_classes/product_list_page.dart';
import 'package:page_transition/page_transition.dart';


class ProductSubcategoryPage extends StatefulWidget {
  final List<int> childCategories;
  final String categoryName;
  ProductSubcategoryPage(this.childCategories, this.categoryName);


  @override
  State<StatefulWidget> createState() {
    return _ProductSubcategoryPageState(this.childCategories,this.categoryName);
  }
}

class _ProductSubcategoryPageState extends State<ProductSubcategoryPage> {
  AllProductDataModel allProductData;
  final List<int> childCategories;
  final String categoryName;
  String header = "Product";
  List<ProductCategoryModel> categoryList = List<ProductCategoryModel>();

  _ProductSubcategoryPageState(this.childCategories,this.categoryName);
  @override
  void initState() {
    super.initState();
    this.header = this.categoryName;
    getCategoryListFromDb();
  }

  void getCategoryListFromDb() async{
    for(var childId in childCategories) {
      ProductCategoryModel categoryModel = await ProductCategoryDao.getProductCategoryById(childId.toString());
      this.categoryList.add(categoryModel);
    }
    setState(() {
      this.categoryList = categoryList;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("$header Sub-Category"),
          centerTitle: true,
        ),
        body: this.categoryList.length>0 ?
        buildProductCategoryList() :buildLoading()
    );
  }

  Widget buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget buildProductCategoryList() {
    return CustomScrollView(
      primary: false,
      slivers: <Widget>[
        SliverPadding(
          padding: const EdgeInsets.all(10),
          sliver: SliverGrid.count(
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
            crossAxisCount: 2,
            children: buildArrayOfProductCategory(),
          ),
        ),
      ],
    );
  }

  List<Widget> buildArrayOfProductCategory() {
    List<Widget> widgetList = List<Widget>();

    for(var categoriesObj in this.categoryList) {
      Categories categories = Categories.fromJson(json.decode(categoriesObj.categoryJson));
      widgetList.add(

          new Container(
        padding: const EdgeInsets.all(3),
        child:
        new Card(
          color: Colors.black,
          elevation: 2,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              side: BorderSide(width: 2, color: Colors.green)),
          child:
              InkWell(
                splashColor: Colors.purple,
                onTap: () {
                  onProductDetail(categories);
                },
                child: Stack(
                  children: <Widget>[
                    Image.asset(
                      productIcons.containsKey(categories.name) ? productIcons[categories.name].trim(): "assets/images/img_casuals_shoes.jpg",
                      fit: BoxFit.cover,
                    ),
                    Center(
                      child: Text("${categories.name}",style: Style.productCategoryName,),
                    )
                  ],
                ),
              )




        ),
      ));
    }
    return widgetList;
  }


  void onProductDetail(Categories categories) {
    Navigator.push(context,
        PageTransition(
          child: ProductListPage(categories),
          type: PageTransitionType.rightToLeft,
          duration: Duration(milliseconds: 500),
        ));
  }

}
