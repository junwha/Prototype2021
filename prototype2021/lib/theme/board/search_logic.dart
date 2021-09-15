import 'dart:async';

import 'package:flutter/material.dart';
import 'package:prototype2021/model/simple_storage.dart';

const String _recentSearchKey = 'recentSearch';

mixin BoardMainViewSearchLogicMixin {
  TextEditingController textEditingController = new TextEditingController();
  StreamController<List<String>> recentSearchController =
      new StreamController<List<String>>();

  SimpleStorage storage = new SimpleStorage();

  Future<List<String>?> getSearchKeywords() async =>
      await storage.readList<String>(_recentSearchKey);

  Future<void> loadSearchKeywords() async {
    List<String>? current = await getSearchKeywords();
    if (current != null) {
      recentSearchController.add(current);
    }
  }

  Future<void> addSearchKeyword(String keyword) async {
    List<String>? current = await getSearchKeywords();
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
    List<String>? current = await getSearchKeywords();
    if (current != null) {
      current.remove(keyword);
      recentSearchController.add(current);
    }
  }

  Future<void> resetSearchKeyword() async {
    await storage.writeList(_recentSearchKey, []);
  }
}
