
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_vendor_app/data/model/response/product_model.dart';
import 'package:sixvalley_vendor_app/localization/language_constrants.dart';
import 'package:sixvalley_vendor_app/provider/localization_provider.dart';
import 'package:sixvalley_vendor_app/provider/product_provider.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/utill/images.dart';
import 'package:sixvalley_vendor_app/view/base/no_data_screen.dart';
import 'package:sixvalley_vendor_app/view/base/product_widget.dart';
import 'package:sixvalley_vendor_app/view/base/title_row.dart';
import 'package:sixvalley_vendor_app/view/screens/refund/refund_screen.dart';
import 'package:sixvalley_vendor_app/view/screens/stockOut/stock_out_product_screen.dart';
import 'package:sixvalley_vendor_app/view/screens/stockOut/widget/stockout_product_card.dart';


class StockOutProductView extends StatelessWidget {
  final bool isHome;
  final ScrollController? scrollController;
  const StockOutProductView({Key? key,  required this.isHome, this.scrollController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();
    scrollController.addListener(() {
      if(scrollController.position.maxScrollExtent == scrollController.position.pixels
          && Provider.of<ProductProvider>(context, listen: false).stockOutProductList.isNotEmpty
          && !Provider.of<ProductProvider>(context, listen: false).isLoading) {
        int pageSize;
        pageSize = (Provider.of<ProductProvider>(context, listen: false).stockOutProductPageSize!/10).ceil();

        if(Provider.of<ProductProvider>(context, listen: false).offset < pageSize) {
          Provider.of<ProductProvider>(context, listen: false).setOffset(Provider.of<ProductProvider>(context, listen: false).offset+1);
          if (kDebugMode) {
            print('end of the page');
          }
          Provider.of<ProductProvider>(context, listen: false).showBottomLoader();

          Provider.of<ProductProvider>(context, listen: false).getStockOutProductList(
              Provider.of<ProductProvider>(context, listen: false).
              offset, Provider.of<LocalizationProvider>(context, listen: false).locale.languageCode == 'US'?
          'en':Provider.of<LocalizationProvider>(context, listen: false).locale.countryCode!.toLowerCase());

        }
      }
    });


    return Consumer<ProductProvider>(
      builder: (context, prodProvider, child) {
        List<Product> productList;
        productList = prodProvider.stockOutProductList;


        return Column(children: [

          isHome && productList.isNotEmpty ?
          Padding(
            padding: const EdgeInsets.symmetric(horizontal : Dimensions.paddingSizeDefault,
                vertical: Dimensions.paddingSizeSmall),
            child: Row(
              children: [
                SizedBox(width: Dimensions.iconSizeDefault, child: Image.asset(Images.limitedStockIcon)),
                const SizedBox(width: Dimensions.paddingSizeExtraSmall),
                Expanded(
                  child: TitleRow(title: '${getTranslated('stock_out_product', context)}',
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const StockOutProductScreen()))),
                ),
              ],
            ),
          ):const SizedBox(),

          !prodProvider.isLoading ? productList.isNotEmpty ?
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
              child: isHome? ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: productList.length,
                  itemBuilder: (ctx,index){
                    return ProductWidget(productModel: productList[index]);

                  }) :
              ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                  itemCount: productList.length,
                  itemBuilder: (ctx,index){
                    return StockOutProductWidget(productModel: productList[index]);

        })),
          ): const Expanded(child: NoDataScreen()) :const Expanded(child: OrderShimmer()),

          prodProvider.isLoading ? Center(child: Padding(
            padding: const EdgeInsets.all(Dimensions.iconSizeExtraSmall),
            child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor)),
          )) : const SizedBox.shrink(),

        ]);
      },
    );
  }
}


