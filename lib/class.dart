part of simple_code;

class SimpleCode {
  final BuildContext context;
  final heigthEmulator;
  final widthEmulator;
  SimpleCode(
      {@required this.context,
      this.heigthEmulator = 640.0,
      this.widthEmulator = 360.0});
  expandedIcon(Icon icon, {maxSize = double.maxFinite, double minSize = 2}) {
    return new LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        double size = min(constraints.maxHeight, constraints.maxWidth);
        if (size < minSize) {
          size = minSize;
        } else if (size > maxSize) {
          size = maxSize;
        }
        return new Icon(
          icon.icon,
          color: icon.color,
          key: icon.key,
          semanticLabel: icon.semanticLabel,
          textDirection: icon.textDirection,
          size: widget(
            size: size,
            heigthEmu: MediaQuery.of(context).size.height,
            widthEmu: MediaQuery.of(context).size.width,
          ),
        );
      },
    );
  }

  Widget expandedText(
    Text textWidget, {
    AutoSizeGroup group,
    double maxFontSize = double.infinity,
    double minFontSize = 6,
    Widget overflowReplacement,
    List<double> presetFontSizes,
    double stepGranularity = 1,
    bool wrapWords = true,
  }) {
    TextStyle textStyle = new TextStyle(fontSize: double.maxFinite);
    if (textWidget.style != null) {
      textStyle.merge(textWidget.style);
    }
    return new AutoSizeText(
      textWidget.data,
      overflow: textWidget.overflow,
      key: textWidget.key,
      locale: textWidget.locale,
      maxLines: textWidget.maxLines,
      softWrap: textWidget.softWrap,
      textScaleFactor: textWidget.textScaleFactor,
      style: textStyle,
      strutStyle: textWidget.strutStyle,
      semanticsLabel: textWidget.semanticsLabel,
      textAlign: textWidget.textAlign,
      textDirection: textWidget.textDirection,
      group: group,
      maxFontSize: maxFontSize,
      minFontSize: minFontSize,
      overflowReplacement: overflowReplacement,
      presetFontSizes: presetFontSizes,
      stepGranularity: stepGranularity,
      wrapWords: wrapWords,
    );
  }

  widget({
    @required double size,
    double heigthEmu,
    double widthEmu,
  }) {
    if (heigthEmu == null) {
      heigthEmu = heigthEmulator;
    }
    if (widthEmu == null) {
      widthEmu = widthEmulator;
    }
    try {
      size = min((size / heigthEmu) * MediaQuery.of(context).size.height,
          (size / widthEmu) * MediaQuery.of(context).size.width);
    } catch (error) {
      String erro = "";
      if (size == null) {
        erro = "${erro}size == null";
      }
      if (context == null) {
        erro = "$erro\ncontext == null";
      }
      if (erro.length == 0) {
        erro = error;
      }
      throw (erro);
    }
    return size;
  }

  color(var color) {
    return _allColors(color);
  }

  navigator(
      {Duration duration,
      NavFrom navFrom = NavFrom.rigth,
      NavFrom secondNavFrom,
      NavType navType = NavType.push,
      Widget page,
      Curve curves = Curves.linear}) {
    _customNavigator(
      context,
      duration: duration,
      navFrom: navFrom,
      secondNavFrom: secondNavFrom,
      navType: navType,
      page: page,
      curve:curves,
    );
  }
}
