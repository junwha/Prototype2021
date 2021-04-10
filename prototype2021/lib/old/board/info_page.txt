import 'package:flutter/material.dart';
import 'package:prototype2021/templates/info_card.dart';
import 'package:prototype2021/templates/product_card.dart';

class InfoPage extends StatefulWidget {
  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ProductCard(
            preview: 'images/preview.png',
            title: '포르투갈',
            cost: 10000000,
            period: '4주',
            tags: ['여행 감상', '맛집 탐방', '액티비티'],
            matchPercent: 99,
            tendencies: [0, 1, 2],
            onTap: () {},
          ),
          InfoCard(),
          InfoCard(),
          InfoCard(),
        ],
      ),
    );
  }
}
