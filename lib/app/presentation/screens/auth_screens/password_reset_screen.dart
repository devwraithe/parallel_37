import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parallel_37/app/presentation/notifiers/auth_notifiers/password_reset_notifier.dart';

import '../../../core/routes/routes.dart';
import '../../../core/theme/text_theme.dart';
import '../../../core/utilities/constants.dart';
import '../../../core/utilities/helpers/ui_helpers.dart';
import '../../../core/utilities/helpers/validator_helpers.dart';

class PasswordResetScreen extends StatefulWidget {
  const PasswordResetScreen({super.key});

  @override
  State<PasswordResetScreen> createState() => _PasswordResetScreenState();
}

class _PasswordResetScreenState extends State<PasswordResetScreen> {
  final key = GlobalKey<FormState>(debugLabel: 'password-reset');

  final Map<String, dynamic> data = {
    "email": "",
  };

  _submit(context, PasswordResetNotifier notifier) async {
    final formState = key.currentState!;

    if (formState.validate()) {
      formState.save();
      final result = await notifier.handleReset(data);
      if (result == PasswordResetState.success) {
        // navigate to home
      } else if (result == PasswordResetState.failed) {
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
            key: key,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.close,
                  size: 28,
                ),
                const SizedBox(height: 50),
                Text(
                  "Forgot Password",
                  style: textTheme.headlineMedium,
                ),
                const SizedBox(height: 8.2),
                Text(
                  "One time password recovery",
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
                const SizedBox(height: 20),
                Consumer(
                  builder: (context, ref, _) {
                    final state = ref.watch(passwordResetProvider);
                    final notifier = ref.read(passwordResetProvider.notifier);

                    return FilledButton(
                      onPressed: () => _submit(context, notifier),
                      child: state == PasswordResetState.loading
                          ? UiHelpers.loader()
                          : const Text("Reset"),
                    );
                  },
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Changed your mind? ",
                      style: textTheme.bodyLarge,
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pushNamed(
                        context,
                        Routes.signIn,
                      ),
                      child: Text(
                        "Sign In",
                        style: textTheme.titleLarge,
                      ),
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
