part of simple_code;

class AnimatedTween extends StatefulWidget {
  const AnimatedTween({
    Key key,
    @required this.child,
    this.duration = const Duration(milliseconds: 600),
    this.curve = Curves.fastOutSlowIn,
    this.delay,
    this.stopped = false,
    this.angle,
    this.opacity,
    this.scale,
    this.offset,
  })  : assert(opacity == null || opacity >= 0 && opacity <= 1),
        super(key: key);
  final Widget child;
  final Duration duration;
  final Curve curve;
  final double angle;
  final double scale;
  final Duration delay;
  final double opacity;
  final Offset offset;
  final bool stopped;

  @override
  _AnimatedTweenState createState() => _AnimatedTweenState();
}

class _AnimatedTweenState extends State<AnimatedTween> {
  bool stopped = true;
  @override
  void initState() {
    _initState();
    super.initState();
  }

  void _initState() {
    if (!widget.stopped) {
      if (widget.delay != null) {
        Future.delayed(widget.delay)
            .whenComplete(() => setState(() => stopped = false));
      } else {
        stopped = false;
      }
    }
  }

  @override
  void didUpdateWidget(AnimatedTween oldWidget) {
    if (oldWidget.stopped != widget.stopped) {
      setState(() {
        stopped = true;
      });
      _initState();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return _buildScale(
      _buildAngle(
        _buildOpacity(
          _buildOffset(widget.child),
        ),
      ),
    );
  }

  Widget _buildScale(Widget child) {
    if (widget.scale != null) {
      final double begin = widget.scale;
      return _buildTween(
        child: child,
        tween: Tween(begin: begin, end: stopped ? begin : 1),
        animationBulder: (Widget child, double animationValue) {
          return Transform.scale(
            scale: animationValue,
            child: child,
          );
        },
      );
    }
    return child;
  }

  Widget _buildAngle(Widget child) {
    if (widget.angle != null) {
      final double begin = widget.angle * pi / 180;
      return _buildTween(
        child: child,
        tween: Tween(begin: begin, end: stopped ? begin : 0),
        animationBulder: (Widget child, double animationValue) {
          return Transform.rotate(
            angle: animationValue,
            child: child,
          );
        },
      );
    }
    return child;
  }

  Widget _buildOpacity(Widget child) {
    if (widget.opacity != null) {
      final double begin = widget.opacity;
      return _buildTween(
        child: child,
        tween: Tween(begin: begin, end: stopped ? begin : 1),
        animationBulder: (Widget child, double animationValue) {
          return Opacity(
            opacity: animationValue,
            child: child,
          );
        },
      );
    }
    return child;
  }

  Widget _buildOffset(Widget child) {
    if (widget.offset != null) {
      final double begin = 1;
      return _buildTween(
        child: child,
        tween: Tween(begin: begin, end: stopped ? begin : 0),
        animationBulder: (Widget child, double value) {
          return Transform.translate(
            offset: Offset(widget.offset.dx * value, widget.offset.dy * value),
            child: child,
          );
        },
      );
    }
    return child;
  }

  Widget _buildTween(
      {@required
          Widget Function(Widget child, double animationValue) animationBulder,
      @required
          Widget child,
      @required
          Tween<double> tween}) {
    return TweenAnimationBuilder(
      duration: widget.duration,
      tween: tween,
      curve: widget.curve,
      child: child,
      builder: (_, double value, Widget child) {
        return animationBulder(child, value);
      },
    );
  }
}
