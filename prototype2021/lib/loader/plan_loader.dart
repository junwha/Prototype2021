import 'dart:io';

import 'package:prototype2021/data/dto/plan/plan_dto.dart';
import 'package:prototype2021/loader/safe_http.dart';
import 'package:prototype2021/model/safe_http_dto/base.dart';
import 'package:prototype2021/model/safe_http_dto/get/plan.dart';
import 'package:prototype2021/model/safe_http_dto/output_dto_factory.dart';
import 'package:prototype2021/model/safe_http_dto/patch/heart.dart';
import 'package:prototype2021/settings/constants.dart';

enum PaginationState {
  start,
  mid,
  end,
}

enum PlanLoaderMode {
  board,
  wishlist,
  mylist,
  general,
}

class PlanLoader {
  PaginationState pagination = PaginationState.start;

  // Custom Functions
  Future<void> heartPlan(String planId, String token) async {
    PlanHeartInput params = new PlanHeartInput(planId: planId);
    SafeMutationInput<PlanHeartInput> dto =
        new SafeMutationInput<PlanHeartInput>(
            data: params, url: planHeartUrl, token: token);
    SafeMutationOutput<PlanHeartOutput> result = await planHeart(dto);
    if (!result.success)
      throw HttpException(result.error?.message ?? "Unexpected error");
  }

  Future<List<PlanPreview>> getPlanList(String token) async {
    if (pagination == PaginationState.end) return [];

    PlanListInput params = PlanListInput();

    SafeQueryInput<PlanListInput> dto = SafeQueryInput<PlanListInput>(
        params: params, url: planListUrl, token: token);
    SafeQueryOutput<PlanListOutput> result = await planList(dto);

    if (result.success) {
      if (result.data!.next != null) {
        planListUrl = result.data!.next!
            .replaceFirst("tbserver:8000", "api.tripbuilder.co.kr");
        pagination = PaginationState.mid;
      } else {
        planListUrl = "";
        pagination = PaginationState.end;
      }
      return result.data!.results;
    }
    throw HttpException(result.error?.message ?? "Unexpected error");
  }

  Future<PlanDetail> getPlanDetail({required int id, String? token}) async {
    PlanIdInput params = PlanIdInput(id);
    SafeQueryInput<PlanIdInput> dto = SafeQueryInput<PlanIdInput>(
        params: params, url: planIdUrl, token: token);
    SafeQueryOutput<PlanDetailOutput> result = await planDetail(dto);

    if (result.success) {
      return result.data!.result;
    }

    throw HttpException(result.error?.message ?? "Unexpected error");
  }

  Future<bool> deletePlan({required int id, String? token}) async {
    PlanIdInput params = PlanIdInput(id);
    SafeQueryInput<PlanIdInput> dto = SafeQueryInput<PlanIdInput>(
        params: params, url: planIdUrl, token: token);
    SafeQueryOutput<PlanDeleteOutput> result = await planDelete(dto);
    if (result.success) return true;

    return false;
  }
  // Fetching Functions

  Future<SafeMutationOutput<PlanHeartOutput>> planHeart(
          SafeMutationInput<PlanHeartInput> dto) async =>
      await safePatch<PlanHeartInput, PlanHeartOutput>(dto);

  Future<SafeQueryOutput<PlanListOutput>> planList(
          SafeQueryInput<PlanListInput> dto) async =>
      await safeGET<PlanListInput, PlanListOutput>(dto);

  Future<SafeQueryOutput<PlanDetailOutput>> planDetail(
          SafeQueryInput<PlanIdInput> dto) async =>
      await safeGET<PlanIdInput, PlanDetailOutput>(dto);
  Future<SafeQueryOutput<PlanDeleteOutput>> planDelete(
          SafeQueryInput<PlanIdInput> dto) async =>
      await safeDELETE<PlanIdInput, PlanDeleteOutput>(dto);

  // Endpoints

  String planHeartUrl = "$apiBaseUrl/plan/:planId/like";
  String planListUrl = "$apiBaseUrl/plans";
  String planIdUrl = "$apiBaseUrl/plans/:id";

  PlanLoader(PlanLoaderMode mode) {
    if (mode == PlanLoaderMode.board) {
      planListUrl = "$apiBaseUrl/plans";
    } else if (mode == PlanLoaderMode.mylist) {
      planListUrl = "$apiBaseUrl/plans/mylist/";
    } else if (mode == PlanLoaderMode.wishlist) {
      planListUrl = "$apiBaseUrl/plans/wishlists/";
    }
  }
}
