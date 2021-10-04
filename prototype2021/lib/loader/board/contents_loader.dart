import 'dart:io';

import 'package:prototype2021/model/board/contents/content_detail.dart';
import 'package:prototype2021/model/board/contents/content_type.dart';
import 'package:prototype2021/utils/safe_http/base.dart';
import 'package:prototype2021/utils/safe_http/common.dart';
import 'package:prototype2021/model/board/contents/http/contents.dart';
import 'package:prototype2021/model/board/wishlist/http/heart.dart';
import 'package:prototype2021/utils/safe_http/safe_http.dart';
import 'package:prototype2021/settings/constants.dart';
import 'package:prototype2021/widgets/cards/contents_card.dart';

class ContentsLoader {
  PaginationState pagination = PaginationState.start;

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
    ContentType? type,
  ]) async {
    if (pagination == PaginationState.end) {
      return [];
    }
    ContentsListInput params =
        new ContentsListInput(keyword: keyword, contentType: type);
    SafeQueryInput<ContentsListInput> dto =
        new SafeQueryInput(url: contentsListUrl, params: params, token: token);
    SafeQueryOutput<ContentsListOutput> result = await contentsList(dto);
    if (result.success && result.data?.results != null) {
      if (result.data!.next == null) {
        pagination = PaginationState.end;
        contentsListUrl = "";
      } else {
        contentsListUrl = result.data!.next!
            .replaceFirst("tbserver:8000", "api.tripbuilder.co.kr");
        pagination = PaginationState.mid;
      }
      return result.data!.results
          .map<ContentsCardBaseProps>((datum) => ContentsCardBaseProps(
                id: datum.id,
                title: datum.title,
                explanation: datum.overview,
                preview: datum.thumbnail,
                heartCount: datum.heartNo,
                place: datum.address,
                hearted: datum.hearted,
              ))
          .toList();
    }
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

  String contentsHeartUrl = "$apiBaseUrl/contents/:id/like/";
  String contentsListUrl = "$apiBaseUrl/contents/";
  String contentsWishlistUrl = "$apiBaseUrl/contents/wishlist/";
  String contentsDetailUrl = "$apiBaseUrl/contents/:id/";
}
