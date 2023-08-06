import 'package:flutter/material.dart';
import 'package:parallel_37/app/core/routes/routes.dart';
import 'package:parallel_37/app/core/theme/text_theme.dart';

class VendorHomeScreen extends StatefulWidget {
  const VendorHomeScreen({super.key});

  @override
  State<VendorHomeScreen> createState() => _VendorHomeScreenState();
}

class _VendorHomeScreenState extends State<VendorHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 24,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "You don't seem to have a store yet!",
                style: AppTextTheme.textTheme.bodyLarge,
              ),
              const SizedBox(height: 24),
              FilledButton(
                onPressed: () => Navigator.pushNamed(
                  context,
                  Routes.createStore,
                ),
                child: const Text("Create a store"),
              ),
              const SizedBox(height: 24),
              Text(
                "Switch to Personal",
                style: AppTextTheme.textTheme.bodyLarge,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
