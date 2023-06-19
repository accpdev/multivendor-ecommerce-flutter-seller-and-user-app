import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_vendor_app/data/model/response/product_model.dart';
import 'package:sixvalley_vendor_app/helper/price_converter.dart';
import 'package:sixvalley_vendor_app/localization/language_constrants.dart';
import 'package:sixvalley_vendor_app/provider/localization_provider.dart';
import 'package:sixvalley_vendor_app/provider/product_provider.dart';
import 'package:sixvalley_vendor_app/provider/profile_provider.dart';
import 'package:sixvalley_vendor_app/provider/shop_provider.dart';
import 'package:sixvalley_vendor_app/provider/splash_provider.dart';
import 'package:sixvalley_vendor_app/utill/color_resources.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/utill/images.dart';
import 'package:sixvalley_vendor_app/utill/styles.dart';
import 'package:sixvalley_vendor_app/view/base/confirmation_dialog.dart';
import 'package:sixvalley_vendor_app/view/base/custom_image.dart';
import 'package:sixvalley_vendor_app/view/base/image_diaglog.dart';
import 'package:sixvalley_vendor_app/view/screens/addProduct/add_product_screen.dart';
import 'package:sixvalley_vendor_app/view/screens/product/product_details.dart';



class ShopProductWidget extends StatefulWidget {
  final Product? productModel;
  final bool isDetails;
  const ShopProductWidget({Key? key, required this.productModel, this.isDetails = false}) : super(key: key);

