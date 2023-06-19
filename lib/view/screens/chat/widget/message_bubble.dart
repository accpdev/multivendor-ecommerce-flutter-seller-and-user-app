import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_vendor_app/data/model/response/message_model.dart';
import 'package:sixvalley_vendor_app/helper/date_converter.dart';
import 'package:sixvalley_vendor_app/provider/chat_provider.dart';
import 'package:sixvalley_vendor_app/provider/splash_provider.dart';
import 'package:sixvalley_vendor_app/utill/color_resources.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/utill/images.dart';
import 'package:sixvalley_vendor_app/utill/styles.dart';

class MessageBubble extends StatelessWidget {
  final Message message;

  const MessageBubble({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isMe = message.sentBySeller == 1;

    String? baseUrl = Provider.of<ChatProvider>(context, listen: false).userTypeIndex == 0 ?
    Provider.of<SplashProvider>(context, listen: false).baseUrls!.customerImageUrl:
    Provider.of<SplashProvider>(context, listen: false).baseUrls!.sellerImageUrl;
    String? image = Provider.of<ChatProvider>(context, listen: false).userTypeIndex == 0 ?
    message.customer != null? message.customer?.image :'' : message.deliveryMan!.image;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
      child: Row(crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          isMe ? const SizedBox.shrink() :
          Padding(
            padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeExtraLarge),
            child: InkWell(child: ClipOval(child: Container(
              color: Theme.of(context).highlightColor,
              child: CachedNetworkImage(
                errorWidget: (ctx, url, err) => Image.asset(Images.placeholderImage, height: Dimensions.chatImage,
                  width: Dimensions.chatImage,fit: BoxFit.cover,),
                placeholder: (ctx, url) => Image.asset(Images.placeholderImage),
                imageUrl: '$baseUrl/$image',
                height: Dimensions.chatImage,
                width: Dimensions.chatImage,
                fit: BoxFit.cover,
              ),
            ))),
          ),
          Flexible(
            child: Column(crossAxisAlignment: isMe ?CrossAxisAlignment.end:CrossAxisAlignment.start,
              children: [
                Container(
                    margin: isMe ?  const EdgeInsets.fromLTRB(70, 5, 10, 5) : const EdgeInsets.fromLTRB(10, 10, 10, 10),
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: isMe? const Radius.circular(10) : const Radius.circular(10),
                        bottomLeft: isMe ? const Radius.circular(10) : const Radius.circular(0),
                        bottomRight: isMe ? const Radius.circular(0) : const Radius.circular(10),
                        topRight: isMe? const Radius.circular(10): const Radius.circular(10),
                      ),
                      color: isMe ? Theme.of(context).hintColor.withOpacity(.125) : ColorResources.getPrimary(context).withOpacity(.10),
                    ),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                      message.message!.isNotEmpty ? Text(message.message!,
                          style: titilliumRegular.copyWith(fontSize: Dimensions.fontSizeDefault,
                               color: isMe ?
                               ColorResources.getTextColor(context): ColorResources.getTextColor(context))) : const SizedBox.shrink(),
                    ]),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraSmall),
                  child: Text(DateConverter.customTime(DateTime.parse(message.createdAt!)),
                      style: titilliumRegular.copyWith(fontSize: Dimensions.fontSizeSmall,
                        color: ColorResources.getHint(context),
                      )),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
