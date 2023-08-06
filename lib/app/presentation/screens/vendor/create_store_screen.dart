import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parallel_37/app/core/theme/text_theme.dart';
import 'package:parallel_37/app/core/utilities/helpers/validator_helpers.dart';

import '../../../core/utilities/constants.dart';
import '../../../core/utilities/helpers/ui_helpers.dart';
import '../../notifiers/store_notifiers/create_store_notifier.dart';

class CreateStoreScreen extends StatefulWidget {
  const CreateStoreScreen({super.key});

  @override
  State<CreateStoreScreen> createState() => _CreateStoreScreenState();
}

class _CreateStoreScreenState extends State<CreateStoreScreen> {
  final _key = GlobalKey<FormState>(debugLabel: 'create-store');

  final Map<String, dynamic> data = {
    "name": "",
    "email": "",
    "phone": "",
    "location": "",
  };

  _submit(context, CreateStoreNotifier notifier) async {
    final formState = _key.currentState!;

    if (formState.validate()) {
      formState.save();
      final result = await notifier.createStore(data);
      if (result == CreateStoreState.success) {
        // navigate to home
      } else if (result == CreateStoreState.failed) {
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
                  "Create a store",
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
                    final state = ref.watch(createStoreProvider);
                    final notifier = ref.read(createStoreProvider.notifier);

                    return FilledButton(
                      onPressed: () => _submit(context, notifier),
                      child: state == CreateStoreState.loading
                          ? UiHelpers.loader()
                          : const Text("Create a store"),
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
