import 'dart:async';

import 'package:flutter/material.dart';
import 'package:prototype2021/utils/simple_storage/simple_storage.dart';
import 'package:rxdart/subjects.dart';

mixin BoardMainViewSearchLogicMixin {
  TextEditingController textEditingController = new TextEditingController();
  StreamController<List<dynamic>> recentSearchController =
      new BehaviorSubject<List<dynamic>>();

  Future<List<dynamic>?> getSearchKeywords() async {
    try {
      return await SimpleStorage.readList(SimpleStorageKeys.recentSearch);
    } catch (error) {
      return null;
    }
  }

  Future<void> loadSearchKeywords() async {
    List<dynamic>? current = await getSearchKeywords();
    if (current == null || current.length == 0) {
      await resetSearchKeyword();
      recentSearchController.add([]);
    } else {
      recentSearchController.add(current.reversed.toList());
    }
  }

  Future<void> addSearchKeyword(String keyword) async {
    List<dynamic>? current = await getSearchKeywords();
    if (current == null) {
      current = [keyword];
    } else {
      current = current.where((word) => word != keyword).toList();
      current.add(keyword);
    }
    SimpleStorage.writeList(SimpleStorageKeys.recentSearch, current);
    recentSearchController.add(current);
  }

  Future<void> removeSearchKeyword(String keyword) async {
    List<dynamic>? current = await getSearchKeywords();
    if (current != null) {
      current.remove(keyword);
      SimpleStorage.writeList(SimpleStorageKeys.recentSearch, current);
      recentSearchController.add(current);
    }
  }

  Future<void> resetSearchKeyword() async {
    await SimpleStorage.writeList(SimpleStorageKeys.recentSearch, []);
  }
}
