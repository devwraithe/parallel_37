import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parallel_37/app/core/utilities/constants.dart';

import '../../../core/routes/routes.dart';
import '../../../core/theme/text_theme.dart';
import '../../notifiers/store_notifiers/check_store_notifier.dart';

class VendorHomeScreen extends ConsumerStatefulWidget {
  const VendorHomeScreen({super.key});
  @override
  VendorHomeScreenState createState() => VendorHomeScreenState();
}

class VendorHomeScreenState extends ConsumerState<VendorHomeScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(checkStoreProvider);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(checkStoreProvider);
    final notifier = ref.watch(checkStoreProvider.notifier);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 24,
          ),
          child: handleStoreAvailability(state, notifier),
        ),
      ),
    );
  }

  // handle the display based on the condition
  Widget handleStoreAvailability(
    CheckStoreStates state,
    CheckStoreNotifier notifier,
  ) {
    if (state == CheckStoreStates.loading) {
      return const Text("Loading");
    } else if (state == CheckStoreStates.complete) {
      final store = notifier.storeModel!;

      return Column(
        children: [
          Text("Complete: ${store.id}"),
          const SizedBox(height: 18),
          FilledButton(
            onPressed: () => Navigator.pushNamed(
              context,
              Routes.createMenu,
              arguments: {'store_id': store.id},
            ),
            child: const Text("Create a new menu"),
          )
        ],
      );
    } else if (state == CheckStoreStates.failed) {
      if (notifier.error == Constants.noStoreResponse) {
        return Column(
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
        );
      }
    }
    return const SizedBox();
  }
}
