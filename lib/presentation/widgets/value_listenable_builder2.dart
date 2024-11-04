// lib/presentation/widgets/value_listenable_builder2.dart
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ValueListenableBuilder2<A, B> extends StatelessWidget {

  const ValueListenableBuilder2({
    required this.first, required this.second, required this.builder, super.key,
    this.child,
  });
  final ValueListenable<A> first;
  final ValueListenable<B> second;
  final Widget? child;
  final Widget Function(BuildContext context, A a, B b, Widget? child) builder;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<A>(
      valueListenable: first,
      builder: (_, a, __) {
        return ValueListenableBuilder<B>(
          valueListenable: second,
          builder: (context, b, __) {
            return builder(context, a, b, child);
          },
        );
      },
    );
  }
}
