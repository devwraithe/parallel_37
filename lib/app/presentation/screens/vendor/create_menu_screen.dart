import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parallel_37/app/core/theme/text_theme.dart';
import 'package:parallel_37/app/core/utilities/helpers/validator_helpers.dart';
import 'package:parallel_37/app/presentation/notifiers/menu_notifiers/add_item_to_menu_notifier.dart';
import 'package:parallel_37/app/presentation/notifiers/menu_notifiers/get_menu_doc_id_notifier.dart';
import 'package:parallel_37/app/presentation/notifiers/store_notifiers/get_store_id_notifier.dart';

import '../../../core/utilities/constants.dart';
import '../../../core/utilities/helpers/ui_helpers.dart';
import '../../notifiers/menu_notifiers/create_menu_notifier.dart';

class CreateMenuScreen extends ConsumerStatefulWidget {
  const CreateMenuScreen({super.key});

  @override
  CreateMenuScreenState createState() => CreateMenuScreenState();
}

class CreateMenuScreenState extends ConsumerState<CreateMenuScreen> {
  // Future<String> retrieveId() async {
  //
  //   return storeDocId;
  // }

  @override
  void initState() {
    super.initState();
    // "ref" can be used in all life-cycles of a StatefulWidget.
    ref.read(getStoreIdProvider);
    ref.read(getMenuDocIdProvider);
  }

  final _key = GlobalKey<FormState>(debugLabel: 'create-menu');

  final Map<String, dynamic> data = {
    "store_id": "",
  };

  _createMenu(context, CreateMenuNotifier notifier) async {
    final idNotifier = ref.watch(getStoreIdProvider.notifier);
    final storeDocId = await idNotifier.getStoreId();
    setState(() => data['store_id'] = storeDocId);
    debugPrint("Store Document ID: ${data.toString()}");

    final formState = _key.currentState!;

    // if (formState.validate()) {
    // formState.save();
    // final result =
    await notifier.createMenu(data);
    // if (result == CreateMenuState.success) {
    //   // navigate to home
    // } else if (result == CreateMenuState.failed) {
    //   UiHelpers.errorFlush(
    //     notifier.error!,
    //     context,
    //   );
    // }
    // }
  }

  final Map<String, dynamic> menuData = {
    "menu_id": "",
    "store_id": "",
  };

  // handle adding item to menu
  _addItemToMenu(context, AddItemToMenuNotifier notifier) async {
    final idNotifier = ref.watch(getStoreIdProvider.notifier);
    final storeDocId = await idNotifier.getStoreId();
    setState(() => data['store_id'] = storeDocId);
    final menuIdNotifier = ref.watch(getMenuDocIdProvider.notifier);
    final menuDocId = await menuIdNotifier.getMenuDocId(data);
    setState(() => data['menu_id'] = menuDocId);
    debugPrint("Menu Document ID: ${data.toString()}");

    final formState = _key.currentState!;

    // if (formState.validate()) {
    // formState.save();
    // final result =
    await notifier.addItemToMenu(data);
    // if (result == CreateMenuState.success) {
    //   // navigate to home
    // } else if (result == CreateMenuState.failed) {
    //   UiHelpers.errorFlush(
    //     notifier.error!,
    //     context,
    //   );
    // }
    // }
  }

  @override
  Widget build(BuildContext context) {
    const textTheme = AppTextTheme.textTheme;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: Constants.padding,
          child: Form(
            key: _key,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.close,
                  size: 28,
                ),
                const SizedBox(height: 50),
                Text(
                  "Create a menu",
                  style: textTheme.headlineMedium,
                ),
                const SizedBox(height: 8.2),
                Text(
                  "Get your stuff out there",
                  style: textTheme.bodyLarge,
                ),
                const SizedBox(height: 26),
                TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: "Name e.g Hank's Steaks",
                    prefix: Constants.prefixSpace,
                  ),
                  autovalidateMode: Constants.validateMode,
                  onSaved: (v) => data['name'] = v,
                  validator: (v) => ValidatorHelper.storeName(v),
                  style: textTheme.bodyLarge,
                ),
                const SizedBox(height: 14),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: "Email e.g order@hanksteaks.com",
                    prefix: Constants.prefixSpace,
                  ),
                  autovalidateMode: Constants.validateMode,
                  onSaved: (v) => data['email'] = v,
                  validator: (v) => ValidatorHelper.storeEmail(v),
                  style: textTheme.bodyLarge,
                ),
                const SizedBox(height: 14),
                TextFormField(
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    hintText: "Phone Number e.g +1 234 567 890",
                    prefix: Constants.prefixSpace,
                  ),
                  autovalidateMode: Constants.validateMode,
                  onSaved: (v) => data['phone'] = v,
                  validator: (v) => ValidatorHelper.storePhone(v),
                  style: textTheme.bodyLarge,
                ),
                const SizedBox(height: 14),
                TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: "Location e.g Manhattan, New York",
                    prefix: Constants.prefixSpace,
                  ),
                  autovalidateMode: Constants.validateMode,
                  onSaved: (v) => data['location'] = v,
                  validator: (v) => ValidatorHelper.storeLocation(v),
                  style: textTheme.bodyLarge,
                ),
                const SizedBox(height: 20),
                Consumer(
                  builder: (context, ref, _) {
                    // create a menu providers
                    final stateA = ref.watch(createMenuProvider);
                    final notifierA = ref.read(createMenuProvider.notifier);

                    return FilledButton(
                      onPressed: () => _createMenu(context, notifierA),
                      child: stateA == CreateMenuState.loading
                          ? UiHelpers.loader()
                          : const Text("Create a menu"),
                    );
                  },
                ),
                const SizedBox(height: 20),
                Consumer(
                  builder: (context, ref, _) {
                    final stateB = ref.watch(addItemToMenuProvider);
                    final notifierB = ref.read(addItemToMenuProvider.notifier);

                    return FilledButton(
                      onPressed: () => _addItemToMenu(context, notifierB),
                      child: stateB == AddItemToMenuState.loading
                          ? UiHelpers.loader()
                          : const Text("Create a menu item"),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
