import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parallel_37/app/features/inventory/presentation/add_item/add_item_cubit/add_item_cubit.dart';

import '../../../../core/theme/text_theme.dart';
import '../../../../core/utilities/constants.dart';
import '../../../../core/utilities/helpers/ui_helpers.dart';
import '../../../../core/utilities/helpers/validator_helpers.dart';
import 'add_item_cubit/add_item_state.dart';

class AddItemScreen extends StatefulWidget {
  const AddItemScreen({super.key});

  @override
  State<AddItemScreen> createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  Map<String, dynamic> data = {};

  @override
  Widget build(BuildContext context) {
    const textTheme = AppTextTheme.textTheme;

    final arguments = ModalRoute.of(context)!.settings.arguments;
    data['category'] = arguments as String;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: Constants.padding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data['category'],
                style: textTheme.headlineMedium,
              ),
              const SizedBox(height: 5),
              Text(
                "Keep track of store items",
                style: textTheme.bodyLarge,
              ),
              const SizedBox(height: 20),
              // BlocBuilder<GetCategoriesCubit, GetCategoriesState>(
              //   builder: (context, state) {
              //     if (state is GetCategoriesLoading) {
              //       return UiHelpers.loader();
              //     } else if (state is GetCategoriesError) {
              //       return Text(state.message);
              //     } else if (state is GetCategoriesSuccess) {
              //       return Column(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           for (final category in state.result) Text(category)
              //         ],
              //       );
              //     } else {
              //       return const SizedBox();
              //     }
              //   },
              // ),
              const SizedBox(height: 20),
              FilledButton(
                onPressed: () => _addItemSheet(),
                child: const Text("Add a new item"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _addItemSheet() {
    final key = GlobalKey<FormState>(debugLabel: "add-item");
    const textTheme = AppTextTheme.textTheme;

    void addItem() async {
      final formState = key.currentState!;

      if (formState.validate()) {
        formState.save();
        BlocProvider.of<AddItemCubit>(context).addItem(data);
      }
    }

    showModalBottomSheet(
      isScrollControlled: true,
      showDragHandle: false,
      context: context,
      builder: (context) {
        return SingleChildScrollView(
          padding: Constants.padding,
          child: Form(
            key: key,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Add new category",
                  style: textTheme.headlineMedium,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: "Cold Coffees",
                    prefix: Constants.prefixSpace,
                  ),
                  onSaved: (v) => data['name'] = v!,
                  autovalidateMode: Constants.validateMode,
                  validator: (v) => ValidatorHelper.others(v),
                  style: textTheme.bodyLarge,
                ),
                const SizedBox(height: 20),
                FilledButton(
                  onPressed: () => addItem(),
                  child: BlocBuilder<AddItemCubit, AddItemState>(
                    builder: (context, state) {
                      if (state is AddItemLoading) {
                        return UiHelpers.loader();
                      } else {
                        return const Text("Add");
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
