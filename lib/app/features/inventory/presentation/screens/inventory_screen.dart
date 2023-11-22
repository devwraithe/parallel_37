import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parallel_37/app/core/utilities/helpers/ui_helpers.dart';
import 'package:parallel_37/app/features/inventory/presentation/cubits/add_category_cubit/add_category_cubit.dart';
import 'package:parallel_37/app/features/inventory/presentation/cubits/add_category_cubit/add_category_state.dart';
import 'package:parallel_37/app/features/inventory/presentation/cubits/get_categories_cubit/get_categories_cubit.dart';
import 'package:parallel_37/app/features/inventory/presentation/cubits/get_categories_cubit/get_categories_state.dart';

import '../../../../core/theme/text_theme.dart';
import '../../../../core/utilities/constants.dart';
import '../../../../core/utilities/helpers/validator_helpers.dart';

class InventoryScreen extends StatefulWidget {
  const InventoryScreen({super.key});

  @override
  State<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<GetCategoriesCubit>(context).getCategories();
  }

  @override
  Widget build(BuildContext context) {
    const textTheme = AppTextTheme.textTheme;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: Constants.padding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Our Inventory",
                style: textTheme.headlineMedium,
              ),
              const SizedBox(height: 5),
              Text(
                "Keep track of store items",
                style: textTheme.bodyLarge,
              ),
              const SizedBox(height: 20),
              BlocBuilder<GetCategoriesCubit, GetCategoriesState>(
                builder: (context, state) {
                  if (state is GetCategoriesLoading) {
                    return UiHelpers.loader();
                  } else if (state is GetCategoriesError) {
                    return Text(state.message);
                  } else if (state is GetCategoriesSuccess) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (final category in state.result) Text(category)
                      ],
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
              const SizedBox(height: 20),
              FilledButton(
                onPressed: () => _addCategorySheet(),
                child: const Text("Add a new category"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _addCategorySheet() {
    final key = GlobalKey<FormState>(debugLabel: "add-category");
    const textTheme = AppTextTheme.textTheme;

    String? category;

    void addCategory() async {
      final formState = key.currentState!;

      if (formState.validate()) {
        formState.save();
        BlocProvider.of<AddCategoryCubit>(context).addCategory(category!);
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
                  onSaved: (v) => category = v!,
                  autovalidateMode: Constants.validateMode,
                  validator: (v) => ValidatorHelper.others(v),
                  style: textTheme.bodyLarge,
                ),
                const SizedBox(height: 20),
                FilledButton(
                  onPressed: () => addCategory(),
                  child: BlocBuilder<AddCategoryCubit, AddCategoryState>(
                    builder: (context, state) {
                      if (state is AddCategoryLoading) {
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
