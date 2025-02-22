import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:optimized_search_field/optimized_search_field.dart';

part 'selected_chip.dart';

/// A basic multi-select search field widget with customizable options.
class BasicMultiSearchField<T extends Object> extends StatefulWidget {
  const BasicMultiSearchField({
    required this.onChanged,
    required this.labelText,
    required this.dropDownList,
    required this.values,
    required this.removeEvent,
    required this.showErrorText,
    required this.errorText,
    required this.item,
    required this.optionsBuilder,
    required this.getItemText,
    this.selectListSpacing = 8,
    this.selectListItemSpacing = 8,
    this.selectListItemRunSpacing = 8,
    this.menuMaxHeight = 400,
    this.menuMargin = const EdgeInsets.only(top: 4, bottom: 8),
    this.listPadding = const EdgeInsets.symmetric(vertical: 16),
    this.listClipBehavior = Clip.hardEdge,
    this.fieldActiveIcon = const Icon(Icons.close),
    this.fieldInactiveIcon = const Icon(Icons.arrow_drop_down),
    this.usePrototype = true,
    this.textFieldKey,
    this.isRequired,
    Key? key,
    this.trailingList,
    this.unfocusSuffixIcon,
    this.suffixIconPadding,
    this.focusNode,
    this.errorMaxLines,
    this.description,
    this.allElements,
    this.menuDecoration,
    this.itemsSpace,
    this.itemStyle,
    this.fieldDecoration,
    this.fieldSuffixIcon,
    this.customTextField,
    this.selectedWidget,
    this.selectedItemMaxLines,
    this.selectedItemStyle,
    this.selectedItemTextStyle,
    this.selectedItemClipBehavior,
    this.selectedItemIcon,
    this.selectedItemSpacing,
    this.selectedItemTextAlign,
    this.selectedItemTextOverflow,
    this.fieldInputFormatters,
    this.controller,
    this.labelTextStyle,
    this.optionsViewOpenDirection = OptionsViewOpenDirection.down,
    this.listItem,
  }) : super(key: key);

  // Callback for text change
  final void Function(String text)? onChanged;

  // Label text for the search field
  final String labelText;

  // List of dropdown items
  final List<T> dropDownList;

  // Whether to show the error text
  final bool? showErrorText;

  // Error text for the search field
  final String? errorText;

  // List of selected values
  final List<T>? values;

  // Callback for removing an item
  final void Function(T value)? removeEvent;

  // Focus node for the search field
  final FocusNode? focusNode;

  // List of trailing widgets
  final List<Widget>? trailingList;

  // Widget for each item in the dropdown
  final Widget Function(T element) item;

  // Function to build the options for the dropdown
  final FutureOr<Iterable<T>> Function(TextEditingValue) optionsBuilder;

  // Suffix icon for the search field when unfocused
  final Icon? unfocusSuffixIcon;

  // Function to get the text for an item
  final String Function(T value)? getItemText;

  // Padding for the suffix icon
  final double? suffixIconPadding;

  // Key for the text field
  final Key? textFieldKey;

  // Maximum number of lines for the error text
  final int? errorMaxLines;

  // Description for the search field
  final String? description;

  // All elements text
  final T? allElements;

  // Whether the search field is required
  final bool? isRequired;

  // Spacing between selected items
  final double selectListSpacing;

  // Spacing between items in the list
  final double selectListItemSpacing;

  // Run spacing between items in the list
  final double selectListItemRunSpacing;

  // Maximum height for the menu
  final double menuMaxHeight;

  // Margin for the menu
  final EdgeInsets menuMargin;

  // Decoration for the menu
  final BoxDecoration? menuDecoration;

  // Padding for the list inside the menu
  final EdgeInsets listPadding;

  // Space between items in the list
  final double? itemsSpace;

  // Style for the items
  final ButtonStyle? itemStyle;

  // Clip behavior for the list
  final Clip listClipBehavior;

  // Decoration for the search field
  final InputDecoration? fieldDecoration;

  // Active icon for the search field
  final Icon fieldActiveIcon;

  // Inactive icon for the search field
  final Icon fieldInactiveIcon;

  // Suffix icon for the search field
  final Widget? fieldSuffixIcon;

  // Whether to use the prototype
  final bool usePrototype;

  // Custom text field widget
  final Widget Function({required Widget suffixIcon, required GlobalKey key})?
      customTextField;

  // Widget for the selected item
  final Widget Function(T value)? selectedWidget;

  // Maximum number of lines for the selected item
  final int? selectedItemMaxLines;

  // Style for the selected item
  final ButtonStyle? selectedItemStyle;

  // Text style for the selected item
  final TextStyle? selectedItemTextStyle;

  // Clip behavior for the selected item
  final Clip? selectedItemClipBehavior;

  // Icon for the selected item
  final Widget? selectedItemIcon;

  // Spacing for the selected item
  final double? selectedItemSpacing;

  // Text alignment for the selected item
  final TextAlign? selectedItemTextAlign;

  // Text overflow for the selected item
  final TextOverflow? selectedItemTextOverflow;

  // Input formatters for the search field
  final List<TextInputFormatter>? fieldInputFormatters;

  // Controller for the search field
  final TextEditingController? controller;

