import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:parallel_37/src/presentation/view_models/providers/stores_provider.dart';
import 'package:parallel_37/src/presentation/views/shopping_bag.dart';
import 'package:parallel_37/src/presentation/views/store_details.dart';
import 'package:parallel_37/src/presentation/widgets/horizontal_scroll.dart';
import 'package:parallel_37/src/presentation/widgets/item_card.dart';
import 'package:parallel_37/src/presentation/widgets/search_field.dart';
import 'package:parallel_37/src/presentation/widgets/section_title.dart';
import 'package:parallel_37/src/presentation/widgets/shimmers/store_card_shimmer.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size(screenSize.width, 144),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.4),
                spreadRadius: 1,
                blurRadius: 10,
              ),
            ],
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "You're at ",
                        style: textTheme.subtitle2?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        "The Hokage's Office, ",
                        style: textTheme.subtitle2?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        "Konoha",
                        style: textTheme.subtitle2?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Flexible(
                      //   child: Container(
                      //     decoration: BoxDecoration(
                      //       color: Colors.grey.withOpacity(0.4),
                      //       borderRadius: BorderRadius.circular(100),
                      //     ),
                      //     padding: const EdgeInsets.all(10),
                      //     child: SvgPicture.asset(
                      //       "assets/icons/save.svg",
                      //       color: Colors.grey,
                      //     ),
                      //   ),
                      // ),
                      const Expanded(
                        flex: 6,
                        child: SearchField(),
                      ),
                      Flexible(
                        child: GestureDetector(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Bag(),
                            ),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 48, 48, 48),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            padding: const EdgeInsets.all(10),
                            child: SvgPicture.asset(
                              "assets/icons/shopping-bag.svg",
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Consumer(
          builder: (context, ref, child) {
            final stores = ref.watch(storesProvider);
            final popularStores = ref.watch(popularStoresProvider);

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 32),
                stores.when(
                  data: (stores) {
                    return Column(
                      children: [
                        const SectionTitle(title: "Stores you might like"),
                        HorizontalScroll(
                          itemCount: stores.length,
                          items: (context, index) {
                            final store = stores[index];
                            return ItemCard(
                              image: store.image!,
                              title: store.name!,
                              chip: store.storeType!,
                              attachment: "${store.delivery} Delivery",
                              action: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => StoreDetails(
                                    storeData: store,
                                  ),
                                ),
                              ),
                            );
                          },
                        )
                      ],
                    );
                  },
                  error: (error, s) => const Center(
                    child: Text("An Unknown Error Occured!"),
                  ),
                  loading: () => const Center(
                    child: CircularProgressIndicator(
                      color: Colors.orange,
                    ),
                  ),
                  // loading: () => Column(
                  //   children: const [
                  //     StoreCardShimmer(itemCount: 6),
                  //     SizedBox(height: 18),
                  //     StoreCardShimmer(itemCount: 6),
                  //     SizedBox(height: 18),
                  //     StoreCardShimmer(itemCount: 6),
                  //   ],
                  // ),
                ),
                const SizedBox(height: 6),
                popularStores.when(
                  data: (popularStores) {
                    return Column(
                      children: [
                        const SectionTitle(title: "Popular in San Francisco"),
                        HorizontalScroll(
                          itemCount: popularStores.length,
                          items: (context, index) {
                            final store = popularStores[index];
                            return ItemCard(
                              image: store.image!,
                              title: store.name!,
                              chip: store.storeType!,
                              attachment: "${store.delivery} Delivery",
                              action: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => StoreDetails(
                                    storeData: store,
                                  ),
                                ),
                              ),
                            );
                          },
                        )
                      ],
                    );
                  },
                  error: (error, s) => const Center(
                    child: Text("An Unknown Error Occured!"),
                  ),
                  // loading: () => Column(
                  //   children: const [
                  //     StoreCardShimmer(itemCount: 6),
                  //     SizedBox(height: 18),
                  //     StoreCardShimmer(itemCount: 6),
                  //     SizedBox(height: 18),
                  //     StoreCardShimmer(itemCount: 6),
                  //   ],
                  // ),
                  loading: () => const Center(
                    child: CircularProgressIndicator(
                      color: Colors.orange,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
