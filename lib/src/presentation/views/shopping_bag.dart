import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:parallel_37/src/presentation/view_models/cart_vm.dart';
import 'package:parallel_37/src/presentation/widgets/bag_item.dart';

class Bag extends StatefulWidget {
  const Bag({Key? key}) : super(key: key);
  @override
  State createState() => _BagState();
}

class _BagState extends State<Bag> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size(screenSize.width, 78),
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: SvgPicture.asset(
                          "assets/icons/arrow-left.svg",
                          width: 30,
                        ),
                      ),
                      const SizedBox(width: 22),
                      Text(
                        "Checkout",
                        style: textTheme.headline6?.copyWith(
                          fontWeight: FontWeight.w600,
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
        child: Consumer(builder: (context, ref, child) {
          final cartNotifier = ref.watch(cartProvider);
          final cartRemoveNotifier = ref.watch(cartProvider.notifier);
          cartRemoveNotifier.totalPrice;
          cartRemoveNotifier.getCartData();
          return cartNotifier.isEmpty
              ? SizedBox(
                  height: screenSize.height * 0.78,
                  child: Center(
                    child: Text(
                      "Your cart is empty",
                      style: textTheme.headline6?.copyWith(
                        color: Colors.grey,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(
                        18,
                        24,
                        18,
                        0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Your Order",
                            style: textTheme.headline6?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Text(
                                "There's ",
                                style: textTheme.subtitle2?.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey,
                                ),
                              ),
                              Consumer(
                                builder: (context, ref, child) {
                                  return Text(
                                    "${cartNotifier.length.toString()} Items ",
                                    style: textTheme.subtitle2?.copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  );
                                },
                              ),
                              Text(
                                "in your bag ",
                                style: textTheme.subtitle2?.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 26),
                          for (final cartItem in cartNotifier)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 18),
                              child: BagItem(
                                name: cartItem.name!,
                                delivery: "Free Delivery",
                                price: cartItem.price.toString(),
                                action: () async {
                                  try {
                                    await cartRemoveNotifier
                                        .removePizzaFromCart(cartItem.id!);
                                  } catch (err) {
                                    log("An error occured - ${err.toString()}");
                                  }
                                },
                              ),
                            ),
                        ],
                      ),
                    ),
                    const Divider(
                      thickness: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 24,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Delivery Details",
                            style: textTheme.headline6?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            "Your order will be sent to:",
                            style: textTheme.subtitle2?.copyWith(
                              fontWeight: FontWeight.w500,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "The Hokage's Office, Konohagakure",
                            style: textTheme.subtitle2?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(
                      thickness: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 24,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Summary",
                            style: textTheme.headline6?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Orders Total",
                                style: textTheme.subtitle2?.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "\$${cartRemoveNotifier.productsPrice.toStringAsFixed(2)}",
                                style: textTheme.subtitle2?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Delivery Fees",
                                style: textTheme.subtitle2?.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "Free",
                                style: textTheme.subtitle2?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Service Fees",
                                style: textTheme.subtitle2?.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "\$0.0",
                                style: textTheme.subtitle2?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Grand Total",
                                style: textTheme.subtitle2?.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "\$${cartRemoveNotifier.productsPrice.toStringAsFixed(2)}",
                                style: textTheme.subtitle2?.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 32),
                          ElevatedButton(
                            onPressed: () {},
                            child: Text(
                              "Confirm Order",
                              style: textTheme.subtitle2?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
        }),
      ),
    );
  }
}
