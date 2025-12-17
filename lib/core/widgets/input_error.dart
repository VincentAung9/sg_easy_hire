import 'package:flutter/material.dart';

class InputError extends StatelessWidget {
  final bool isError;
  final String? error;
  final Widget? child;
  const InputError({
    required this.isError,
    this.error,
    super.key,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return isError
        ? child ??
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  error ?? "",
                  style: textTheme.bodySmall?.copyWith(
                    color: Colors.red,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )
        : const SizedBox();
  }
}
