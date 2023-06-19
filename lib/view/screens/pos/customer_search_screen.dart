

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_vendor_app/data/model/response/customer_model.dart';
import 'package:sixvalley_vendor_app/localization/language_constrants.dart';
import 'package:sixvalley_vendor_app/provider/cart_provider.dart';
import 'package:sixvalley_vendor_app/provider/coupon_provider.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/utill/images.dart';
import 'package:sixvalley_vendor_app/utill/styles.dart';
import 'package:sixvalley_vendor_app/view/base/custom_app_bar.dart';
import 'package:sixvalley_vendor_app/view/base/custom_divider.dart';
import 'package:sixvalley_vendor_app/view/base/custom_search_field.dart';
import 'package:sixvalley_vendor_app/view/base/no_data_screen.dart';

class CustomerSearchScreen extends StatefulWidget {
  final bool isCoupon;
  const CustomerSearchScreen({Key? key, this.isCoupon = false}) : super(key: key);

  @override
  State<CustomerSearchScreen> createState() => _CustomerSearchScreenState();
}

class _CustomerSearchScreenState extends State<CustomerSearchScreen> {

  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: getTranslated('search_customer', context),),
      body: Column(children: [
        SizedBox(height: 85,
          child: Consumer<CartProvider>(
            builder: (context, customerProvider, _) {
              return Consumer<CouponProvider>(
                builder: (context, couponProvider,_) {
                  return Container(
                    color: Theme.of(context).cardColor,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeDefault, Dimensions.paddingSizeDefault, Dimensions.paddingSizeDefault, Dimensions.paddingSizeDefault),
                      child: CustomSearchField(
                        controller: searchController,
                        hint: getTranslated('search', context),
                        prefix: Images.iconsSearch,
                        iconPressed: () => (){},
                        onSubmit: (text) => (){},
                        onChanged: (value){
                          if(value.toString().isNotEmpty){
                            if(widget.isCoupon){
                              couponProvider.getCouponCustomerList(context,value);
                            }else{
                              customerProvider.searchCustomer(context,value);
                            }

                          }

                        },

                      ),
                    ),
                  );
                }
              );
            }
        ),),

        Expanded(
          child: Consumer<CouponProvider>(
            builder: (context, couponProvider, _) {
              return Consumer<CartProvider>(
                  builder: (context, customerProvider, child) {
                    List<Customers>? customerList;
                    if(widget.isCoupon){
                      customerList = couponProvider.couponCustomerList;
                    }else{
                      customerList = customerProvider.searchedCustomerList;
                    }

                    return customerList!.isNotEmpty?
                    ListView.builder(
                        itemCount: customerList.length,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (ctx,index){
                          return InkWell(
                            onTap: (){
                              if(widget.isCoupon){
                                couponProvider.setCustomerInfo(customerList![index].id,
                                    '${customerList[index].fName} ${customerList[index].lName}',
                                    true);
                                couponProvider.searchCustomerController.text = '${customerList[index].fName??''} ${customerList[index].lName??''}';
                              }else{
                                customerProvider.setCustomerInfo(customerList![index].id,
                                    '${customerList[index].fName} ${customerList[index].lName}',
                                    customerProvider.searchedCustomerList![index].phone, true);
                                customerProvider.searchCustomerController.text = '${customerList[index].fName} ${customerList[index].lName}';
                              }

                              Navigator.pop(context);
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                              child: Container(
                                  padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
                                  child: Column(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('${customerList![index].fName} ${customerList[index].lName}',
                                          style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeDefault)),
                                      const SizedBox(height: Dimensions.paddingSizeMedium,),
                                      CustomDivider(height: .5,color: Theme.of(context).hintColor),
                                    ],
                                  )),
                            ),
                          );

                        }):const NoDataScreen();
                  }
              );
            }
          ),
        )

      ],)

    );
  }
}
