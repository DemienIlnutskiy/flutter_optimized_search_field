import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:optimized_search_field/base_search_field.dart';

/// A widget that provides an optimized search field with dropdown options.
class OptimizedSearchField extends StatelessWidget {
  const OptimizedSearchField({
    required this.onChanged,
    required this.labelText,
    required this.dropDownList,
    required this.fieldSuffixIcon,
    this.itemStyle,
    this.listPadding = const EdgeInsets.symmetric(vertical: 16),
    this.itemsSpace,
    this.menuMaxHeight = 400,
    this.menuMargin = const EdgeInsets.only(top: 4, bottom: 8),
    this.menuDecoration,
    this.listClipBehavior = Clip.hardEdge,
    super.key,
    this.itemTextStyle,
    this.textFieldKey,
    this.showErrorText,
    this.errorText,
    this.controller,
    this.focusNode,
    this.description,
    this.isRequired,
    this.customTextField,
    this.fieldDecoration,
    this.usePrototype = true,
    this.fieldInputFormatters,
    this.optionsBuilder,
    this.labelTextStyle,
    this.optionsViewOpenDirection = OptionsViewOpenDirection.down,
    this.initValue,
    this.listItem,
    this.listKey,
    this.listItemKey,
    this.listCacheExtent,
    this.listAddSemanticIndexes = true,
    this.listController,
    this.listRestorationId,
    this.listSemanticChildCount,
    this.listDragStartBehavior = DragStartBehavior.start,
    this.listPhysics,
    this.listPrimary,
    this.fieldIconKey,
    this.menuList,
    this.useFindChildIndexCallback = true,
  });

  /// Callback for text change
  final void Function(String text)? onChanged;

  /// Label text for the search field
  final String? labelText;

  /// List of dropdown items
  final List<String> dropDownList;

  /// Whether to show the error text
  final bool? showErrorText;

  /// Error text for the search field
  final String? errorText;

  /// Controller for the search field
  final TextEditingController? controller;

  /// Focus node for the search field
  final FocusNode? focusNode;

  /// Key for the text field
  final Key? textFieldKey;

  /// Description for the search field
  final String? description;

  /// Whether the search field is required
  final bool? isRequired;

  /// Style for the dropdown items
  final TextStyle? itemTextStyle;

  /// Maximum height for the menu
  final double menuMaxHeight;

  /// Margin for the menu
  final EdgeInsets menuMargin;

  /// Decoration for the menu
  final BoxDecoration? menuDecoration;

  /// Padding for the list inside the menu
  final EdgeInsets listPadding;

  /// Space between items in the list
  final double? itemsSpace;

  /// Style for the items
  final ButtonStyle? itemStyle;

  /// Clip behavior for the list
  final Clip listClipBehavior;

  /// Decoration for the search field
  final InputDecoration? fieldDecoration;

  /// Suffix icon for the search field
  final Widget Function({
    required VoidCallback onCloseIconTap,
    required bool menuOpened,
    required VoidCallback onlyCloseMenu,
  })? fieldSuffixIcon;

  /// Whether to use the prototype
  final bool usePrototype;

  /// Input formatters for the search field
  final List<TextInputFormatter>? fieldInputFormatters;

  /// Options builder for the search field
  final FutureOr<Iterable<String>> Function(TextEditingValue)? optionsBuilder;

  /// Custom text field widget
  final Widget Function({
    required GlobalKey key,
    required Key? textFieldKey,
    required Widget? suffixIcon,
    required TextEditingController controller,
    required FocusNode focusNode,
    required void Function(String)? onChanged,
    required void Function(String)? onSubmitted,
  })? customTextField;

  /// Style for the label text
  final TextStyle? labelTextStyle;

  /// Direction for the options view
  final OptionsViewOpenDirection optionsViewOpenDirection;

  /// Initial value for the text field
  final TextEditingValue? initValue;

  final Key? listKey;

  final Key? listItemKey;

  /// Custom list item widget
  final Widget Function({
    required Key? key,
    required String value,
    required bool isEnabled,
    required int index,
    required void Function() onPressed,
  })? listItem;

  final double? listCacheExtent;
  final bool listAddSemanticIndexes;
  final ScrollController? listController;
  final String? listRestorationId;
  final int? listSemanticChildCount;
  final DragStartBehavior listDragStartBehavior;
  final ScrollPhysics? listPhysics;
  final bool? listPrimary;

  /// Whether to use the find child index callback
  final bool useFindChildIndexCallback;

  final Key? fieldIconKey;

  /// Custom list widget
  final Widget Function({
    required int length,
    required Widget Function(int index) item,
  })? menuList;

  @override
  Widget build(BuildContext context) {
    return BaseSearchField<String>(
      labelText: labelText,
      controller: controller,
      errorText: errorText,
      isRequired: isRequired,
      onChanged: onChanged,
      showErrorText: showErrorText,
      getItemText: (value) => value,
      item: (element) => Text(element, style: itemTextStyle),
      focusNode: focusNode,
      optionsBuilder: optionsBuilder ??
          (TextEditingValue textEditingValue) {
            if (textEditingValue.text.isEmpty || dropDownList.isEmpty) {
              return dropDownList;
            }

            return dropDownList.where(
              (element) => element.toLowerCase().contains(
                    textEditingValue.text.toLowerCase(),
                  ),
            );
          },
      onSelected: onChanged,
      textFieldKey: textFieldKey,
      description: description,
      menuMaxHeight: menuMaxHeight,
      menuDecoration: menuDecoration,
      listPadding: listPadding,
      itemsSpace: itemsSpace,
      itemStyle: itemStyle,
      listClipBehavior: listClipBehavior,
      fieldDecoration: fieldDecoration,
      fieldSuffixIcon: fieldSuffixIcon,
      usePrototype: usePrototype,
      fieldInputFormatters: fieldInputFormatters,
      labelTextStyle: labelTextStyle,
      optionsViewOpenDirection: optionsViewOpenDirection,
      initValue: initValue,
      listButtonItem: listItem,
      listKey: listKey,
      listItemKey: listItemKey,
      listCacheExtent: listCacheExtent,
      listAddSemanticIndexes: listAddSemanticIndexes,
      listController: listController,
      listRestorationId: listRestorationId,
      listSemanticChildCount: listSemanticChildCount,
      listDragStartBehavior: listDragStartBehavior,
      listPhysics: listPhysics,
      listPrimary: listPrimary,
      customTextField: customTextField,
      fieldIconKey: fieldIconKey,
      menuList: menuList,
      useFindChildIndexCallback: useFindChildIndexCallback,
    );
  }
}