  @override
  State<ShopProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ShopProductWidget> {
  var renderOverlay = true;
  var visible = true;
  var switchLabelPosition = false;
  var extend = false;
  var mini = false;
  var customDialRoot = false;
  var closeManually = false;
  var useRAnimation = true;
  var isDialOpen = ValueNotifier<bool>(false);
  var speedDialDirection = SpeedDialDirection.left;
  var buttonSize = const Size(35.0, 35.0);
  var childrenButtonSize = const Size(45.0, 45.0);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    String? baseUrl = Provider.of<SplashProvider>(context, listen: false).baseUrls!.productImageUrl;
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeSmall),
          child: GestureDetector(
            onTap:  widget.isDetails? null: ()=> Navigator.push(context, MaterialPageRoute(builder: (_)=> ProductDetailsScreen(productModel: widget.productModel))),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeMedium, vertical: Dimensions.paddingSizeSmall),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                boxShadow: [BoxShadow(color: Theme.of(context).primaryColor.withOpacity(.05),
                    spreadRadius: 1, blurRadius: 1, offset: const Offset(1,2))],
              ),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: Dimensions.paddingSizeSmall),
                        child: Column(
                          children: [
                            Container(decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor.withOpacity(.10),
                              borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),),
                              width: 100,
                              height: 100,
                              child: ClipRRect(borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
                                child: CustomImage(image: '${Provider.of<SplashProvider>(context, listen: false).
                                baseUrls!.productThumbnailUrl}/${widget.productModel?.thumbnail}'))),
                            const SizedBox(height: Dimensions.paddingSizeExtraSmall),
                            widget.isDetails?const SizedBox():
                            Text(getTranslated(widget.productModel?.productType, context)!, style: robotoRegular.copyWith(color: Theme.of(context).primaryColor),),
                          ],
                        ),
                      ),
                      const SizedBox(width: Dimensions.paddingSizeSmall,),


                      Expanded(flex: 6,
                        child: Padding(padding: const EdgeInsets.all(8.0),
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            Padding(
                              padding: EdgeInsets.only(right: Provider.of<LocalizationProvider>(context, listen: false).isLtr? 30:0,
                                left: Provider.of<LocalizationProvider>(context, listen: false).isLtr? 0:30,
                              ),
                              child: Text(widget.productModel!.name ?? '', style: robotoRegular.copyWith(color: ColorResources.titleColor(context)),
                                maxLines: 2, overflow: TextOverflow.ellipsis),
                            ),
                            const SizedBox(height: Dimensions.paddingSizeSmall),

                            Container(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall,vertical: Dimensions.paddingSizeExtraSmall),
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall),
                                    color: widget.productModel!.requestStatus == 0? ColorResources.colombiaBlue :
                                    widget.productModel!.requestStatus == 1? ColorResources.green : ColorResources.getRed(context)),
                                child: Text(widget.productModel!.requestStatus == 0? '${getTranslated('new_request', context)}':
                                widget.productModel!.requestStatus == 1? '${getTranslated('approved', context)}' : '${getTranslated('denied', context)}',
                                    style: robotoRegular.copyWith(color: Colors.white),
                                    maxLines: 1, overflow: TextOverflow.ellipsis)),
                            const SizedBox(height: Dimensions.paddingSizeSmall),

                            widget.isDetails && widget.productModel!.images != null?
                            SizedBox(height: Dimensions.productImageSize,
                              child: ListView.builder(
                                itemCount: widget.productModel!.images?.length,
                                shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index){
                                return GestureDetector(
                                  onTap: (){
                                    showDialog(context: context, builder: (_){
                                      return ImageDialog(imageUrl: '$baseUrl/${widget.productModel!.images![index]}');
                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraSmall),
                                    child: Container(decoration: BoxDecoration(
                                      color: Theme.of(context).cardColor,
                                    ),
                                    width: Dimensions.productImageSize,height: Dimensions.imageSize,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall),
                                          child: CustomImage(image: '$baseUrl/${widget.productModel!.images![index]}',
                                            width: Dimensions.productImageSize,height: Dimensions.productImageSize,),
                                        )),
                                  ),
                                );
                            }),):
                            Column(children: [
                              Row(children: [
                                Text('${getTranslated('purchase_price', context)} : ',
                                  style: robotoRegular.copyWith(color: Theme.of(context).hintColor),),

                                Text(PriceConverter.convertPrice(context, widget.productModel!.purchasePrice),
                                  style: robotoMedium.copyWith(color: ColorResources.titleColor(context)),)]),
                              const SizedBox(height: Dimensions.paddingSizeExtraSmall),

                              Row(children: [
                                Text('${getTranslated('selling_price', context)} : ',
                                  style: robotoRegular.copyWith(color: Theme.of(context).hintColor),),
                                Text(PriceConverter.convertPrice(context, widget.productModel!.unitPrice,
                                    discountType: widget.productModel!.discountType, discount: widget.productModel!.discount),
                                    style: robotoMedium.copyWith(color: ColorResources.titleColor(context)))]),
                            ],)
                        ],),
                      ),
                      ),
                    ],),

                  widget.isDetails && widget.productModel!.deniedNote != null?
                  Padding(
                    padding: const EdgeInsets.only(top: Dimensions.paddingSizeExtraSmall),
                    child: Row(crossAxisAlignment: CrossAxisAlignment.start,children: [
                      Text('${getTranslated('note', context)}: ',
                          style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).primaryColor)),

                      Expanded(
                        child: Text( widget.productModel!.deniedNote!,overflow: TextOverflow.ellipsis,
                            maxLines: 50,
                            style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeDefault)),
                      ),
                    ],),
                  ):const SizedBox.shrink(),
                ],
              ),
            ),
          ),
        ),
        extend?
        Align(alignment: Provider.of<LocalizationProvider>(context, listen: false).isLtr? Alignment.topRight:Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Container(width: 150,height: 50,
                decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    boxShadow: [BoxShadow(color: Theme.of(context).hintColor,
                        spreadRadius: .1, blurRadius: .2, offset: Offset.fromDirection(2,1))],
                    borderRadius: BorderRadius.circular(Dimensions.iconSizeExtraLarge)
                ),
              ),
            )):const SizedBox(),
        !widget.isDetails?
        Align(
          alignment: Provider.of<LocalizationProvider>(context, listen: false).isLtr? Alignment.topRight:Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: SpeedDial(
              overlayOpacity: 0,
              icon: Icons.more_horiz,
              activeIcon: Icons.close,
              spacing: 3,
              mini: mini,
              openCloseDial: isDialOpen,
              childPadding: const EdgeInsets.all(5),
              spaceBetweenChildren: 4,
              buttonSize: buttonSize,
              childrenButtonSize: childrenButtonSize,
              visible: visible,
              direction: speedDialDirection,
              switchLabelPosition: switchLabelPosition,
              closeManually: false,
              renderOverlay: renderOverlay,
              useRotationAnimation: useRAnimation,
              backgroundColor: Theme.of(context).cardColor,
              foregroundColor: Theme.of(context).disabledColor,
              elevation: extend? 0: 8.0,
              animationCurve: Curves.elasticInOut,
              isOpenOnStart: false,
              shape: customDialRoot ? const RoundedRectangleBorder() : const StadiumBorder(),
              onOpen: () {
                setState(() {
                  extend = true;
                });
              },
              onClose: () {
                setState(() {
                  extend = false;
                });
              },

              children: [
                SpeedDialChild(
                  elevation: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(Images.editIcon),
                  ),

                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) => AddProductScreen(product: widget.productModel)));
                  },
                ),
                SpeedDialChild(
                  elevation: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(Images.delete),
                  ),

                  onTap: () {
                    showDialog(context: context, builder: (BuildContext context){
                      return ConfirmationDialog(icon: Images.deleteProduct,
                          refund: false,
                          description: getTranslated('are_you_sure_want_to_delete_this_product', context),
                          onYesPressed: () {
                            Provider.of<SellerProvider>(context, listen:false).deleteProduct(context ,widget.productModel!.id).then((value) {
                              Provider.of<ProductProvider>(context,listen: false).getStockOutProductList(1, 'en');
                              Provider.of<ProductProvider>(context, listen: false).initSellerProductList(Provider.of<ProfileProvider>(context, listen: false).
                              userInfoModel!.id.toString(), 1, context, 'en','', reload: true);
                            });
                          }

                      );});
                  },
                ),

              ],
            ),
          ),
        ):const SizedBox()
      ],
    );
  }
}
