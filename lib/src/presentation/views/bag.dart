import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parallel_37/src/presentation/logic/cart_viewmodel.dart';
import 'package:parallel_37/src/presentation/widgets/bag_card.dart';

class Bag extends StatefulWidget {
  const Bag({Key? key}) : super(key: key);
  @override
  State createState() => _BagState();
}

class _BagState extends State<Bag> {
  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 30,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Pizza Cart",
                style: textTheme.subtitle1?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Consumer(
                builder: (context, ref, child) {
                  final cartNotifier = ref.watch(cartProvider);
                  final cartRemoveNotifier = ref.watch(cartProvider.notifier);
                  cartRemoveNotifier.getCartData();
                  return cartNotifier.isEmpty
                      ? SizedBox(
                          height: MediaQuery.of(context).size.height * 0.78,
                          child: Center(
                            child: Text(
                              "Your cart is empty",
                              style: textTheme.headline6?.copyWith(
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        )
                      : Column(
                          children: [
                            for (final cartItem in cartNotifier)
                              BagCard(
                                name: cartItem.name,
                                image: cartItem.image,
                                price: cartItem.price,
                                action: () async {
                                  try {
                                    await cartRemoveNotifier
                                        .removePizzaFromCart(cartItem.id!);
                                    log("${cartItem.name} is removed from cart");
                                  } catch (err) {
                                    log("An error occured - ${err.toString()}");
                                  }
                                },
                              ),
                          ],
                        );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
