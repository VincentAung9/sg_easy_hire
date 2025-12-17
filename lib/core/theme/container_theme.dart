import 'package:flutter/material.dart';

class ContainerTheme extends ThemeExtension<ContainerTheme> {

  const ContainerTheme({required this.card});
  final BoxDecoration card;

  @override
  ContainerTheme copyWith({BoxDecoration? card}) {
    return ContainerTheme(card: card ?? this.card);
  }

  @override
  ThemeExtension<ContainerTheme> lerp(
    ThemeExtension<ContainerTheme>? other,
    double t,
  ) {
    if (other is! ContainerTheme) return this;

    return ContainerTheme(
      card: BoxDecoration(
        color: Color.lerp(card.color, other.card.color, t),
        borderRadius: BorderRadius.lerp(
          card.borderRadius as BorderRadius?,
          other.card.borderRadius as BorderRadius?,
          t,
        ),
        boxShadow: BoxShadow.lerpList(card.boxShadow, other.card.boxShadow, t),
      ),
    );
  }
}
