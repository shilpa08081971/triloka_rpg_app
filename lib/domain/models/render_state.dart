// lib/domain/models/render_state.dart
import 'package:flutter/material.dart';

class RenderState {

  const RenderState({
    this.ambientIntensity = 0.2,
    this.lightPosition = const Offset(0, -1),
    this.shadowSoftness = 1.0,
    this.enablePostProcessing = true,
    this.enableBloom = true,
    this.enableNormalMapping = true,
  });
  final double ambientIntensity;
  final Offset lightPosition;
  final double shadowSoftness;
  final bool enablePostProcessing;
  final bool enableBloom;
  final bool enableNormalMapping;

  RenderState copyWith({
    double? ambientIntensity,
    Offset? lightPosition,
    double? shadowSoftness,
    bool? enablePostProcessing,
    bool? enableBloom,
    bool? enableNormalMapping,
  }) {
    return RenderState(
      ambientIntensity: ambientIntensity ?? this.ambientIntensity,
      lightPosition: lightPosition ?? this.lightPosition,
      shadowSoftness: shadowSoftness ?? this.shadowSoftness,
      enablePostProcessing: enablePostProcessing ?? this.enablePostProcessing,
      enableBloom: enableBloom ?? this.enableBloom,
      enableNormalMapping: enableNormalMapping ?? this.enableNormalMapping,
    );
  }
}