  final TextStyle? labelTextStyle;

  final OptionsViewOpenDirection optionsViewOpenDirection;

  // Custom list item widget
  final Widget Function({
    required T value,
    required bool isEnabled,
    required int index,
    required void Function() onPressed,
  })? listItem;

  @override
  State<BasicMultiSearchField<T>> createState() =>
      _BasicMultiSearchFieldState<T>();
}

class _BasicMultiSearchFieldState<T extends Object>
    extends State<BasicMultiSearchField<T>> {
  late TextEditingController controller;
  late FocusNode focusNode;

  @override
  void initState() {
    super.initState();
    _initializeController();
  }

  void _initializeController() {
    controller = widget.controller ?? TextEditingController();
    focusNode = (widget.focusNode ?? FocusNode())
      ..onKeyEvent = _handleKeyEvent
      ..addListener(_unFocusData);
  }

  void _unFocusData() {
    if (!focusNode.hasFocus && controller.text.isNotEmpty) {
      widget.onChanged?.call(controller.text);
      controller.clear();
    }
  }

  KeyEventResult _handleKeyEvent(FocusNode node, KeyEvent keyEvent) {
    if (controller.text.trim().isNotEmpty &&
        keyEvent is KeyDownEvent &&
        keyEvent.logicalKey == LogicalKeyboardKey.enter) {
      widget.onChanged?.call(controller.text);
      focusNode.unfocus();
      controller.clear();
      return KeyEventResult.handled;
    }
    return KeyEventResult.ignored;
  }

  bool get selectedValueIsNotEmpty {
    if (widget.values == null && widget.allElements != null) return true;
    if (widget.values != null && widget.values!.isNotEmpty) return true;
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: widget.selectListSpacing,
      children: [
        BasicSearchField<T>(
          isRequired: widget.isRequired,
          textFieldKey: widget.textFieldKey,
          labelText: widget.labelText,
          controller: controller,
          errorText: widget.errorText,
          onChanged: null,
          focusNode: focusNode,
          showErrorText: widget.showErrorText,
          optionsBuilder: widget.optionsBuilder,
          unfocusSuffixIcon: widget.unfocusSuffixIcon,
          items: widget.item,
          errorMaxLines: widget.errorMaxLines,
          description: widget.description,
          unenabledList: widget.values == null ||
                  (widget.values?.contains(widget.allElements) ?? false)
              ? null
              : widget.dropDownList
                  .where(
                    (element) => widget.values!.any(
                      (value) => (getItemText(element)) == value,
                    ),
                  )
                  .toList(),
          onSelected: (value) {
            widget.onChanged?.call(getItemText(value));
            controller.clear();
            focusNode.unfocus();
          },
          onFieldSubmitted: (value) {
            if (value.trim().isNotEmpty) {
              widget.onChanged?.call(value);
              controller.clear();
              focusNode.unfocus();
            }
          },
          isLoading: widget.dropDownList.isEmpty,
          menuMaxHeight: widget.menuMaxHeight,
          menuMargin: widget.menuMargin,
          menuDecoration: widget.menuDecoration,
          listPadding: widget.listPadding,
          itemsSpace: widget.itemsSpace,
          itemStyle: widget.itemStyle,
          listClipBehavior: widget.listClipBehavior,
          fieldDecoration: widget.fieldDecoration,
          fieldActiveIcon: widget.fieldActiveIcon,
          fieldInactiveIcon: widget.fieldInactiveIcon,
          fieldSuffixIcon: widget.fieldSuffixIcon,
          usePrototype: widget.usePrototype,
          customTextField: widget.customTextField,
          fieldInputFormatters: widget.fieldInputFormatters,
          labelTextStyle: widget.labelTextStyle,
          optionsViewOpenDirection: widget.optionsViewOpenDirection,
          listItem: widget.listItem,
        ),
        if (selectedValueIsNotEmpty)
          Wrap(
            spacing: widget.selectListItemSpacing,
            runSpacing: widget.selectListItemRunSpacing,
            children: List.generate(
              widget.values?.length ?? (widget.allElements != null ? 1 : 0),
              (index) =>
                  widget.selectedWidget?.call(getValue(index)) ??
                  _SelectedChipWidget(
                    labelText: getItemText(getValue(index)),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    onPressed: () => widget.removeEvent?.call(getValue(index)),
                    maxLines: widget.selectedItemMaxLines,
                    style: widget.selectedItemStyle,
                    textStyle: widget.selectedItemTextStyle,
                    clipBehavior: widget.selectedItemClipBehavior,
                    icon: widget.selectedItemIcon,
                    spacing: widget.selectListItemSpacing,
                    textAlign: widget.selectedItemTextAlign,
                    textOverflow: widget.selectedItemTextOverflow,
                  ),
            ),
          ),
      ],
    );
  }

  T getValue(int index) => widget.values!.elementAt(index);

  String getItemText(T value) =>
      widget.getItemText?.call(value) ?? value.toString();

  @override
  void dispose() {
    focusNode.removeListener(_unFocusData);
    if (widget.controller == null) controller.dispose();
    if (widget.focusNode == null) focusNode.dispose();
    super.dispose();
  }
}
