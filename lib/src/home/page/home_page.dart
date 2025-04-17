import 'package:bamtol_market_study/src/common/components/app_font.dart';
import 'package:bamtol_market_study/src/common/controller/authentication_controller.dart';
import 'package:bamtol_market_study/src/home/controller/home_controller.dart';
import 'package:bamtol_market_study/src/common/components/price_view.dart';
import 'package:bamtol_market_study/src/common/model/product.dart';
import 'package:bamtol_market_study/src/common/enum/market_enum.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: Get.width * 0.6, // ---- 1
        leading: Padding(
          padding: const EdgeInsets.only(left: 25),
          child: Row(children: [
            const AppFont(
              '아라동',
              fontWeight: FontWeight.bold,
              size: 20,
              color: Colors.white,
            ),
            const SizedBox(width: 10),
            SvgPicture.asset('assets/svg/icons/bottom_arrow.svg'),
          ]),
        ),
        actions: [
          SvgPicture.asset('assets/svg/icons/search.svg'),
          const SizedBox(width: 15),
          SvgPicture.asset('assets/svg/icons/list.svg'),
          const SizedBox(width: 15),
          SvgPicture.asset('assets/svg/icons/bell.svg'),
          const SizedBox(width: 25),
        ],
      ),
      // body: Center(
      //   child: GestureDetector(
      //     onTap: () {
      //       Get.find<AuthenticationController>().logout();
      //     },
      //     child: const AppFont('홈'),
      //   ),
      // ),
      body: const _ProductList(),
      floatingActionButton: GestureDetector(
        onTap: () async {
          // await Get.toNamed('/product/write');
          var isNeedRefresh = await Get.toNamed('/product/write');
          if (isNeedRefresh is bool && isNeedRefresh) {
            Get.find<HomeController>().refresh();
          }
        },
        behavior: HitTestBehavior.translucent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: const Color(0xffED7738),
              ),
              child: Row(children: [
                SvgPicture.asset('assets/svg/icons/plus.svg'),
                const SizedBox(width: 6),
                const AppFont(
                  '글쓰기',
                  size: 16,
                  color: Colors.white,
                )
              ]),
            ),
          ],
        ),
      ),
    );
  }
}

//class _ProductList extends StatelessWidget {
class _ProductList extends GetView<HomeController> {
  const _ProductList({super.key});

  Widget subInfo(Product product) {
    return Row(
      children: [
        AppFont(
          product.owner?.nickname ?? '',
          color: const Color(0xff878B93),
          size: 12,
        ),
        const AppFont(
          ' · ',
          color: const Color(0xff878B93),
          size: 12,
        ),
        AppFont(
          DateFormat('yyyy.MM.dd').format(product.createdAt!),
          color: const Color(0xff878B93),
          size: 12,
        ),
      ],
    );
  }

  Widget _productOne(Product product) {
    return GestureDetector(
      onTap: () {
        Get.toNamed('/product/detail/${product.docId}');
      },
      behavior: HitTestBehavior.translucent,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(7),
            child: SizedBox(
              width: 100,
              height: 100,
              child: Image.network(
                product.imageUrls?.first ??
                    '', //'https://cdn.kgmaeil.net/news/photo/202007/245825_49825_2217.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 10),
                AppFont(
                  product.title ?? '', //'Yaamj 상품$index 무료로 드려요 :) ',
                  color: Colors.white,
                  size: 16,
                ),
                const SizedBox(height: 5),
                subInfo(product),
                const SizedBox(height: 5),
                PriceView(
                  price: product.productPrice ?? 0,
                  status: product.status ?? ProductStatusType.sale,
                )
              ],
            ),
          )
        ],
      ),
    );

    // return Row(
    //   crossAxisAlignment: CrossAxisAlignment.start,
    //   children: [
    //     ClipRRect(
    //       borderRadius: BorderRadius.circular(7),
    //       child: SizedBox(
    //         width: 100,
    //         height: 100,
    //         child: Image.network(
    //           product.imageUrls?.first ??
    //               '', //'https://cdn.kgmaeil.net/news/photo/202007/245825_49825_2217.jpg',
    //           fit: BoxFit.cover,
    //         ),
    //       ),
    //     ),
    //     const SizedBox(width: 15),
    //     Expanded(
    //       child: Column(
    //         crossAxisAlignment: CrossAxisAlignment.stretch,
    //         children: [
    //           const SizedBox(height: 10),
    //           AppFont(
    //             product.title ?? '', //'Yaamj 상품$index 무료로 드려요 :) ',
    //             color: Colors.white,
    //             size: 16,
    //           ),
    //           const SizedBox(height: 5),
    //           subInfo(product),
    //           const SizedBox(height: 5),
    //           PriceView(
    //             price: product.productPrice ?? 0,
    //             status: product.status ?? ProductStatusType.sale,
    //           )
    //         ],
    //       ),
    //     )
    //   ],
    // );
  }

  // Widget build(BuildContext context) {
  //   return ListView.separated(
  //     padding: const EdgeInsets.only(left: 25.0, top: 20, right: 25),
  //     itemBuilder: (context, index) {
  //       return Container(
  //         height: 100,
  //         color: Colors.blue,
  //       );
  //     },
  //     separatorBuilder: (context, index) => const Padding(
  //       padding: EdgeInsetsDirectional.symmetric(vertical: 10.0),
  //       child: Divider(
  //         color: Color(0xff3C3C3E),
  //       ),
  //     ),
  //     itemCount: 10,
  //   );
  // }
  // Widget build(BuildContext context) {
  //   return ListView.separated(
  //     padding: const EdgeInsets.only(left: 25.0, top: 20, right: 25),
  //     itemBuilder: (context, index) {
  //       return _productOne(index);
  //     },
  //     separatorBuilder: (context, index) => const Padding(
  //       padding: EdgeInsets.symmetric(vertical: 10.0),
  //       child: Divider(
  //         color: Color(0xff3C3C3E),
  //       ),
  //     ),
  //     itemCount: 10,
  //   );
  // }
  Widget build(BuildContext context) {
    return Obx(
      () => ListView.separated(
        controller: controller.scrollController,
        padding: const EdgeInsets.only(left: 25.0, top: 20, right: 25),
        itemBuilder: (context, index) {
          return _productOne(
              controller.productList[index]); //_productOne(index);
        },
        // itemBuilder: (context, index) {
        //   if (index == controller.productList.length) {
        //     return controller.searchOption.lastItem != null
        //         ? const Center(
        //             child: CircularProgressIndicator(strokeWidth: 1),
        //           )
        //         : Container();
        //   }
        //   return _productOne(controller.productList[index]);
        // },
        separatorBuilder: (context, index) => const Padding(
          padding: EdgeInsets.symmetric(vertical: 10.0),
          child: Divider(
            color: Color(0xff3C3C3E),
          ),
        ),
        itemCount: controller.productList.length,
      ),
    );
  }
}
