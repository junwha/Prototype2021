import 'package:flutter_test/flutter_test.dart';
import 'package:prototype2021/loader/board/plan_loader.dart';
import 'package:prototype2021/model/board/plan/http/plan.dart';
import 'package:prototype2021/model/board/plan/plan_dto.dart';
import 'package:prototype2021/utils/safe_http/base.dart';
import 'package:prototype2021/widgets/cards/product_card.dart';

import 'login_loader_test.dart';

void main() {
  setUpAll(() async {
    token = await login();
  });
  group("[Class] PlanLoader", testPlanLoader);
}

String token = "";
List<ProductCardBaseProps>? sampleData;
PlanLoader? planLoader;

void testPlanLoader() {
  planLoader = new PlanLoader.withMode(mode: PlanLoaderMode.board);
  /* 
   * Only 2 methods are tested.
   * Additional tests required in a near future
  */
  group('getPlanList', testGetPlanList);
  group('getPlanDetail', testGetPlanDetail);
}

void testGetPlanList() {
  test('should get the response', () async {
    List<ProductCardBaseProps> result =
        await planLoader!.getPlanList(token, true);
    expect(result.length > 0, true);
    sampleData = result;
  });
}

void testGetPlanDetail() {
  test('should get detail', () async {
    await Future.forEach<ProductCardBaseProps>(sampleData!, (datum) async {
      bool success = true;
      try {
        await planLoader!.getPlanDetail(id: datum.id);
      } catch (e) {
        success = false;
      }
      expect(success, true);
    });
  });
}
