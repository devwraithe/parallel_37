import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {
  const SearchField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 244, 244, 244),
        borderRadius: BorderRadius.circular(100),
      ),
      padding: const EdgeInsets.only(
        top: 3,
      ),
      child: TextFormField(
        strutStyle: StrutStyle.disabled,
        autofocus: false,
        keyboardType: TextInputType.text,
        textCapitalization: TextCapitalization.characters,
        textInputAction: TextInputAction.search,
        textAlign: TextAlign.left,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(100),
            borderSide: BorderSide.none,
          ),
          isDense: true,
          hintText: "Search will be live soon!",
          alignLabelWithHint: true,
          hintStyle: Theme.of(context).textTheme.bodyText1?.copyWith(
                color: Colors.grey,
                fontWeight: FontWeight.w500,
              ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 28,
            vertical: 16,
          ),
          labelStyle: Theme.of(context).textTheme.bodyText1?.copyWith(
                color: Colors.grey,
                fontWeight: FontWeight.w500,
              ),
        ),
        style: Theme.of(context).textTheme.bodyText1?.copyWith(
              color: Colors.white,
            ),
      ),
    );
  }
}
