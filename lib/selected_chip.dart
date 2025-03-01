part of 'base_multi_search_field.dart';

class _SelectedChipWidget extends StatelessWidget {
  const _SelectedChipWidget({
    required this.labelText,
    required this.onPressed,
    this.style,
    this.textStyle,
    this.maxLines = 2,
    this.clipBehavior = Clip.hardEdge,
    this.textAlign = TextAlign.center,
    this.textOverflow = TextOverflow.ellipsis,
    this.icon = const Icon(Icons.close),
    this.spacing = 8,
    this.widgetKey,
  });

  final Key? widgetKey;

  // Label text for the chip
  final String labelText;

  // Callback for the chip press
  final void Function()? onPressed;

  // Style for the chip
  final ButtonStyle? style;

  // Text style for the chip
  final TextStyle? textStyle;

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
      key: widgetKey,
      style: buttonStyle,
      clipBehavior: clipBehavior ?? Clip.hardEdge,
      onPressed: onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          icon ?? const Icon(Icons.close),
          SizedBox(
            width: spacing ?? 8,
          ),
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

final defaultCancelChipButtonStyle = TextButton.styleFrom(
  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  alignment: Alignment.center,
  backgroundColor: const Color(0xffc4fffc),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(32)),
  ),
);
