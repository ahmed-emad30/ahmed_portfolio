import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

/// Paints [child] once, split down the middle like a curtain.
///
/// [progress] `0` = closed (full screen), `1` = open (halves off-screen).
class CurtainSplit extends SingleChildRenderObjectWidget {
  const CurtainSplit({
    super.key,
    required this.progress,
    required Widget child,
  }) : super(child: child);

  final double progress;

  @override
  RenderCurtainSplit createRenderObject(BuildContext context) {
    return RenderCurtainSplit(progress: progress);
  }

  @override
  void updateRenderObject(
    BuildContext context,
    RenderCurtainSplit renderObject,
  ) {
    renderObject.progress = progress;
  }
}

class RenderCurtainSplit extends RenderProxyBox {
  RenderCurtainSplit({required double progress}) : _progress = progress;

  double _progress;

  double get progress => _progress;

  set progress(double value) {
    if (_progress == value) return;
    _progress = value;
    markNeedsPaint();
  }

  @override
  bool get alwaysNeedsCompositing => child != null && _progress > 0;

  @override
  void paint(PaintingContext context, Offset offset) {
    final child = this.child;
    if (child == null) return;

    if (_progress <= 0) {
      context.paintChild(child, offset);
      return;
    }

    final width = size.width;
    final height = size.height;
    final dx = (width * 0.5) * _progress.clamp(0.0, 1.0);

    context.pushClipRect(
      needsCompositing,
      offset,
      Rect.fromLTWH(0, 0, width * 0.5, height),
      (PaintingContext ctx, Offset off) {
        ctx.paintChild(child, off + Offset(-dx, 0));
      },
    );

    context.pushClipRect(
      needsCompositing,
      offset,
      Rect.fromLTWH(width * 0.5, 0, width * 0.5, height),
      (PaintingContext ctx, Offset off) {
        ctx.paintChild(child, off + Offset(dx, 0));
      },
    );
  }
}
