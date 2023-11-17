import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parallel_37/app/core/routes/routes.dart';
import 'package:parallel_37/app/core/theme/text_theme.dart';
import 'package:parallel_37/app/core/utilities/helpers/validator_helpers.dart';

import '../../../core/utilities/constants.dart';
import '../../../core/utilities/helpers/ui_helpers.dart';
import '../../cubits/menu_notifiers/create_menu_notifier.dart';

class CreateMenuScreen extends ConsumerStatefulWidget {
  const CreateMenuScreen({super.key});

  @override
  CreateMenuScreenState createState() => CreateMenuScreenState();
}

class CreateMenuScreenState extends ConsumerState<CreateMenuScreen> {
  final _key = GlobalKey<FormState>(debugLabel: 'create-menu');

  final Map<String, dynamic> data = {
    "menu_type": "",
    "menu_name": "",
    "store_id": "",
  };

  _submit(context, CreateMenuNotifier notifier) async {
    final formState = _key.currentState!;

    if (formState.validate()) {
      formState.save();
      final result = await notifier.createMenu(data);
      if (result == CreateMenuState.success) {
        Navigator.pushNamed(context, Routes.vendorHome);
      } else if (result == CreateMenuState.failed) {
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
                    hintText: "Menu Name e.g Burgers",
                    prefix: Constants.prefixSpace,
                  ),
                  autovalidateMode: Constants.validateMode,
                  onSaved: (v) => data['menu_name'] = v,
                  validator: (v) => ValidatorHelper.storeName(v),
                  style: textTheme.bodyLarge,
                ),
                const SizedBox(height: 14),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: "Menu Type e.g Fast Food",
                    prefix: Constants.prefixSpace,
                  ),
                  autovalidateMode: Constants.validateMode,
                  onSaved: (v) => data['menu_type'] = v,
                  validator: (v) => ValidatorHelper.storeEmail(v),
                  style: textTheme.bodyLarge,
                ),
                const SizedBox(height: 20),
                Consumer(
                  builder: (context, ref, _) {
                    // create a menu providers
                    final state = ref.watch(createMenuProvider);
                    final notifier = ref.read(createMenuProvider.notifier);

                    return FilledButton(
                      onPressed: () => _submit(context, notifier),
                      child: state == CreateMenuState.loading
                          ? UiHelpers.loader()
                          : const Text("Create menu"),
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
