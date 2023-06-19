
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_vendor_app/data/model/response/product_model.dart';
import 'package:sixvalley_vendor_app/localization/language_constrants.dart';
import 'package:sixvalley_vendor_app/provider/shop_provider.dart';
import 'package:sixvalley_vendor_app/utill/color_resources.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/utill/styles.dart';

class SelectCategoryWidget extends StatefulWidget {
  final Product? product;
  final ValueChanged<bool>? isSelected;
  const SelectCategoryWidget({Key? key, required this.product, this.isSelected}) : super(key: key);

  @override
  SelectCategoryWidgetState createState() => SelectCategoryWidgetState();
}

class SelectCategoryWidgetState extends State<SelectCategoryWidget> {
  bool isSelected = false;

  AutoCompleteTextField? searchTextField;


  GlobalKey<AutoCompleteTextFieldState<String>> key = GlobalKey();
  SimpleAutoCompleteTextField? textField;
  bool showWhichErrorText = false;
  String thumbnailImage ='', metaImage ='';
  List<String> productImage =[];
  int counter = 0, total = 0;


  @override
  Widget build(BuildContext context) {
    return Consumer<SellerProvider>(
      builder: (context, resProvider, child){
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Row(
              children: [
                Text(getTranslated('select_category', context)!,style: robotoRegular.copyWith(
                    color: ColorResources.titleColor(context),
                    fontSize: Dimensions.fontSizeDefault)),
                Text('*',style: robotoBold.copyWith(color: ColorResources.mainCardFourColor(context),
                    fontSize: Dimensions.fontSizeDefault),),
              ],
            ),
            const SizedBox(height: Dimensions.paddingSizeExtraSmall),


            Container(padding: const EdgeInsets.symmetric(horizontal:Dimensions.paddingSizeSmall),
              decoration: BoxDecoration(color: Theme.of(context).cardColor,
                border: Border.all(width: .5, color: Theme.of(context).hintColor.withOpacity(.7)),
                borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall)),
              child: DropdownButton<int>(
                value: resProvider.categoryIndex,
                items: resProvider.categoryIds.map((int? value) {
                  return DropdownMenuItem<int>(
                    value: resProvider.categoryIds.indexOf(value),
                    child: Text( value != 0?
                    resProvider.categoryList![(resProvider.categoryIds.indexOf(value) -1)].name!:
                    getTranslated('select', context)!),);}).toList(),
                onChanged: (int? value) {
                  resProvider.setCategoryIndex(value, true);
                  resProvider.getSubCategoryList(context, value != 0 ?
                  resProvider.categorySelectedIndex : 0, true, widget.product);},
                isExpanded: true, underline: const SizedBox(),),),
            const SizedBox(height: Dimensions.paddingSizeSmall),

            Row(children: [
              Flexible(child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(getTranslated('sub_category', context)!,style: robotoRegular.copyWith(
                      color: ColorResources.titleColor(context),
                      fontSize: Dimensions.fontSizeDefault)),
                const SizedBox(height: Dimensions.paddingSizeExtraSmall,),

                Container(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
                  decoration: BoxDecoration(color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall),
                    border: Border.all(width: .5, color: Theme.of(context).hintColor.withOpacity(.7)),),
                  child: DropdownButton<int>(
                    value: resProvider.subCategoryIndex,
                    items: resProvider.subCategoryIds.map((int? value) {
                      return DropdownMenuItem<int>(
                        value: resProvider.subCategoryIds.indexOf(value),
                        child: Text(value != 0 ?
                        resProvider.subCategoryList![(resProvider.subCategoryIds.indexOf(value) - 1)].name! :
                        getTranslated('select', context)!),
                      );}).toList(),
                    onChanged: (int? value) {
                      resProvider.setSubCategoryIndex(value, true);
                      resProvider.getSubSubCategoryList( value != 0 ? resProvider.subCategorySelectedIndex : 0, true);
                      },
                    isExpanded: true,
                    underline: const SizedBox(),
                  ),
                ),
              ],),),
              const SizedBox(width: Dimensions.paddingSizeDefault),



              Flexible(child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(getTranslated('sub_sub_category', context)!, style: robotoRegular.copyWith(
                      color: ColorResources.titleColor(context),
                      fontSize: Dimensions.fontSizeDefault)),
                const SizedBox(height: Dimensions.paddingSizeSmall),


                Container(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
                  decoration: BoxDecoration(color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall),
                    border: Border.all(width: .5, color: Theme.of(context).hintColor.withOpacity(.7)),),
                  child: DropdownButton<int>(
                    value: resProvider.subSubCategoryIndex,
                    items: resProvider.subSubCategoryIds.map((int? value) {
                      return DropdownMenuItem<int>(
                        value: resProvider.subSubCategoryIds.indexOf(value),
                        child: Text(value != 0 ?
                        resProvider.subSubCategoryList![(resProvider.subSubCategoryIds.indexOf(value)-1)].name! :
                        getTranslated('select', context)!),
                      );}).toList(),
                    onChanged: (int? value) {
                      resProvider.setSubSubCategoryIndex(value, true);
                      },
                    isExpanded: true,
                    underline: const SizedBox(),
                  ),
                ),
              ],
              ),
              ),

            ],),
            const SizedBox(height: Dimensions.paddingSizeSmall),



          ],);
      },

    );
  }
}
