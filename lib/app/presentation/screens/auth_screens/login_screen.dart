import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parallel_37/app/presentation/cubits/auth_notifiers/login_cubit/login_cubit.dart';

import '../../../core/theme/text_theme.dart';
import '../../../core/utilities/constants.dart';
import '../../../core/utilities/helpers/ui_helpers.dart';
import '../../../core/utilities/helpers/validator_helpers.dart';
import '../../cubits/auth_notifiers/login_cubit/login_state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _key = GlobalKey<FormState>(debugLabel: 'login');

  final Map<String, dynamic> data = {
    "email": "",
    "password": "",
  };

  // Show and hide password
  bool _obscureText = true;
  void _togglePassword() {
    setState(() => _obscureText = !_obscureText);
  }

  void _submit() async {
    FocusManager.instance.primaryFocus?.unfocus();

    final formState = _key.currentState!;

    if (formState.validate()) {
      formState.save();
      BlocProvider.of<LoginCubit>(context).login(data);
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
                FilledButton(
                  onPressed: () => _submit(),
                  child: BlocConsumer<LoginCubit, LoginState>(
                    listener: (context, state) {
                      if (state is LoginError) {
                        UiHelpers.errorFlush(state.message, context);
                      }
                      if (state is LoginSuccess) {
                        debugPrint("Login successful");
                      }
                    },
                    builder: (context, state) {
                      if (state is LoginLoading) {
                        return UiHelpers.loader();
                      } else {
                        return const Text("Sign in");
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
