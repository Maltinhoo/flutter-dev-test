import 'package:flutter/material.dart';
import 'package:flutter_dev_test/app_imports.dart';

class CustomButton extends StatefulWidget {
  final String label;
  final VoidCallback? onTap;
  final Color? color;
  final double? width;
  final Color? labelColor;
  final BoxBorder? border;
  final bool enabled;
  final IconData? prefixIcon;
  final bool isLoading;

  const CustomButton({
    super.key,
    required this.label,
    this.onTap,
    this.color,
    this.width,
    this.labelColor,
    this.border,
    this.enabled = true,
    this.prefixIcon,
    this.isLoading = false,
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !widget.enabled || widget.isLoading,
      child: InkWell(
        onTap: widget.onTap,
        borderRadius: BorderRadius.circular(10),
        child: Padding(
          padding: const EdgeInsets.all(1),
          child: Container(
            width: widget.width,
            padding: const EdgeInsets.symmetric(horizontal: 43, vertical: 16),
            decoration: BoxDecoration(
              color: widget.enabled
                  ? widget.color ?? const Color(0xff7A5D3E)
                  : const Color(0xff7A5D3E).withOpacity(.5),
              borderRadius: BorderRadius.circular(10),
              border: widget.border,
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                AnimatedOpacity(
                  opacity: widget.isLoading ? 0.0 : 1.0,
                  duration: const Duration(milliseconds: 300),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (widget.prefixIcon != null) ...[
                        Icon(widget.prefixIcon,
                            size: 24, color: widget.labelColor ?? Colors.white),
                        const SizedBox(width: 12),
                      ],
                      CustomText(
                        widget.label,
                        maxLines: 1,
                        textAlign: TextAlign.center,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                        size: 16,
                        autosize: true,
                      ),
                    ],
                  ),
                ),
                if (widget.isLoading)
                  SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        widget.labelColor ?? Colors.white,
                      ),
                      strokeWidth: 2,
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
