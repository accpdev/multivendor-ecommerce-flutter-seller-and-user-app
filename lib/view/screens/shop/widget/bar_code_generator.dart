
import 'dart:async';
import 'dart:io';
import 'dart:isolate';
import 'dart:ui';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_vendor_app/data/model/response/product_model.dart';
import 'package:sixvalley_vendor_app/helper/price_converter.dart';
import 'package:sixvalley_vendor_app/localization/language_constrants.dart';
import 'package:sixvalley_vendor_app/main.dart';
import 'package:sixvalley_vendor_app/provider/product_provider.dart';
import 'package:sixvalley_vendor_app/utill/app_constants.dart';
import 'package:sixvalley_vendor_app/utill/color_resources.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/utill/styles.dart';
import 'package:sixvalley_vendor_app/view/base/custom_app_bar.dart';
import 'package:sixvalley_vendor_app/view/base/custom_button.dart';
import 'package:sixvalley_vendor_app/view/base/custom_field_with_title.dart';
import 'package:sixvalley_vendor_app/view/base/custom_snackbar.dart';
import 'package:sixvalley_vendor_app/view/base/textfeild/custom_text_feild.dart';
import 'package:url_launcher/url_launcher.dart';


class BarCodeGenerateScreen extends StatefulWidget {
  final Product? product;
  const BarCodeGenerateScreen({Key? key, this.product}) : super(key: key);

  @override
  State<BarCodeGenerateScreen> createState() => _BarCodeGenerateScreenState();
}

class _BarCodeGenerateScreenState extends State<BarCodeGenerateScreen> {
  TextEditingController quantityController = TextEditingController();
  int barCodeQuantity = 4;
  final ReceivePort _port = ReceivePort();



  @override
  void initState() {
    super.initState();
    quantityController.text = '4';
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




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: getTranslated('bar_code_generator', context)),
      body: Consumer<ProductProvider>(
        builder: (context, barCodeController,_) {
          return Column(children: [
            Column(children: [
              Container(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault, vertical: Dimensions.paddingSizeDefault),
                child: Column(children: [



                Row(children: [
                  Text('${getTranslated('code', context)} : '),
                  Text('${widget.product!.code}', style: robotoRegular.copyWith(color: Theme.of(context).hintColor))],),



                Row(children: [
                  Text('${getTranslated('product_name', context)} : '),
                  Expanded(
                    child: Text('${widget.product!.name}', maxLines: 2,overflow: TextOverflow.ellipsis,
                        style: robotoRegular.copyWith(color: Theme.of(context).hintColor)),
                  )],),
              ],),),




              CustomFieldWithTitle(
                isSKU: true,
                limitSet: true,
                setLimitTitle: getTranslated('maximum_quantity_270', context),
                customTextField: CustomTextField(
                    isPhoneNumber: true,
                    controller: quantityController),
                title: '${getTranslated('qty', context)} (1-270)',
                requiredField: true,

              ),





              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
                const SizedBox(width: Dimensions.fontSizeSmall),
                Expanded(child: CustomButton(btnTxt: getTranslated('generate', context),
                onTap: (){
                  if(int.parse(quantityController.text)>270 || int.parse(quantityController.text) ==0){
                    showCustomSnackBar(getTranslated('please_enter_from_1_to_270', context), context);
                  }else{
                   barCodeController.setBarCodeQuantity(int.parse(quantityController.text));
                  }

                })),






                const SizedBox(width: Dimensions.fontSizeSmall),
                Expanded(child: CustomButton(btnTxt: getTranslated('download', context),
                    onTap : () async {
                      final status = await Permission.storage.request();
                      if(status.isGranted){
                        Directory directory = Directory('/storage/emulated/0/Download');
                        if (!await directory.exists()) {
                          directory = Platform.isAndroid
                            ? await (getExternalStorageDirectory() as FutureOr<Directory>)
                            : await getApplicationSupportDirectory();
                        }
                        barCodeController.barCodeDownload(Get.context!, widget.product!.id,int.parse( quantityController.text)).then((value) async {
                          // barCodeController.downloadFile(barCodeController.printBarCode,directory.path);
                          _launchUrl(Uri.parse(barCodeController.printBarCode!));
                        });

                      }else{
                        if (kDebugMode) {
                          print('=====permission denied=====');
                        }
                      }

                    })),





                const SizedBox(width: Dimensions.fontSizeSmall),
                Expanded(child: CustomButton(btnTxt: getTranslated('reset', context),onTap: (){
                  quantityController.text = '4';
                 barCodeController.setBarCodeQuantity(4);
                },
                backgroundColor: ColorResources.getRed(context),
                )),
                const SizedBox(width: Dimensions.fontSizeSmall),


              ],)
            ],),
            const SizedBox(height: Dimensions.paddingSizeDefault),








            Expanded(child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
              child: GridView.builder(
                itemCount: barCodeController.barCodeQuantity,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 15,
                    childAspectRatio: 1/1.2,
                  ), itemBuilder: (barcode, index){
                    return Column(
                      children: [
                        Text(AppConstants.companyName,
                          style: robotoBold.copyWith(fontSize: Dimensions.fontSizeDefault),),
                        Text('${widget.product!.name}', maxLines: 1,overflow: TextOverflow.ellipsis,
                          style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall),),
                        Text(PriceConverter.convertPrice(context, widget.product!.purchasePrice)),
                        BarcodeWidget(
                          data: 'code : ${widget.product!.code}',style: robotoRegular.copyWith(),
                          barcode: Barcode.code128(),
                        )],);
                }),
            ))
          ],);
        }
      ),
    );
  }

  Future<void> _launchUrl(Uri url) async {
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }
}
