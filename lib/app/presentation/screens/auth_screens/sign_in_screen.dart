import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parallel_37/app/presentation/notifiers/auth_notifiers/login_notifier.dart';

import '../../../core/routes/routes.dart';
import '../../../core/theme/text_theme.dart';
import '../../../core/utilities/constants.dart';
import '../../../core/utilities/helpers/ui_helpers.dart';
import '../../../core/utilities/helpers/validator_helpers.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final key = GlobalKey<FormState>(debugLabel: 'login');

  final Map<String, dynamic> data = {
    "email": "",
    "password": "",
  };

  // Show and hide password
  bool _obscureText = true;
  void _togglePassword() {
    setState(() => _obscureText = !_obscureText);
  }

  _submit(context, LoginNotifier notifier) async {
    final formState = key.currentState!;

    if (formState.validate()) {
      formState.save();
      final result = await notifier.handleLogin(data);
      if (result == LoginState.success) {
        Navigator.pushNamed(
          context,
          Routes.vendorHome,
        );
      } else if (result == LoginState.failed) {
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
                  "Sign in",
                  style: textTheme.headlineMedium,
                ),
                const SizedBox(height: 8.2),
                Text(
                  "Use your BiteHub sign-in",
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
                    suffixIcon: UiHelpers.switchPassword(
                      () => _togglePassword(),
                      _obscureText,
                    ),
                  ),
                  autovalidateMode: Constants.validateMode,
                  onSaved: (v) => data['password'] = v,
                  validator: (v) => ValidatorHelper.password(v),
                  style: textTheme.bodyLarge,
                  obscureText: _obscureText ? true : false,
                ),
                const SizedBox(height: 20),
                Consumer(
                  builder: (context, ref, _) {
                    final state = ref.watch(loginProvider);
                    final notifier = ref.read(loginProvider.notifier);

                    return FilledButton(
                      onPressed: () => _submit(context, notifier),
                      child: state == LoginState.loading
                          ? UiHelpers.loader()
                          : const Text("Sign In"),
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
