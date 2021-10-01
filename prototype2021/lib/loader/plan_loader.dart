import 'dart:io';

import 'package:prototype2021/loader/safe_http.dart';
import 'package:prototype2021/model/safe_http_dto/base.dart';
import 'package:prototype2021/model/safe_http_dto/get/verification.dart';
import 'package:prototype2021/model/safe_http_dto/patch/heart.dart';
import 'package:prototype2021/settings/constants.dart';

class PlanLoader {
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

  // Fetching Functions

  Future<SafeMutationOutput<PlanHeartOutput>> planHeart(
          SafeMutationInput<PlanHeartInput> dto) async =>
      await safePatch<PlanHeartInput, PlanHeartOutput>(dto);

  // Endpoints

  String planHeartUrl = "$apiBaseUrl/contents/:id/like";
}
