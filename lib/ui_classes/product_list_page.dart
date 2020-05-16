import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:heady_assignement/data/product_icons.dart';
import 'package:heady_assignement/models/all_product_data_model.dart';
import 'package:heady_assignement/style/Style.dart';
import 'package:heady_assignement/ui_classes/product_detail_page.dart';
import 'package:page_transition/page_transition.dart';

class ProductListPage extends StatefulWidget{
  final Categories categories;
  ProductListPage(this.categories);

  @override
  State<StatefulWidget> createState() {
    return ProductListPageState(categories);
  }
}

class ProductListPageState extends State<ProductListPage> {
  final Categories categories;
  ProductListPageState(this.categories);
  String header = "Product Detail";

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.header = "${categories.name}";
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("$header"),
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
    for(var product in categories.products) {
      widgetList.add(

          new Container(
            padding: const EdgeInsets.all(3),
            child:  new Card(
                color: Colors.black,
                elevation: 2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(3.0)),
                    side: BorderSide(width: 2, color: Colors.green)),
                child:
                InkWell(
                  splashColor: Colors.purple,
                  onTap: () {
                    onOpenProductDetail(product, categories.name);
                  },
                  child: Stack(
                    children: <Widget>[
                      Image.asset(
                        productIcons.containsKey(categories.name) ? productIcons[categories.name].trim(): "assets/images/img_casuals_shoes.jpg",
                        fit: BoxFit.cover,
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

  void onOpenProductDetail(Products product, String categoryName) {
    Navigator.push(context,
        PageTransition(
          child: ProductDetailPage(product,categoryName),
          type: PageTransitionType.rightToLeft,
          duration: Duration(milliseconds: 500),
        ));
  }

}