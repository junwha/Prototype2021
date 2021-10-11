import 'package:flutter_test/flutter_test.dart';
import 'package:prototype2021/loader/board/plan_loader.dart';
import 'package:prototype2021/model/board/plan/http/plan.dart';
import 'package:prototype2021/model/board/plan/plan_dto.dart';
import 'package:prototype2021/utils/safe_http/base.dart';

import 'login_loader_test.dart';

void main() {
  setUpAll(() async {
    token = await login();
  });
  group("[Class] PlanLoader", testPlanLoader);
}

String token = "";
List<PlanPreview>? sampleData;
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
    PlanListInput params = new PlanListInput();
    SafeQueryInput<PlanListInput> dto = new SafeQueryInput(
        url: planLoader!.planListUrl, params: params, token: token);
    SafeQueryOutput<PlanListOutput> result = await planLoader!.planList(dto);
    print(result.error?.message);
    print(result.data?.results);
    expect(result.data?.results != null, true);
    expect(result.data!.results is List<PlanPreview>, true);
    expect(result.data!.count > 0, true);
    expect(result.data!.previous, null);
    sampleData = result.data!.results;
  });
}

void testGetPlanDetail() {
  test('should get detail', () async {
    await Future.forEach<PlanPreview>(sampleData!, (datum) async {
      PlanIdInput params = PlanIdInput(id: datum.id);
      SafeQueryInput<PlanIdInput> dto = SafeQueryInput(
          url: planLoader!.planIdUrl, params: params, token: token);
      SafeQueryOutput<PlanDetailOutput> result =
          await planLoader!.planDetail(dto);

      print(result.error?.message);
      expect(result.data?.result != null, true);
    });
  });
}
