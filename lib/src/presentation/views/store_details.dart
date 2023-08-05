import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parallel_37/src/data/models/cart_model.dart';
import 'package:parallel_37/src/domain/entities/store.dart';
import 'package:parallel_37/src/presentation/view_models/cart_vm.dart';
import 'package:parallel_37/src/presentation/views/shopping_bag.dart';
import 'package:parallel_37/src/presentation/widgets/back_icon.dart';
import 'package:parallel_37/src/presentation/widgets/horizontal_scroll.dart';
import 'package:parallel_37/src/presentation/widgets/section_title.dart';
import 'package:parallel_37/src/presentation/widgets/store_product.dart';

class StoreDetails extends StatefulWidget {
  final Store? storeData;
  const StoreDetails({
    Key? key,
    this.storeData,
  }) : super(key: key);

  @override
  State<StoreDetails> createState() => _StoreDetailsState();
}

class _StoreDetailsState extends State<StoreDetails> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverLayoutBuilder(builder: (BuildContext context, constraints) {
            final scrolled =
                constraints.scrollOffset > screenSize.height * 0.26;
            return SliverAppBar(
              centerTitle: true,
              expandedHeight: screenSize.height * 0.34,
              collapsedHeight: 70,
              leading: Padding(
                padding: const EdgeInsets.only(top: 12, left: 16, right: 8),
                child: IconImport(
                  action: () => Navigator.pop(context),
                  icon: "assets/icons/arrow-left.svg",
                  color: scrolled ? Colors.black : Colors.white,
                ),
              ),
              title: Padding(
                padding: const EdgeInsets.only(top: 14),
                child: Text(
                  widget.storeData!.name ?? "Store Name",
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.subtitle1?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: scrolled ? Colors.black : Colors.white,
                  ),
                ),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(top: 12, left: 12, right: 16),
                  child: IconImport(
                    action: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Bag(),
                      ),
                    ),
                    icon: "assets/icons/shopping-bag.svg",
                    color: scrolled ? Colors.black : Colors.white,
                  ),
                ),
              ],
              pinned: true,
              snap: false,
              floating: true,
              shadowColor: Colors.grey.withOpacity(0.4),
              backgroundColor: Colors.white,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: CachedNetworkImageProvider(
                        widget.storeData!.image ??
                            "https://images.pexels.com/photos/3735747/pexels-photo-3735747.jpeg",
                      ),
                      filterQuality: FilterQuality.high,
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                          Colors.black.withOpacity(0.4),
                          Colors.transparent,
                        ])),
                  ),
                ),
              ),
            );
          }),
          SliverList(
            delegate: SliverChildListDelegate([
              const SizedBox(height: 22),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 22,
                    ),
                    child: Text(
                      widget.storeData!.name ?? "Store Name",
                      style: textTheme.headline5,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 22,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 1),
                      child: Row(
                        children: [
                          Text(
                            widget.storeData!.timeRange ?? "Time Range",
                            overflow: TextOverflow.ellipsis,
                            style: textTheme.bodyText1?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            width: 5,
                            height: 5,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            "Pickup ${widget.storeData!.pickup}",
                            overflow: TextOverflow.ellipsis,
                            style: textTheme.bodyText1?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            width: 5,
                            height: 5,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            widget.storeData!.storeType ?? "Store Type",
                            overflow: TextOverflow.ellipsis,
                            style: textTheme.bodyText1?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 22),
              const Divider(
                thickness: 8,
              ),
              const SizedBox(height: 22),

              /* === fetch products from a store === */
              for (var product in widget.storeData!.products!)
                Column(children: [
                  SectionTitle(
                    title: product["title"],
                  ),
                  HorizontalScroll(
                    itemCount: product['items'].length,
                    items: (context, index) {
                      final productItem = product['items'][index];
                      return Consumer(
                        builder: (context, ref, child) {
                          final cartNotifier = ref.watch(cartProvider.notifier);
                          return StoreProduct(
                            image: productItem['image'],
                            name: productItem['name'],
                            price: "\$${productItem["price"].toString()}",
                            action: () => _productDetails(context, productItem),
                            addToCart: () async {
                              try {
                                await cartNotifier.addPizzaToCart(
                                    Cart(
                                      productId: productItem["product_id"],
                                      publisherId: productItem["publisher_id"],
                                      image: productItem["image"],
                                      name: productItem["name"],
                                      price: productItem["price"],
                                    ),
                                    productItem["product_id"],
                                    productItem["publisher_id"]);
                              } catch (err) {
                                log(
                                  "An error occurred >>> ${err.toString()}",
                                );
                              }
                            },
                          );
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 10),
                ]),
              /* === fetch products from a store === */
            ]),
          ),
        ],
      ),
    );
  }

  _productDetails(context, dynamic productItem) {
    showModalBottomSheet(
      isScrollControlled: true,
      isDismissible: true,
      enableDrag: true,
      context: context,
      backgroundColor: Colors.white,
      builder: ((context) {
        final screenSize = MediaQuery.of(context).size;
        final TextTheme textTheme = Theme.of(context).textTheme;
        return DraggableScrollableSheet(
          minChildSize: 0.62,
          maxChildSize: 0.856,
          initialChildSize: 0.62,
          expand: false,
          snap: true,
          builder: (context, scrollController) => Stack(
            children: [
              SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Center(
                          child: CachedNetworkImage(
                            imageUrl: productItem['image'],
                            width: screenSize.width,
                            height: screenSize.height * 0.34,
                            fit: BoxFit.cover,
                          ), 
                        ),
                        Positioned(
                          top: 22,
                          right: 22,
                          child: GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Text(
                              "Close",
                              style: textTheme.bodyText1?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 18),
                          Text(
                            productItem['name'],
                            style: textTheme.headline5,
                          ),
                          Row(
                            children: [
                              Text(
                                "\$${productItem["price"].toString()}",
                                style: textTheme.headline5?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(width: 14),
                              Padding(
                                padding: const EdgeInsets.only(top: 3),
                                child: Text(
                                  "\$9.90",
                                  style: textTheme.subtitle1?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    decoration: TextDecoration.lineThrough,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "The McDonald's Bacon, Egg & Cheese Biscuit breakfast sandwich features a warm, buttermilk biscuit brushed with real butter, thick cut Applewood smoked bacon, a fluffy folded egg, and a slice of melty American cheese.",
                            style: textTheme.bodyText1?.copyWith(
                              fontWeight: FontWeight.w600,
                              height: 1.48,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Ingredients",
                                style: textTheme.subtitle1?.copyWith(
                                  fontWeight: FontWeight.w700,
                                  height: 1.48,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "Salsa De Tomate, Mozzarella, Salami Picante, Aceitunas Negras Y Aceite Picante",
                                style: textTheme.bodyText1?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  height: 1.48,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  color: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 16,
                  ),
                  child: Consumer(builder: (context, ref, child) {
                    final cartNotifier = ref.watch(cartProvider.notifier);
                    return ElevatedButton(
                      onPressed: () async {
                        try {
                          await cartNotifier.addPizzaToCart(
                              Cart(
                                productId: productItem["product_id"],
                                publisherId: productItem["publisher_id"],
                                image: productItem["image"],
                                name: productItem["name"],
                                price: productItem["price"],
                              ),
                              productItem["product_id"],
                              productItem["publisher_id"]);
                        } catch (err) {
                          log(
                            "An error occurred >>> ${err.toString()}",
                          );
                        }
                      },
                      child: Text(
                        "Add for \$${productItem["price"].toString()}",
                        style: textTheme.subtitle2?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
          // bottomNavigationBar: Padding(
          //   padding: const EdgeInsets.symmetric(
          //     horizontal: 18,
          //     vertical: 16,
          //   ),
          //   child: Expanded(
          //     flex: 7,
          //     child: Consumer(builder: (context, ref, child) {
          //       final cartNotifier = ref.watch(cartProvider.notifier);
          //       return ElevatedButton(
          //         onPressed: () async {
          //           try {
          //             await cartNotifier.addPizzaToCart(
          //                 Cart(
          //                   productId: productItem["product_id"],
          //                   publisherId: productItem["publisher_id"],
          //                   image: productItem["image"],
          //                   name: productItem["name"],
          //                   price: productItem["price"],
          //                 ),
          //                 productItem["product_id"],
          //                 productItem["publisher_id"]);
          //           } catch (err) {
          //             log(
          //               "An error occurred >>> ${err.toString()}",
          //             );
          //           }
          //         },
          //         child: Text(
          //           "Add for \$${productItem["price"].toString()}",
          //           style: textTheme.subtitle2?.copyWith(
          //             fontWeight: FontWeight.w700,
          //             color: Colors.white,
          //           ),
          //         ),
          //       );
          //     }),
          //   ),
          // ),
          // ),
        );
      }),
    );
  }
}
