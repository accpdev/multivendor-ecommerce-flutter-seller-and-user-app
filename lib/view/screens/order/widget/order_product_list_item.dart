import 'dart:io';
import 'dart:isolate';
import 'dart:ui';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_vendor_app/data/model/response/order_details_model.dart';
import 'package:sixvalley_vendor_app/data/model/response/order_model.dart';
import 'package:sixvalley_vendor_app/helper/price_converter.dart';
import 'package:sixvalley_vendor_app/localization/language_constrants.dart';
import 'package:sixvalley_vendor_app/provider/auth_provider.dart';
import 'package:sixvalley_vendor_app/provider/order_provider.dart';
import 'package:sixvalley_vendor_app/provider/shop_provider.dart';
import 'package:sixvalley_vendor_app/provider/splash_provider.dart';
import 'package:sixvalley_vendor_app/utill/color_resources.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/utill/images.dart';
import 'package:sixvalley_vendor_app/utill/styles.dart';
import 'package:sixvalley_vendor_app/view/base/custom_snackbar.dart';
import 'package:url_launcher/url_launcher.dart';


class OrderedProductListItem extends StatefulWidget {
  final OrderDetailsModel? orderDetailsModel;
  final String? paymentStatus;
  final OrderModel? orderModel;
  final int? orderId;
  final int? index;
  final int? length;
  const OrderedProductListItem({Key? key, this.orderDetailsModel, this.paymentStatus, this.orderModel, this.orderId, this.index, this.length}) : super(key: key);

  @override
  State<OrderedProductListItem> createState() => _OrderedProductListItemState();
}

class _OrderedProductListItemState extends State<OrderedProductListItem> {
  final ReceivePort _port = ReceivePort();

  @override
  void initState() {
    super.initState();
    IsolateNameServer.registerPortWithName(_port.sendPort, 'downloader_send_port');
    _port.listen((dynamic data) {
    });
    FlutterDownloader.registerCallback(downloadCallback);
  }

