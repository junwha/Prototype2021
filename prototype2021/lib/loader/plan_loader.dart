import 'dart:io';

import 'package:flutter/services.dart';
import 'package:prototype2021/data/dto/plan/plan_preview.dart';
import 'package:prototype2021/loader/safe_http.dart';
import 'package:prototype2021/model/safe_http_dto/base.dart';
import 'package:prototype2021/model/safe_http_dto/common.dart';
import 'package:prototype2021/model/safe_http_dto/get/plan.dart';
import 'package:prototype2021/model/safe_http_dto/get/verification.dart';
import 'package:prototype2021/model/safe_http_dto/patch/heart.dart';
import 'package:prototype2021/settings/constants.dart';

enum PaginationState {
  start,
  mid,
  end,
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
        planListUrl = result.data!.next!;
        pagination = PaginationState.mid;
      } else {
        planListUrl = "";
        pagination = PaginationState.end;
      }
      return result.data!.results;
    }

    print(result.error!);
    return [];
  }

  // Fetching Functions

  Future<SafeMutationOutput<PlanHeartOutput>> planHeart(
          SafeMutationInput<PlanHeartInput> dto) async =>
      await safePatch<PlanHeartInput, PlanHeartOutput>(dto);

  Future<SafeQueryOutput<PlanListOutput>> planList(
          SafeQueryInput<PlanListInput> dto) async =>
      await safeGET<PlanListInput, PlanListOutput>(dto);
  // Endpoints

  String planHeartUrl = "$apiBaseUrl/plan/:planId/like";
  String planListUrl = "$apiBaseUrl/plan";
}
