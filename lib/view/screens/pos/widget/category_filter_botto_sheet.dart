

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_vendor_app/data/model/response/category_model.dart';
import 'package:sixvalley_vendor_app/localization/language_constrants.dart';
import 'package:sixvalley_vendor_app/provider/product_provider.dart';
import 'package:sixvalley_vendor_app/provider/shop_provider.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/utill/styles.dart';
import 'package:sixvalley_vendor_app/view/base/custom_button.dart';
import 'package:sixvalley_vendor_app/view/base/custom_snackbar.dart';

class CategoryFilterBottomSheet extends StatelessWidget {
  const CategoryFilterBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<SellerProvider>(
      builder: (context, categoryProvider, _) {
        List<CategoryModel>? categoryList =[];
        categoryList = categoryProvider.categoryList;
        return Stack(
          children: [
            Container(
              padding: const EdgeInsets.only(top: Dimensions.paddingSizeDefault, bottom: 60),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(Dimensions.paddingSizeSmall),
                    topRight: Radius.circular(Dimensions.paddingSizeSmall),
                )
              ),
              child: Column(mainAxisSize: MainAxisSize.min,
                children: [
                  Text(getTranslated('category_wise_filter', context)!, style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeLarge),),
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: categoryList!.length,
                      itemBuilder: (context, index){
                        return Row(children: [
                          Checkbox(value: categoryProvider.selectedCategory[index],
                              onChanged: (onChanged){
                                categoryProvider.setSelectedCategoryForFilter(index, onChanged);
                              }),
                          Text(categoryList![index].name!),
                        ],);
                      }),
                ],
              ),
            ),
            Consumer<ProductProvider>(
              builder: (context, productProvider, _) {
                List<String> ids = [];
                return Positioned(bottom: 10,left: 10,right: 10,
                    child: CustomButton(btnTxt: getTranslated('search', context),
                      onTap: (){

                        if(categoryProvider.selectedCategory.isNotEmpty){
                          for(int i=0; i< categoryProvider.selectedCategory.length; i++){
                            if(categoryProvider.selectedCategory[i]!){
                              ids.add(categoryList![i].id.toString());
                            }
                          }
                          Navigator.pop(context);
                          productProvider.getSearchedPosProductList(context, '', ids, filter: true);
                        }else{
                          showCustomSnackBar(getTranslated('please_select_a_category_to_filter', context), context, isToaster: true);
                        }

                    },));
              }
            )
          ],
        );
      }
    );
  }
}
