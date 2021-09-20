import 'package:prototype2021/theme/cards/product_card_base.dart';

class ProductCard extends ProductCardBase {
  final ProductCardBaseProps props;
  ProductCard({required this.props}) : super.fromProps(props: props);
}
