import 'dart:io';

import 'package:prototype2021/data/dto/contents/content_detail.dart';
import 'package:prototype2021/data/dto/safe_http/base.dart';
import 'package:prototype2021/data/dto/safe_http/get/contents.dart';
import 'package:prototype2021/data/dto/safe_http/patch/heart.dart';
import 'package:prototype2021/loader/safe_http.dart';
import 'package:prototype2021/settings/constants.dart';
import 'package:prototype2021/theme/cards/contents_card.dart';

class ContentsLoader {
  // Custom Functions

  Future<void> heartContents(String contentsId, String token) async {
    ContentsHeartInput params = new ContentsHeartInput(contentsId: contentsId);
    SafeMutationInput<ContentsHeartInput> dto = new SafeMutationInput(
      data: params,
      url: contentsHeartUrl,
      token: token,
    );
    SafeMutationOutput<ContentsHeartOutput> result = await contentsHeart(dto);
    if (!result.success)
      throw HttpException(result.error?.message ?? "Unexpected error");
  }

  Future<List<ContentsCardBaseProps>> getContentsList(
    String token, [
    String? keyword,
  ]) async {
    ContentsListInput params = new ContentsListInput(keyword: keyword);
    SafeQueryInput<ContentsListInput> dto =
        new SafeQueryInput(url: contentsListUrl, params: params, token: token);
    SafeQueryOutput<ContentsListOutput> result = await contentsList(dto);
    if (result.success && result.data?.results != null)
      return result.data!.results
          .map<ContentsCardBaseProps>((datum) => ContentsCardBaseProps(
                id: datum.id,
                title: datum.title,
                rating: datum.rating,
                explanation: datum.overview,
                preview: datum.thumbnail,
                heartCount: datum.heartNo,
                place: datum.address,
                ratingNumbers: datum.reviewNo,
                hearted: datum.hearted,
              ))
          .toList();
    throw HttpException(result.error?.message ?? "Unexpected error");
  }

  Future<ContentsDetail> getContentDetail(int id, String token) async {
    ContentsDetailInput params = new ContentsDetailInput(id: id);
    SafeQueryInput<ContentsDetailInput> dto = new SafeQueryInput(
        url: contentsDetailUrl, params: params, token: token);
    SafeQueryOutput<ContentsDetailOutput> result = await contentsDetail(dto);
    if (result.success && result.data?.result != null)
      return result.data!.result;
    throw HttpException(result.error?.message ?? "Unexpected error");
  }

  // Fetching Functions

  Future<SafeMutationOutput<ContentsHeartOutput>> contentsHeart(
          SafeMutationInput<ContentsHeartInput> dto) async =>
      await safePatch<ContentsHeartInput, ContentsHeartOutput>(dto, 201, true);

  Future<SafeQueryOutput<ContentsListOutput>> contentsList(
          SafeQueryInput<ContentsListInput> dto) async =>
      await safeGET<ContentsListInput, ContentsListOutput>(dto, 200, true);

  Future<SafeQueryOutput<ContentsWishlistOutput>> contentsWishlist(
          SafeQueryInput<ContentsWishlistInput> dto) async =>
      await safeGET<ContentsWishlistInput, ContentsWishlistOutput>(
          dto, 200, true);

  Future<SafeQueryOutput<ContentsDetailOutput>> contentsDetail(
          SafeQueryInput<ContentsDetailInput> dto) async =>
      await safeGET<ContentsDetailInput, ContentsDetailOutput>(dto, 200, true);

  // Endpoints

  String contentsHeartUrl = "$apiBaseUrl/contents/like/:id/";
  String contentsListUrl = "$apiBaseUrl/contents/";
  String contentsWishlistUrl = "$apiBaseUrl/contents/wishlists/";
  String contentsDetailUrl = "$apiBaseUrl/contents/:id/";
}
