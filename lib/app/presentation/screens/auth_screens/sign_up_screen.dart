import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parallel_37/app/core/theme/text_theme.dart';
import 'package:parallel_37/app/core/utilities/helpers/validator_helpers.dart';
import 'package:parallel_37/app/presentation/notifiers/auth_notifiers/create_acct_notifier.dart';

import '../../../core/utilities/constants.dart';
import '../../../core/utilities/helpers/ui_helpers.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _key = GlobalKey<FormState>(debugLabel: 'create-account');

  final Map<String, dynamic> data = {
    "email": "",
    "password": "",
  };

  _submit(context, CreateAcctNotifier notifier) async {
    final formState = _key.currentState!;

    if (formState.validate()) {
      formState.save();
      final result = await notifier.createAcct(data);
      if (result == CreateAcctState.success) {
        // navigate to home
      } else if (result == CreateAcctState.failed) {
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
                  "Create your account",
                  style: textTheme.headlineMedium,
                ),
                const SizedBox(height: 8.2),
                Text(
                  "Get deals and track orders",
                  style: textTheme.bodyLarge,
                ),
                const SizedBox(height: 26),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: "Email",
                    prefix: Constants.prefixSpace,
                  ),
                  autovalidateMode: Constants.validateMode,
                  onSaved: (v) => data['email'] = v,
                  validator: (v) => ValidatorHelper.email(v),
                  style: textTheme.bodyLarge,
                ),
                const SizedBox(height: 14),
                TextFormField(
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                    hintText: "Password",
                    prefix: Constants.prefixSpace,
                  ),
                  autovalidateMode: Constants.validateMode,
                  onSaved: (v) => data['password'] = v,
                  validator: (v) => ValidatorHelper.password(v),
                  style: textTheme.bodyLarge,
                ),
                const SizedBox(height: 20),
                Consumer(
                  builder: (context, ref, _) {
                    final state = ref.watch(createAcctProvider);
                    final notifier = ref.read(createAcctProvider.notifier);

                    return FilledButton(
                      onPressed: () => _submit(context, notifier),
                      child: state == CreateAcctState.loading
                          ? UiHelpers.loader()
                          : const Text("Create Account"),
                    );
                  },
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have a BiteHub account? ",
                      style: textTheme.bodyLarge,
                    ),
                    Text(
                      "Sign In",
                      style: textTheme.titleLarge,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
