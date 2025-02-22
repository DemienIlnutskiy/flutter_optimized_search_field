part of 'based_multi_search_field.dart';

class _SelectedChipWidget extends StatelessWidget {
  const _SelectedChipWidget({
    required this.labelText,
    required this.onPressed,
    Key? key,
    this.style,
    this.textStyle,
    this.padding,
    this.maxLines = 2,
    this.clipBehavior = Clip.hardEdge,
    this.textAlign = TextAlign.center,
    this.textOverflow = TextOverflow.ellipsis,
    this.icon = const Icon(Icons.close),
    this.spacing = 8,
  }) : super(key: key);

  // Label text for the chip
  final String labelText;

  // Callback for the chip press
  final void Function()? onPressed;

  // Style for the chip
  final ButtonStyle? style;

  // Text style for the chip
  final TextStyle? textStyle;

  // Padding for the chip
  final EdgeInsets? padding;

  // Maximum number of lines for the chip text
  final int? maxLines;

  // Clip behavior for the chip
  final Clip? clipBehavior;

  // Text alignment for the chip text
  final TextAlign? textAlign;

  // Text overflow for the chip text
  final TextOverflow? textOverflow;

  // Icon for the chip
  final Widget? icon;

  // Spacing for the chip
  final double? spacing;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: padding == null
          ? buttonStyle
          : buttonStyle.copyWith(padding: WidgetStatePropertyAll(padding)),
      clipBehavior: clipBehavior ?? Clip.hardEdge,
      onPressed: onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: spacing ?? 8,
        children: [
          icon ?? const Icon(Icons.close),
          Flexible(child: textWidget),
        ],
      ),
    );
  }

  ButtonStyle get buttonStyle => style ?? defaultCancelChipButtonStyle;

  Widget get textWidget => Text(
        labelText,
        textAlign: textAlign ?? TextAlign.center,
        maxLines: maxLines,
        overflow: textOverflow ?? TextOverflow.ellipsis,
        style: textStyle,
      );
}

const defaultCancelChipButtonStyle = ButtonStyle(
  padding: WidgetStatePropertyAll(
    EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  ),
  alignment: Alignment.center,
  backgroundColor: WidgetStatePropertyAll(Color(0xffc4fffc)),
  shape: WidgetStatePropertyAll(
    RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(32))),
  ),
);