  @override
  void dispose() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    super.dispose();
  }

  @pragma('vm:entry-point')
  static void downloadCallback(String id, DownloadTaskStatus status, int progress) {
    final SendPort send = IsolateNameServer.lookupPortByName('downloader_send_port')!;
    send.send([id, status, progress]);
  }
  PlatformFile? fileNamed;
  File? file;
  int?  fileSize;
  @override
  Widget build(BuildContext context) {
    return  widget.orderDetailsModel!.productDetails != null?
    Column( children: [
      Row(mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: Dimensions.imageSize,
          width: Dimensions.imageSize, child: ClipRRect(
            borderRadius: BorderRadius.circular(10),

            child: FadeInImage.assetNetwork(
              imageErrorBuilder: (c, o, s) => Image.asset(Images.placeholderImage, fit: BoxFit.cover,),
              placeholder: Images.placeholderImage,
              image: '${Provider.of<SplashProvider>(context, listen: false).baseUrls!.productThumbnailUrl}/'
                  '${widget.orderDetailsModel!.productDetails?.thumbnail}',
              height: Dimensions.imageSize, width: Dimensions.imageSize,
              fit: BoxFit.cover,),),),
          const SizedBox(width: Dimensions.paddingSizeDefault),


          Expanded(
            child: Column(crossAxisAlignment:CrossAxisAlignment.start, children: [
              Text(widget.orderDetailsModel!.productDetails?.name??'',
                style: titilliumSemiBold.copyWith(fontSize: Dimensions.fontSizeDefault,
                    color: ColorResources.getTextColor(context)),
                maxLines: 1, overflow: TextOverflow.ellipsis,),
              const SizedBox(height: Dimensions.paddingSizeExtraSmall),


              Row( children: [
                (widget.orderDetailsModel!.productDetails!.discount! > 0 &&
                    widget.orderDetailsModel!.productDetails!.discount!= null)?
                Text(PriceConverter.convertPrice(context,
                    widget.orderDetailsModel!.productDetails!.unitPrice!.toDouble()),
                  style: titilliumRegular.copyWith(color: ColorResources.mainCardFourColor(context),fontSize: Dimensions.fontSizeSmall,
                      decoration: TextDecoration.lineThrough),):const SizedBox(),
                SizedBox(width: widget.orderDetailsModel!.productDetails!.discount! > 0?
                Dimensions.paddingSizeDefault : 0),



                Text(PriceConverter.convertPrice(context,
                    widget.orderDetailsModel!.productDetails!.unitPrice!.toDouble(),
                    discount :widget.orderDetailsModel!.productDetails!.discount,
                    discountType :widget.orderDetailsModel!.productDetails!.discountType),
                  style: titilliumSemiBold.copyWith(color: Theme.of(context).primaryColor),),


              ],),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Text('[${getTranslated('tax', context)} ${widget.orderDetailsModel!.productDetails!.taxModel}(${widget.orderDetailsModel!.tax})]',style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall),),
              ),

              const SizedBox(height: Dimensions.paddingSizeExtraSmall),

              (widget.orderDetailsModel!.variant != null && widget.orderDetailsModel!.variant!.isNotEmpty) ?
              Padding(padding: const EdgeInsets.only(top: Dimensions.paddingSizeExtraSmall),
                child: Text(widget.orderDetailsModel!.variant!,
                    style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall,
                      color: Theme.of(context).disabledColor,)),) : const SizedBox(),
              const SizedBox(height: Dimensions.paddingSizeExtraSmall),

              Row(children: [
                Text(getTranslated('qty', context)!,
                    style: titilliumRegular.copyWith(color: Theme.of(context).hintColor)),

                Text(': ${widget.orderDetailsModel!.qty}',
                    style: titilliumRegular.copyWith(color: ColorResources.getTextColor(context))),],),




            ],),
          ),

        ],
      ),


      SizedBox(height: widget.orderDetailsModel!.productDetails!.productType =='digital'?
      Dimensions.paddingSizeSmall : 0),
      widget.orderDetailsModel!.productDetails!.productType =='digital' ?
      Consumer<OrderProvider>(
          builder: (context, orderProvider, _) {
            return Row(mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: InkWell(
                    onTap : () async {
                      if(widget.orderDetailsModel!.productDetails!.digitalProductType == 'ready_after_sell' &&
                          widget.orderDetailsModel!.digitalFileAfterSell == null ){
                        showCustomSnackBar(getTranslated('product_not_uploaded_yet', context), context, isToaster: true);

                      }else{
                        widget.orderDetailsModel!.productDetails!.digitalProductType == 'ready_after_sell'?
                        _launchUrl(Uri.parse('${Provider.of<SplashProvider>(context, listen: false).baseUrls!.digitalProductUrl}/${widget.orderDetailsModel!.digitalFileAfterSell}')):
                        _launchUrl(Uri.parse('${Provider.of<SplashProvider>(context, listen: false).baseUrls!.digitalProductUrl}/${widget.orderDetailsModel!.productDetails!.digitalFileReady}'));
                      }

                    },
                    child: Container(
                      padding: const EdgeInsets.only(left: 5),
                      height: 38,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Dimensions.fontSizeExtraSmall),
                          color: Theme.of(context).primaryColor
                      ),
                      alignment: Alignment.center,
                      child: Center(child: Row(mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('${getTranslated('download', context)}',
                            style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall,color: Colors.white)),
                          const SizedBox(width: Dimensions.paddingSizeSmall),
                          SizedBox(width: Dimensions.iconSizeDefault,
                              child: Image.asset(Images.downloadFile, color: Colors.white))
                        ],
                      )),
                    ),
                  ),
                ),
                const SizedBox(width: Dimensions.paddingSizeDefault),
                widget.orderDetailsModel!.productDetails!.digitalProductType == 'ready_after_sell'?
                Expanded(
                  child: Column(children: [
                    InkWell(
                      onTap: ()async{
                        FilePickerResult? result = await FilePicker.platform.pickFiles(
                          type: FileType.custom,
                          allowedExtensions: ['pdf', 'zip', 'jpg', 'png', "jpeg", "gif"],
                        );
                        if (result != null) {
                          file = File(result.files.single.path!);
                          fileSize = await file!.length();
                          fileNamed = result.files.first;
                          orderProvider.setSelectedFileName(file);

                        } else {

                        }
                      },
                      child: Builder(
                          builder: (context) {
                            return Column(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                widget.orderDetailsModel!.digitalFileAfterSell != null && fileNamed == null?
                                Text(widget.orderDetailsModel!.digitalFileAfterSell!, maxLines: 2,overflow: TextOverflow.ellipsis,
                                    style: robotoRegular.copyWith()):
                                Text(fileNamed != null? fileNamed?.name??'':'',maxLines: 2,overflow: TextOverflow.ellipsis,
                                    style: robotoRegular.copyWith()),
                                fileNamed == null?
                                Container(
                                  padding: const EdgeInsets.only(left: 5),
                                  height: 38,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(Dimensions.fontSizeExtraSmall),

                                      color: Theme.of(context).primaryColor
                                  ),
                                  alignment: Alignment.center,
                                  child: Center(child: Row(mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('${getTranslated('choose_file', context)}',
                                        style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color:Colors.white),),
                                      const SizedBox(width: Dimensions.paddingSizeSmall),
                                      RotatedBox(
                                        quarterTurns:2,
                                        child: SizedBox(width: Dimensions.iconSizeDefault,
                                            child: Image.asset(Images.downloadFile, color : Colors.white)),
                                      )
                                    ],
                                  )),
                                ):const SizedBox(),

                              ],);
                          }
                      ),
                    ),

                    fileNamed != null?
                    InkWell(
                      onTap:(){
                        Provider.of<SellerProvider>(context, listen: false).uploadReadyAfterSellDigitalProduct(context, orderProvider.selectedFileForImport,
                            Provider.of<AuthProvider>(context, listen: false).getUserToken(), widget.orderDetailsModel!.id.toString());
                        },
                      child: Container(
                        height: 38,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(Dimensions.fontSizeExtraSmall),

                            color: Theme.of(context).primaryColor
                        ),
                        alignment: Alignment.center,
                        child: Center(child: Row(mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('${getTranslated('upload', context)}',
                              style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall,color: Theme.of(context).cardColor),),
                            const SizedBox(width: Dimensions.paddingSizeSmall),
                            RotatedBox(
                              quarterTurns:2,
                              child: SizedBox(width: Dimensions.iconSizeDefault,
                                  child: Image.asset(Images.downloadFile, color: Theme.of(context).cardColor,)),
                            )
                          ],
                        )),
                      ),
                    ):const SizedBox(),
                  ],),
                ):const SizedBox()
              ],
            );
          }
      ) : const SizedBox(),

      widget.length!> widget.index!?
      const Padding(
        padding: EdgeInsets.only(top: Dimensions.paddingSizeSmall),
        child: Divider(),
      ):const SizedBox(),


    ],
    ) : const SizedBox();
  }
}


Future<void> _launchUrl(Uri url) async {
  if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
    throw 'Could not launch $url';
  }
}