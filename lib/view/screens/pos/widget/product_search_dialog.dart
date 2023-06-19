import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_vendor_app/provider/product_provider.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/view/screens/pos/widget/searched_product_item_widget.dart';
class ProductSearchDialog extends StatelessWidget {
  const ProductSearchDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(builder: (context, searchedProductController,_){
      return searchedProductController.posProductList.isNotEmpty?
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraLarge),
        child: Container(height: 400,
          padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
          decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
              boxShadow: [BoxShadow(color: Theme.of(context).primaryColor.withOpacity(.125),
                  spreadRadius: .5, blurRadius: 12, offset: const Offset(3,5))]

          ),
          child: ListView.builder(
              itemCount: searchedProductController.posProductList.length,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (ctx,index){
                return SearchedProductItemWidget(product: searchedProductController.posProductList[index]);

              }),
        ),
      ):const SizedBox.shrink();
    });
  }
}
