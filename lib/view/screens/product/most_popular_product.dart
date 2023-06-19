import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_vendor_app/data/model/response/product_model.dart';
import 'package:sixvalley_vendor_app/localization/language_constrants.dart';
import 'package:sixvalley_vendor_app/provider/product_provider.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/utill/images.dart';
import 'package:sixvalley_vendor_app/view/base/no_data_screen.dart';
import 'package:sixvalley_vendor_app/view/base/title_row.dart';
import 'package:sixvalley_vendor_app/view/screens/product/product_list_view_screen.dart';
import 'package:sixvalley_vendor_app/view/screens/product/widget/top_most_product_card.dart';

class MostPopularProductScreen extends StatelessWidget {
  final bool isMain;
  const MostPopularProductScreen({Key? key, this.isMain = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async{
        Provider.of<ProductProvider>(context,listen: false).getMostPopularProductList(1, context, 'en');
      },
      child: Consumer<ProductProvider>(
        builder: (context, prodProvider, child) {
          List<Product> productList;
          productList = prodProvider.mostPopularProductList;


          return Column(mainAxisSize: MainAxisSize.min, children: [

            isMain?
            Padding(
              padding: const EdgeInsets.fromLTRB( Dimensions.paddingSizeDefault,
                   Dimensions.paddingSizeLarge, Dimensions.paddingSizeDefault, 0,),
              child: Row(
                children: [
                  SizedBox(width: Dimensions.iconSizeDefault, child: Image.asset(Images.popularProductIcon)),
                  const SizedBox(width: Dimensions.paddingSizeExtraSmall),
                  Expanded(
                    child: TitleRow(color: Colors.white, title: '${getTranslated('most_popular_products', context)}',
                        isPopular: true,
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ProductListScreen(isPopular: true, title: 'most_popular_products')))),
                  ),
                ],
              ),
            ):const SizedBox(),

            !prodProvider.isLoading ? productList.isNotEmpty ?
            Padding(
              padding: const EdgeInsets.symmetric(horizontal : Dimensions.paddingSizeSmall,
                  vertical: Dimensions.paddingSizeSmall),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 9,
                  crossAxisSpacing: 5,
                  childAspectRatio: MediaQuery.of(context).size.width < 400? 1/1.20 :MediaQuery.of(context).size.width < 415? 1/1.23: 1/1.23,
                ),
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: isMain && productList.length >4? 4 : productList.length,
                itemBuilder: (context, index) {

                  return TopMostProductWidget(productModel: productList[index], isPopular: true);
                },
              ),
            ): Padding(padding: EdgeInsets.only(top: isMain ? 0.0 :MediaQuery.of(context).size.height/3),
              child: const NoDataScreen(title: 'no_product_found',color: Colors.white,),
            ) :const SizedBox.shrink(),

            prodProvider.isLoading ? Center(child: Padding(
              padding: const EdgeInsets.all(Dimensions.iconSizeExtraSmall),
              child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor)),
            )) : const SizedBox.shrink(),

          ]);
        },
      ),
    );
  }
}
