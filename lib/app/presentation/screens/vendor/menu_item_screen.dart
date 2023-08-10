import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parallel_37/app/presentation/notifiers/menu_notifiers/create_menu_item_notifier.dart';

import '../../../core/theme/text_theme.dart';
import '../../../core/utilities/constants.dart';
import '../../../core/utilities/helpers/ui_helpers.dart';
import '../../../core/utilities/helpers/validator_helpers.dart';
import '../../notifiers/menu_notifiers/menu_item_list_notifier.dart';

class MenuItemScreen extends StatefulWidget {
  const MenuItemScreen({super.key});

  @override
  State<MenuItemScreen> createState() => _MenuItemScreenState();
}

class _MenuItemScreenState extends State<MenuItemScreen> {
  final _key = GlobalKey<FormState>(debugLabel: 'create-menu-item');

  final Map<String, dynamic> data = {
    "name": "",
    "price": "",
    "type": "",
    "menu_id": "",
    "store_id": "",
  };

  _submit(context, CreateMenuItemNotifier notifier) async {
    final formState = _key.currentState!;

    if (formState.validate()) {
      formState.save();
      final result = await notifier.handleCreateMenuItem(data);
      if (result == CreateMenuItemState.success) {
        // Navigator.pushNamed(context, Routes.vendorHome);
      } else if (result == CreateMenuItemState.failed) {
        UiHelpers.errorFlush(
          notifier.error!,
          context,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    const textTheme = AppTextTheme.textTheme;

    final arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    data['store_id'] = arguments?['store_id'];
    data['menu_id'] = arguments?['menu_id'];
    data['type'] = arguments?['type'];

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: Constants.padding,
          child: Column(
            children: [
              Consumer(
                builder: (context, ref, _) {
                  final menuList = menuItemListProvider(data);
                  final state = ref.watch(menuList);
                  final notifier = ref.watch(menuList.notifier);

                  return Column(
                    children: [
                      for (final menuItem in notifier.menuItemList)
                        ListTile(
                          title: Text(menuItem.name),
                          subtitle: Text(menuItem.price),
                        ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 40),
              Form(
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
                      "Create a Menu",
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
                        hintText: "Name e.g Chicken Kebab",
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
                        hintText: "Price e.g \$30.4",
                        prefix: Constants.prefixSpace,
                      ),
                      autovalidateMode: Constants.validateMode,
                      onSaved: (v) => data['price'] = v,
                      validator: (v) => ValidatorHelper.storeEmail(v),
                      style: textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 20),
                    Consumer(
                      builder: (context, ref, _) {
                        final state = ref.watch(createMenuItemProvider);
                        final notifier =
                            ref.read(createMenuItemProvider.notifier);

                        return FilledButton(
                          onPressed: () => _submit(context, notifier),
                          child: state == CreateMenuItemState.loading
                              ? UiHelpers.loader()
                              : const Text("Create Item"),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
