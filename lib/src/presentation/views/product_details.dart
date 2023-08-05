import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ProductDetails extends StatefulWidget {
  // final PizzaModel? pizzaData;
  const ProductDetails({
    Key? key,
    // this.pizzaData,
  }) : super(key: key);

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 22),
              Center(
                child: CachedNetworkImage(
                  imageUrl:
                      "https://www.mcdonalds.be/_webdata/category-images/categorie--menus.png",
                  width: screenSize.width * 0.8,
                ),
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 22,
                ),
                child: Text(
                  "Ramen from Ichiraku",
                  style: textTheme.headline5,
                ),
              ),
              const SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 22,
                ),
                child: Row(
                  children: [
                    Text(
                      "\$24.85",
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
              ),
              const SizedBox(height: 7),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 22,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 1),
                  child: Text(
                    "Ingredients: Salsa De Tomate, Mozzarella, Salami Picante, Aceitunas Negras Y Aceite Picante",
                    style: textTheme.bodyText1?.copyWith(
                      fontWeight: FontWeight.w600,
                      height: 1.48,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 16,
        ),
        child: Expanded(
          flex: 7,
          child: ElevatedButton(
            onPressed: () {},
            child: Text(
              "Add for \$24.85",
              style: textTheme.subtitle2?.copyWith(
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
