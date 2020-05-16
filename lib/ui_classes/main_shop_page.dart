import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heady_assignement/bloc/bloc.dart';
import 'package:heady_assignement/bloc/product_data_bloc.dart';
import 'package:heady_assignement/bloc/product_data_state.dart';
import 'package:heady_assignement/data/fetch_product_data.dart';
import 'package:heady_assignement/data/product_icons.dart';
import 'package:heady_assignement/models/all_product_data_model.dart';
import 'package:heady_assignement/style/Style.dart';
import 'package:heady_assignement/ui_classes/popular_product_list.dart';
import 'package:heady_assignement/ui_classes/product_list_page.dart';
import 'package:heady_assignement/ui_classes/product_subcategory_page.dart';
import 'package:heady_assignement/utility/common_message.dart';
import 'package:page_transition/page_transition.dart';

class MainShopPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductDataBloc(FetchProductData()),
      child: MainShopPageStateCreate(),
    );
  }

}

class MainShopPageStateCreate extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MainShopPageState();
  }
}

class MainShopPageState extends State<MainShopPageStateCreate> {
  dynamic productBloc;
  String errorMsg = "";
@override
  void didChangeDependencies() {
    super.didChangeDependencies();
   this.initializeBlockProvider();
  }

  void initializeBlockProvider() {
    productBloc  = BlocProvider.of<ProductDataBloc>(context);
    productBloc.add(GetAllProductData());
  }

  @override
  Widget build(BuildContext context) {

    return
      Container(
      color: Colors.white,
      alignment: Alignment.center,
      child: BlocListener<ProductDataBloc, ProductDataState>(
        listener: (context, state) {
          if (state is ProductDataError) {
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
          }
        },
        child: BlocBuilder<ProductDataBloc, ProductDataState>(
          builder: (context, state) {
            if (state is ProductDataInitial) {
              return Text("Data is loading...");
            } else if (state is ProductDataLoading) {
              return buildLoading();
            } else if (state is ProductDataLoaded) {
              print("loaded data is  ${state.allProductData.toJson()}");
              return MainShopPageManageState(state.allProductData,productBloc);
            } else if(state is NoInternetError) {
              this.errorMsg = CommonMessage.noInternetMsg;
              return buildErrorScreen();
            } else if(state is ProductDataError){
              this.errorMsg = CommonMessage.networkErrortMsg;
              return buildErrorScreen();
            }
            else{
              return Text("Data is loading...");
            }
          },
        ),
      ),
    );
  }
  Widget buildErrorScreen(){
    return
      Container(
          margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child:
          Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                    child: const Icon(
                      Icons.network_check,
                      color: Colors.green,
                      size: 100.0,
                    )),
                Padding(
                  padding: EdgeInsets.only(
                      top: 20.0, bottom: 20.0, left: 10.0, right: 10.0),
                  child: Text(
                    this.errorMsg,
                    style: Style.errorText,
                    textAlign: TextAlign.center,
                  ),
                ),
                Card(
                  child: InkWell(
                      splashColor: Colors.lightBlueAccent,
                      onTap: this.initializeBlockProvider,
                      child: Container(
                        child: Icon(
                          Icons.refresh,
                          size: 50.0,
                          color: Colors.purple,
                        ),
                      )
                  ),
                )




              ]
          )
          );
  }


  Widget buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}

class MainShopPageManageState extends StatefulWidget {
  final AllProductDataModel allProductData;
  final dynamic productBloc;
  MainShopPageManageState(this.allProductData, this.productBloc);

  @override
  State<StatefulWidget> createState() {
    return _MainShopPageState(allProductData,this.productBloc);
  }
}

class _MainShopPageState extends State<MainShopPageManageState> {
  dynamic productBloc;
  AllProductDataModel allProductData;
  int _currentBottomTabIndex = 0;
  _MainShopPageState(this.allProductData,this.productBloc);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Heady's Store"),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.refresh,
                color: Colors.white,
              ),
              onPressed: () {
                // do something
                refreshScreen();
              },
            )
          ],
        ),
        bottomNavigationBar: buildBottomNavigationBar(),
        body:buildProductCategoryList()
    );
  }

  void refreshScreen() {
    widget.productBloc.add(GetAllProductData());
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
    for(var categories in allProductData.categories) {
      widgetList.add(

          new Container(
        padding: const EdgeInsets.all(3),
        child:
        new Card(
          color: Colors.white,
          elevation: 2,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              side: BorderSide(width: 2, color: Colors.white)),
          child:
              InkWell(
                splashColor: Colors.purple,
                onTap: () {
                  if(categories.childCategories != null && categories.childCategories.length > 0) {
                    onSubProductPage(categories.childCategories,categories.name);
                  }else {
                    onProductDetail(categories);
                  }
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

  Widget buildBottomNavigationBar() {
    return BottomNavigationBar(
      onTap: onTabTapped, // new
      backgroundColor: Colors.purple,
      currentIndex: _currentBottomTabIndex, // new
      items: [
        new BottomNavigationBarItem(
          icon: Icon(Icons.remove_red_eye, color: Colors.green,),
          title: Text('Most Viewed',style: Style.bottomText,),
        ),
        new BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart,color: Colors.redAccent,),
          title: Text('Most Ordered',style: Style.bottomText),
        ),
        new BottomNavigationBarItem(
            icon: Icon(Icons.star_half, color: Colors.blue,),
            title: Text('Most Shared',style: Style.bottomText)
        )
      ],
    );
  }



  void onTabTapped(int index) {
    setState(() {
      _currentBottomTabIndex = index;
    });
    Navigator.push(context,
        PageTransition(
          child: PopularProductList(_currentBottomTabIndex,this.allProductData),
          type: PageTransitionType.rightToLeft,
          duration: Duration(milliseconds: 500),
        ));
  }

  void onProductDetail(Categories categories) {
    Navigator.push(context,
        PageTransition(
          child: ProductListPage(categories),
          type: PageTransitionType.rightToLeft,
          duration: Duration(milliseconds: 500),
        ));
  }

  void onSubProductPage(List<int> childCategories, String categoryName) {
    Navigator.push(context,
        PageTransition(
          child: ProductSubcategoryPage(childCategories,categoryName),
          type: PageTransitionType.rightToLeft,
          duration: Duration(milliseconds: 500),
        ));
  }

}
