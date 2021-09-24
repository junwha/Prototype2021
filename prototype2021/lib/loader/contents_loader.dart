import 'dart:io';

import 'package:prototype2021/loader/safe_http.dart';
import 'package:prototype2021/model/safe_http_dto/base.dart';
import 'package:prototype2021/model/safe_http_dto/get/contents.dart';
import 'package:prototype2021/model/safe_http_dto/patch/heart.dart';
import 'package:prototype2021/settings/constants.dart';

class ContentsLoader {
  // Custom Functions

  Future<void> heartContents(String contentsId, String token) async {
    ContentsHeartInput params = new ContentsHeartInput(contentsId: contentsId);
    SafeMutationInput<ContentsHeartInput> dto = new SafeMutationInput(
        data: params, url: contentsHeartUrl, token: token);
    SafeMutationOutput<ContentsHeartOutput> result = await contentsHeart(dto);
    if (!result.success)
      throw HttpException(result.error?.message ?? "Unexpected error");
  }

  // Fetching Functions

  Future<SafeMutationOutput<ContentsHeartOutput>> contentsHeart(
          SafeMutationInput<ContentsHeartInput> dto) async =>
      await safePatch<ContentsHeartInput, ContentsHeartOutput>(dto);

  Future<SafeQueryOutput<ContentsListOutput>> contentsList(
          SafeQueryInput<ContentsListInput> dto) async =>
      await safeGET<ContentsListInput, ContentsListOutput>(dto);

  Future<SafeQueryOutput<ContentsWishlistOutput>> contentsWishlist(
          SafeQueryInput<ContentsWishlistInput> dto) async =>
      await safeGET<ContentsWishlistInput, ContentsWishlistOutput>(dto);

  Future<SafeQueryOutput<ContentsDetailOutput>> contentsDetail(
          SafeQueryInput<ContentsDetailInput> dto) async =>
      await safeGET<ContentsDetailInput, ContentsDetailOutput>(dto);

  // Endpoints

  String contentsHeartUrl = "$apiBaseUrl/contents/:id/like";
  String contentsListUrl = "$apiBaseUrl/contents";
  String contentsWishlistUrl = "$apiBaseUrl/contents/wishlists";
  String contentsDetailUrl = "$apiBaseUrl/contents/:id";
}
