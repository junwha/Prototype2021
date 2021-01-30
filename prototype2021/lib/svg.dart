import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

Map<String, String> svgLink = {'ticket': 'assets/ticket.svg'};

class SVG extends StatelessWidget {
  final String name;

  const SVG(this.name);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(svgLink[this.name], semanticsLabel: this.name);
  }
}
