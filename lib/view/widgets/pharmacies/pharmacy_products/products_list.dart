import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teleprac/controller/pharmacies/pharmacies_controller.dart';
import 'package:teleprac/controller/search_con.dart';
import 'package:teleprac/core/const/colors.dart';
import 'package:teleprac/core/const/decoration.dart';
import 'package:teleprac/core/const/texts.dart';
import 'package:teleprac/model/pharmacies/product_model.dart';
import 'package:teleprac/view/widgets/global/custom_button.dart';
import 'package:teleprac/view/widgets/pharmacies/pharmacy_products/product_image.dart';

class PharmacyProductsList extends GetView<PharmaciesController> {
  const PharmacyProductsList({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppDecoration().screenHeight * 0.9,
      child: GetBuilder<SearchCon>(
        builder: (searchCon) {
          return Column(
            children: [
              // if (!controller.pharmacySelected)
              //   CustomButton(
              //     margin: const EdgeInsets.all(10),
              //     function: () {
              //       controller.seeAllPharmacies();
              //     },
              //     buttonColor: AppColors.primaryColor,
              //     text: 'See All Phramacies',
              //   ),
              Expanded(
                child: ListView.builder(
                  physics:
                      const BouncingScrollPhysics(parent: PageScrollPhysics()),
                  itemCount: searchCon.filteredProducts.isEmpty
                      ? searchCon.pharmaciesProducts.length
                      : searchCon.filteredProducts.length,
                  itemBuilder: (context, index) {
                    ProductModel productModel =
                        searchCon.filteredProducts.isEmpty
                            ? ProductModel.fromJson(
                                searchCon.pharmaciesProducts[index],
                              )
                            : ProductModel.fromJson(
                                searchCon.filteredProducts[index],
                              );
                    bool inCart =
                        controller.cartProducts.contains(productModel.id);

                    if (controller.searchCon
                        .productSearchValidate(productModel: productModel)) {
                      return GestureDetector(
                        onTap: () {
                          controller.productDetails(
                            productModel: productModel,
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.only(
                            left: 8,
                            right: 8,
                            bottom: 20,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: AppColors.secondaryColor,
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Stack(
                                    children: [
                                      Align(
                                        alignment: Alignment.center,
                                        child: Hero(
                                          tag: productModel.id!,
                                          child: ProductImage(
                                            imageUrl:
                                                productModel.uploadImageUrl!,
                                          ),
                                        ),
                                      ),
                                      if (productModel.discount
                                                  .toString()
                                                  .removeAllWhitespace !=
                                              '0' &&
                                          productModel.discount != null &&
                                          productModel.discount!.isNotEmpty &&
                                          productModel.discount!.isNotEmpty &&
                                          productModel.price !=
                                              productModel.salePrice)
                                        Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            Image.asset(
                                              AppDecoration.discount,
                                              width:
                                                  AppDecoration().screenWidth *
                                                      0.14,
                                            ),
                                            Text(
                                              '${productModel.discount}%\noff',
                                              style: TextStyle(
                                                fontSize: AppDecoration()
                                                        .screenWidth *
                                                    0.035,
                                                color: AppColors.secondaryColor,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width:
                                            AppDecoration().screenWidth * 0.5,
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              8, 15, 8, 0),
                                          child: Text(
                                            productModel.name!,
                                            style: TextStyle(
                                              color: AppColors.black,
                                              fontSize:
                                                  AppDecoration().screenWidth *
                                                      0.05,
                                              fontFamily: AppDecoration.cairo,
                                              fontWeight: FontWeight.bold,
                                              height: 1.2,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width:
                                            AppDecoration().screenWidth * 0.5,
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              8, 15, 8, 0),
                                          child: Text(
                                            productModel.medicineType == '1'
                                                ? "Prescription Requried"
                                                : "Prescription Not Requried",
                                            style: TextStyle(
                                              color: AppColors.red,
                                              fontSize:
                                                  AppDecoration().screenWidth *
                                                      0.035,
                                              fontFamily: AppDecoration.cairo,
                                              fontWeight: FontWeight.bold,
                                              height: 1,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width:
                                            AppDecoration().screenWidth * 0.5,
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              8, 2, 8, 0),
                                          child: Text(
                                            productModel.manufacturedBy!
                                                        .length >=
                                                    10
                                                ? '${productModel.manufacturedBy!.substring(0, 10)}..'
                                                : productModel.manufacturedBy!,
                                            style: TextStyle(
                                              color: AppColors.blue,
                                              fontSize:
                                                  AppDecoration().screenWidth *
                                                      0.04,
                                              fontFamily: AppDecoration.cairo,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width:
                                            AppDecoration().screenWidth * 0.5,
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              8, 0, 8, 0),
                                          child: Text(
                                            productModel.composition != null
                                                ? productModel.composition!
                                                            .length >=
                                                        35
                                                    ? '${productModel.composition!.substring(0, 35)}..'
                                                    : productModel.composition!
                                                : '',
                                            style: TextStyle(
                                              color: AppColors.black,
                                              fontSize:
                                                  AppDecoration().screenWidth *
                                                      0.03,
                                              fontFamily: AppDecoration.cairo,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            if (productModel.discount == '0' ||
                                                productModel.discount == null ||
                                                productModel
                                                    .discount!.isEmpty ||
                                                productModel.price ==
                                                    productModel.salePrice)
                                              SizedBox(
                                                width: AppDecoration()
                                                        .screenWidth *
                                                    0.4,
                                                child: Text(
                                                  'Price : ${AppTexts.indianRupee} ${productModel.price}',
                                                  style: TextStyle(
                                                    fontSize: AppDecoration()
                                                            .screenWidth *
                                                        0.045,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            if (productModel.discount != '0' &&
                                                productModel.discount != null &&
                                                productModel
                                                    .discount!.isNotEmpty &&
                                                productModel.price !=
                                                    productModel.salePrice)
                                              Row(
                                                children: [
                                                  Text(
                                                    'Price : ${AppTexts.indianRupee} ',
                                                    style: TextStyle(
                                                      fontSize: AppDecoration()
                                                              .screenWidth *
                                                          0.045,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  Container(
                                                    constraints: BoxConstraints(
                                                      maxWidth: AppDecoration()
                                                              .screenWidth *
                                                          0.2,
                                                    ),
                                                    child: Text(
                                                      productModel.price!,
                                                      style: TextStyle(
                                                        fontSize: AppDecoration()
                                                                .screenWidth *
                                                            0.03,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        decoration:
                                                            TextDecoration
                                                                .lineThrough,
                                                        decorationThickness:
                                                            2.5,
                                                        height: 0.5,
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    constraints: BoxConstraints(
                                                      maxWidth: AppDecoration()
                                                              .screenWidth *
                                                          0.25,
                                                    ),
                                                    child: Text(
                                                      productModel.salePrice!,
                                                      style: TextStyle(
                                                        fontSize: AppDecoration()
                                                                .screenWidth *
                                                            0.055,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(8, 2, 8, 2),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: CustomButton(
                                        function: () {
                                          controller.buyNow(
                                            productModel: productModel,
                                          );
                                        },
                                        buttonColor: AppColors.primaryColor,
                                        margin: const EdgeInsets.fromLTRB(
                                          0,
                                          0,
                                          0,
                                          10,
                                        ),
                                        circularRadius: 10,
                                        cairoFont: false,
                                        fontWeight: FontWeight.w400,
                                        text: 'Buy Now',
                                      ),
                                    ),
                                    SizedBox(
                                        width:
                                            AppDecoration().screenWidth * 0.01),
                                    Expanded(
                                      child: CustomButton(
                                        function: () {
                                          if (inCart) {
                                            controller.removeFromCart(
                                              productModel: productModel,
                                            );
                                          } else {
                                            controller.addToCart(
                                              productModel: productModel,
                                            );
                                          }
                                        },
                                        buttonColor: AppColors.primaryColor,
                                        margin: const EdgeInsets.fromLTRB(
                                          0,
                                          0,
                                          0,
                                          10,
                                        ),
                                        circularRadius: 10,
                                        cairoFont: false,
                                        fontWeight: FontWeight.w400,
                                        text: inCart
                                            ? 'Remove From Cart'
                                            : 'Add To Cart',
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
              ),
              // ...List.generate(
              //   (searchCon.filteredProducts.isEmpty &&
              //           searchCon.filteredCategories.isEmpty)
              //       ? searchCon.pharmaciesProducts.length
              //       : searchCon.filteredProducts.length,
              //   (index) {
              //     ProductModel productModel =
              //         // searchCon.filteredProducts.isEmpty ?
              //         ProductModel.fromJson(
              //       searchCon.pharmaciesProducts[index],
              //     );
              //     // : ProductModel.fromJson(
              //     //     searchCon.filteredProducts[index],
              //     //   );
              //     bool inCart = false;
              //     for (var cartItem in controller.mainController.cartProducts) {
              //       if (cartItem['product_id'] == productModel.id) {
              //         inCart = true;
              //         break;
              //       }
              //     }
              //     if (controller.searchCon
              //         .productSearchValidate(productModel: productModel)) {
              //       return GestureDetector(
              //         onTap: () {
              //           searchCon.closeFiltersContainer();
              //           controller.productDetails(
              //             productModel: productModel,
              //           );
              //         },
              //         child: Container(
              //           margin: const EdgeInsets.only(
              //             left: 8,
              //             right: 8,
              //             bottom: 20,
              //           ),
              //           constraints: BoxConstraints(
              //             maxHeight: AppDecoration().screenHeight * 0.3,
              //           ),
              //           decoration: BoxDecoration(
              //             borderRadius: BorderRadius.circular(20),
              //             color: AppColors.secondaryColor,
              //           ),
              //           child: Row(
              //             crossAxisAlignment: CrossAxisAlignment.stretch,
              //             children: [
              //               Stack(
              //                 children: [
              //                   Align(
              //                     alignment: Alignment.center,
              //                     child: Hero(
              //                       tag: productModel.id!,
              //                       child: ProductImage(
              //                         imageUrl: productModel.uploadImageUrl!,
              //                       ),
              //                     ),
              //                   ),
              //                   if (productModel.discount
              //                               .toString()
              //                               .removeAllWhitespace !=
              //                           '0' &&
              //                       productModel.discount != null &&
              //                       productModel.discount!.isNotEmpty &&
              //                       productModel.discount!.isNotEmpty &&
              //                       productModel.price !=
              //                           productModel.salePrice)
              //                     Stack(
              //                       alignment: Alignment.center,
              //                       children: [
              //                         Image.asset(
              //                           AppDecoration.discount,
              //                           width:
              //                               AppDecoration().screenWidth * 0.14,
              //                         ),
              //                         Text(
              //                           '${productModel.discount}%\noff',
              //                           style: const TextStyle(
              //                             fontSize: 15,
              //                             color: AppColors.secondaryColor,
              //                             fontWeight: FontWeight.bold,
              //                           ),
              //                           textAlign: TextAlign.center,
              //                         ),
              //                       ],
              //                     ),
              //                 ],
              //               ),
              //               Column(
              //                 children: [
              //                   Container(
              //                     constraints: BoxConstraints(
              //                       maxHeight:
              //                           AppDecoration().screenHeight * 0.25,
              //                     ),
              //                     child: FittedBox(
              //                       child: Column(
              //                         crossAxisAlignment:
              //                             CrossAxisAlignment.start,
              //                         children: [
              //                           SizedBox(
              //                             width:
              //                                 AppDecoration().screenWidth * 0.5,
              //                             child: Padding(
              //                               padding: const EdgeInsets.fromLTRB(
              //                                   8, 15, 8, 0),
              //                               child: Text(
              //                                 productModel.name!,
              //                                 style: TextStyle(
              //                                   color: AppColors.black,
              //                                   fontSize: AppDecoration()
              //                                           .screenWidth *
              //                                       0.05,
              //                                   fontFamily: AppDecoration.cairo,
              //                                   fontWeight: FontWeight.bold,
              //                                   height: 1.2,
              //                                 ),
              //                               ),
              //                             ),
              //                           ),
              //                           SizedBox(
              //                             width:
              //                                 AppDecoration().screenWidth * 0.5,
              //                             child: Padding(
              //                               padding: const EdgeInsets.fromLTRB(
              //                                   8, 15, 8, 0),
              //                               child: Text(
              //                                 productModel.medicineType == '1'
              //                                     ? "Prescription Requried"
              //                                     : "Prescription Not Requried",
              //                                 style: TextStyle(
              //                                   color: AppColors.red,
              //                                   fontSize: AppDecoration()
              //                                           .screenWidth *
              //                                       0.035,
              //                                   fontFamily: AppDecoration.cairo,
              //                                   fontWeight: FontWeight.bold,
              //                                   height: 1,
              //                                 ),
              //                               ),
              //                             ),
              //                           ),
              //                           SizedBox(
              //                             width:
              //                                 AppDecoration().screenWidth * 0.5,
              //                             child: Padding(
              //                               padding: const EdgeInsets.fromLTRB(
              //                                   8, 2, 8, 0),
              //                               child: Text(
              //                                 productModel.manufacturedBy!
              //                                             .length >=
              //                                         10
              //                                     ? '${productModel.manufacturedBy!.substring(0, 10)}..'
              //                                     : productModel
              //                                         .manufacturedBy!,
              //                                 style: TextStyle(
              //                                   color: AppColors.blue,
              //                                   fontSize: AppDecoration()
              //                                           .screenWidth *
              //                                       0.04,
              //                                   fontFamily: AppDecoration.cairo,
              //                                   fontWeight: FontWeight.bold,
              //                                 ),
              //                               ),
              //                             ),
              //                           ),
              //                           SizedBox(
              //                             width:
              //                                 AppDecoration().screenWidth * 0.5,
              //                             child: Padding(
              //                               padding: const EdgeInsets.fromLTRB(
              //                                   8, 0, 8, 0),
              //                               child: Text(
              //                                 productModel.composition != null
              //                                     ? productModel.composition!
              //                                                 .length >=
              //                                             35
              //                                         ? '${productModel.composition!.substring(0, 35)}..'
              //                                         : productModel
              //                                             .composition!
              //                                     : '',
              //                                 style: TextStyle(
              //                                   color: AppColors.black,
              //                                   fontSize: AppDecoration()
              //                                           .screenWidth *
              //                                       0.03,
              //                                   fontFamily: AppDecoration.cairo,
              //                                   fontWeight: FontWeight.bold,
              //                                 ),
              //                               ),
              //                             ),
              //                           ),
              //                           Padding(
              //                             padding: const EdgeInsets.all(8.0),
              //                             child: Row(
              //                               children: [
              //                                 if (productModel.discount ==
              //                                         '0' ||
              //                                     productModel.discount ==
              //                                         null ||
              //                                     productModel
              //                                         .discount!.isEmpty ||
              //                                     productModel.price ==
              //                                         productModel.salePrice)
              //                                   SizedBox(
              //                                     width: AppDecoration()
              //                                             .screenWidth *
              //                                         0.5,
              //                                     child: Text(
              //                                       'Price : ${AppTexts.indianRupee} ${productModel.price}',
              //                                       style: const TextStyle(
              //                                         fontSize: 17,
              //                                         fontWeight:
              //                                             FontWeight.bold,
              //                                       ),
              //                                     ),
              //                                   ),
              //                                 if (productModel.discount !=
              //                                         '0' &&
              //                                     productModel.discount !=
              //                                         null &&
              //                                     productModel
              //                                         .discount!.isNotEmpty &&
              //                                     productModel.price !=
              //                                         productModel.salePrice)
              //                                   Row(
              //                                     children: [
              //                                       const Text(
              //                                         'Price : ${AppTexts.indianRupee} ',
              //                                         style: TextStyle(
              //                                           fontSize: 17,
              //                                           fontWeight:
              //                                               FontWeight.bold,
              //                                         ),
              //                                       ),
              //                                       Container(
              //                                         constraints:
              //                                             BoxConstraints(
              //                                           maxWidth: AppDecoration()
              //                                                   .screenWidth *
              //                                               0.2,
              //                                           maxHeight: AppDecoration()
              //                                                   .screenHeight *
              //                                               0.03,
              //                                         ),
              //                                         child: Text(
              //                                           productModel.price!,
              //                                           style: const TextStyle(
              //                                             fontSize: 12,
              //                                             fontWeight:
              //                                                 FontWeight.w500,
              //                                             decoration:
              //                                                 TextDecoration
              //                                                     .lineThrough,
              //                                             decorationThickness:
              //                                                 2.5,
              //                                             height: 0.5,
              //                                           ),
              //                                         ),
              //                                       ),
              //                                       Container(
              //                                         constraints:
              //                                             BoxConstraints(
              //                                           maxWidth: AppDecoration()
              //                                                   .screenWidth *
              //                                               0.3,
              //                                           maxHeight: AppDecoration()
              //                                                   .screenHeight *
              //                                               0.03,
              //                                         ),
              //                                         child: Text(
              //                                           productModel.salePrice!,
              //                                           style: const TextStyle(
              //                                             fontSize: 20,
              //                                             fontWeight:
              //                                                 FontWeight.bold,
              //                                           ),
              //                                         ),
              //                                       ),
              //                                     ],
              //                                   ),
              //                               ],
              //                             ),
              //                           ),
              //                         ],
              //                       ),
              //                     ),
              //                   ),
              //                   CustomButton(
              //                     function: () {
              //                       if (inCart) {
              //                         controller.removeFromCart(
              //                           productModel: productModel,
              //                         );
              //                       } else {
              //                         controller.addToCart(
              //                           productModel: productModel,
              //                         );
              //                       }
              //                     },
              //                     buttonColor: AppColors.primaryColor,
              //                     width: .5,
              //                     height: .03,
              //                     margin:
              //                         const EdgeInsets.fromLTRB(0, 0, 0, 10),
              //                     circularRadius: 10,
              //                     text: inCart
              //                         ? 'Remove From Cart'
              //                         : 'Add To Cart',
              //                     fontSize: AppDecoration().screenWidth * 0.045,
              //                   ),
              //                 ],
              //               ),
              //             ],
              //           ),
              //         ),
              //       );
              //     } else {
              //       return const SizedBox();
              //     }
              //   },
              // ),
              SizedBox(
                height: AppDecoration().screenHeight * 0.1,
              )
            ],
          );
        },
      ),
    );
  }
}
