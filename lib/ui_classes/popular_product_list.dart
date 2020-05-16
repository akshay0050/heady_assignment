import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:heady_assignement/data/product_icons.dart';
import 'package:heady_assignement/database/dao/product_info_dao.dart';
import 'package:heady_assignement/models/all_product_data_model.dart';
import 'package:heady_assignement/models/product_info_model.dart';
import 'package:heady_assignement/style/Style.dart';
import 'package:heady_assignement/ui_classes/product_detail_page.dart';
import 'package:page_transition/page_transition.dart';

class PopularProductList extends StatefulWidget {
  final int currentBottomTabIndex;
  final AllProductDataModel allProductData;
  PopularProductList(this.currentBottomTabIndex, this.allProductData);

  @override

  State<StatefulWidget> createState() {
    return PopularProductListState(this.currentBottomTabIndex, this.allProductData);
  }

}
class PopularProductListState extends State<PopularProductList> {
  final int currentBottomTabIndex;
  final AllProductDataModel allProductData;
  List<Rankings> rankingProductList = List<Rankings>();
  List<Categories> productCategoryList = List<Categories>();
  PopularProductListState(this.currentBottomTabIndex, this.allProductData);
  List<Products> popularProducts =  List<Products>();
  String categoryName = "";


  @override
  void initState() {
    super.initState();
    this.rankingProductList = allProductData.rankings;
    this.productCategoryList = allProductData.categories;
    getProductBasedOnRank();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${rankingProductList[currentBottomTabIndex].ranking}"),
        centerTitle: true,
      ),
      body: buildProductCategoryList(),
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
    for(var product in this.popularProducts) {
      widgetList.add(

          new Container(
            padding: const EdgeInsets.all(3),
            child:  new Card(
                color: Colors.white,
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    //side: BorderSide(width: 2, color: Colors.green)
                    ),
                child:
                InkWell(
                  splashColor: Colors.purple,
                  onTap: () {
                    onOpenProductDetail(product, this.categoryName);
                  },
                  child: Stack(
                    children: <Widget>[
                      Container(
                        color: Colors.purple[300],
                        height: 300,
                        width: 300,
                      ),
                      Center(
                        child: Text("${product.name}",style: Style.productCategoryName,),
                      )
                    ],
                  ),
                )




            ),
          ));
    }
    return widgetList;
  }


  void getProductBasedOnRank() async{
    Rankings rankProductCategory = rankingProductList[this.currentBottomTabIndex];
    List<RankingProducts> productsBasedOnRankList = rankProductCategory.products;
    for(var rankProduct in productsBasedOnRankList) {
      ProductInfoModel infoModel = await ProductInfoDao.getProductById(rankProduct.id.toString());
      this.categoryName = infoModel.categoryName;
      Products products = Products.fromJson(json.decode(infoModel.productJson));
      popularProducts.add(products);
    }
    setState(() {
      this.popularProducts = popularProducts;
    });
  }

  void onOpenProductDetail(Products product, String categoryName) {
    Navigator.push(context,
        PageTransition(
          child: ProductDetailPage(product,categoryName),
          type: PageTransitionType.rightToLeft,
          duration: Duration(milliseconds: 500),
        ));
  }

}