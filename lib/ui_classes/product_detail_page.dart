import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:heady_assignement/data/product_icons.dart';
import 'package:heady_assignement/models/all_product_data_model.dart';
import 'package:heady_assignement/style/Style.dart';

class ProductDetailPage extends StatefulWidget {
  final Products product;
  final String categoryName;
  ProductDetailPage(this.product, this.categoryName);

  @override
  State<StatefulWidget> createState() {
    return ProductDetailState(this.product, this.categoryName);
  }
}

class ProductDetailState extends State<ProductDetailPage> {
  final Products product;
  final String categoryName;
  List<Variants> variantDataList;

  String price ="0";
  bool isSelectedVariant = false;
  ProductDetailState(this.product, this.categoryName);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  if(!isSelectedVariant) {
    this.variantDataList = product.variants;
    if (this.variantDataList != null && this.variantDataList.length > 0) {
      variantDataList[0].isSelected = true;
      this.price = variantDataList[0].price.toString();
    }
  }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${product.name}"),
        centerTitle: true,
      ),
      body: buildUi(),
    );
  }

  Widget buildUi() {
    return
    Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Card(
            color: Colors.white,
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
            ),
            child: FittedBox(
              child: Image.asset(
                productIcons.containsKey(this.categoryName)
                    ? productIcons[this.categoryName]
                    : "assets/images/img_yellow_background.jpg",
              ),
              fit: BoxFit.fill,
            ),
            margin:
            EdgeInsets.only(top: 10.0, bottom: 10.0, left: 5.0, right: 5.0),
          ),
          Padding(
            padding: EdgeInsets.all(5.0),
            child: Text(
              "Variants",
              style: Style.variantHeader,
            ),
          ),
          buildVariantList(),
          Padding(
            padding: EdgeInsets.all(5.0),
            child: Text(
              "$price ₹",
              style: Style.variantHeader,
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
          Text(
            "${product.tax.name}",
            style: Style.taxName,
          ),
          Text(
            "${product.tax.value}%",
            style: Style.variantName,
          )
        ],
      ),
    );
  }

  Widget buildVariantList() {
    return
    Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
      height: MediaQuery.of(context).size.height * 0.20,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: getVariantList(),
      ),
    );
  }

  List<Widget> getVariantList() {
    List<Widget> variantList = List<Widget>();
    for(var i= 0; i<variantDataList.length; i++) {
      Variants variant = variantDataList[i];
      variantList.add(
          new Container(
            width: MediaQuery.of(context).size.width * 0.3,
            child: new Card(
                color: Colors.white,
                elevation: 2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    side: BorderSide(width: 4, color: variant.isSelected ?Colors.lightGreenAccent :Colors.blueGrey)),
                child:
                InkWell(
                    splashColor: Colors.purple,
                    onTap: () {
                      this.isSelectedVariant = true;
                      updateVariantList(i);
                    },
                    child:
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        variant.size != null ?
                        Text(
                          "${variant.size}",
                          style: Style.variantName,
                        ) : Container(),
                        SizedBox(height: 3.0,),
                        variant.color != null ?
                        Text(
                          "${variant.color}",
                          style: Style.variantSubName,
                        ) : Container()
                      ],
                    )
                )




            ),
          ));

    }
    return variantList;
  }

  void updateVariantList(int position) {
    setState(() {
      Variants variants = variantDataList[position];
      this.price = variants.price.toString();
      print("price - $price");
      variantDataList[position].isSelected = true;
      for (var i = 0; i < variantDataList.length; i++) {
        Variants variantObj = variantDataList[i];
        if (variants.id != variantObj.id) {
          variantDataList[i].isSelected = false;
        }
      }
    });
  }
}
