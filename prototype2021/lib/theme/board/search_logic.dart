import 'dart:async';

import 'package:flutter/material.dart';
import 'package:prototype2021/model/simple_storage.dart';

const String _recentSearchKey = 'recentSearch';

mixin BoardMainViewSearchLogicMixin {
  TextEditingController textEditingController = new TextEditingController();
  StreamController<List<dynamic>> recentSearchController =
      new StreamController<List<dynamic>>.broadcast();

  SimpleStorage storage = new SimpleStorage();

  Future<List<dynamic>?> getSearchKeywords() async {
    try {
      return await storage.readList(_recentSearchKey);
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
    storage.writeList(_recentSearchKey, current);
    recentSearchController.add(current);
  }

  Future<void> removeSearchKeyword(String keyword) async {
    List<dynamic>? current = await getSearchKeywords();
    if (current != null) {
      current.remove(keyword);
      storage.writeList(_recentSearchKey, current);
      recentSearchController.add(current);
    }
  }

  Future<void> resetSearchKeyword() async {
    await storage.writeList(_recentSearchKey, []);
  }
}
