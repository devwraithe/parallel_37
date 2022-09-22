import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:parallel_37/src/data/cart_model.dart';
import 'package:parallel_37/src/data/database_helper.dart';
import 'package:parallel_37/src/data/pizza_model.dart';
import 'package:parallel_37/src/presentation/logic/cart_viewmodel.dart';

class Info extends StatefulWidget {
  final PizzaModel? pizzaData;
  const Info({
    Key? key,
    this.pizzaData,
  }) : super(key: key);

  @override
  State<Info> createState() => _InfoState();
}

class _InfoState extends State<Info> {
  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(18, 84, 18, 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Hero(
                    tag: widget.pizzaData!.image as Object,
                    transitionOnUserGestures: true,
                    child: Image.asset(
                      widget.pizzaData!.image.toString(),
                      width: 300,
                      height: 300,
                    ),
                  ),
                ),
                const SizedBox(height: 26),
                Hero(
                  tag: widget.pizzaData!.name as Object,
                  child: Text(
                    widget.pizzaData!.name.toString(),
                    style: textTheme.headline3,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Delivery:",
                          style: textTheme.bodyText1?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: Colors.grey,
                          ),
                        ),
                        Text(
                          "${widget.pizzaData!.duration.toString()} Mins",
                          style: textTheme.bodyText1?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 18),
                    Row(
                      children: [
                        Text(
                          "Weight:",
                          style: textTheme.bodyText1?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: Colors.grey,
                          ),
                        ),
                        Text(
                          "${widget.pizzaData!.weight.toString()}g",
                          style: textTheme.bodyText1?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      " \$${widget.pizzaData!.price.toString()}",
                      style: textTheme.headline5?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Padding(
                      padding: const EdgeInsets.only(top: 3),
                      child: Text(
                        "\$${widget.pizzaData!.price.toString()}",
                        style: textTheme.subtitle1?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: Colors.red,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                Text(
                  "Pepperoni is an American variety of spicy salami made from cured pork and beef seasoned with paprika or other chili pepper. Prior to cooking, pepperoni is characteristically soft, slightly smoky, and bright red. Thinly sliced pepperoni is one of the most popular pizza toppings in American pizzerias.",
                  textAlign: TextAlign.center,
                  style: textTheme.bodyText1?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                    height: 1.34,
                  ),
                ),
                const SizedBox(height: 30),
                Ink(
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Consumer(
                    builder: (context, ref, child) {
                      final cartNotifier = ref.watch(cartProvider.notifier);
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 22),
                        child: ElevatedButton(
                          onPressed: () async {
                            try {
                              await cartNotifier.addPizzaToCart(
                                Cart(
                                  id: widget.pizzaData!.id,
                                  image: widget.pizzaData!.image,
                                  name: widget.pizzaData!.name,
                                  price: widget.pizzaData!.price,
                                ),
                              );
                              log(
                                "${widget.pizzaData!.name} is added to cart",
                              );
                            } catch (err) {
                              log("An error occured - ${err.toString()}");
                            }
                          },
                          child: Text(
                            "Add to Pizza Cart",
                            style: textTheme.bodyText1?.copyWith(
                              letterSpacing: 0.4,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
