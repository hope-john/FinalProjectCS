import 'package:flutter/material.dart';
import 'main.dart';
import 'dart:io';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'dart:async';
import 'package:infinite_listview/infinite_listview.dart';

class HistoryPage extends StatefulWidget {
  @override
  HistoryPageState createState() => HistoryPageState();
}

class HistoryPageState extends State<HistoryPage> {
  final InfiniteScrollController _infiniteController = InfiniteScrollController(
    initialScrollOffset: 0.0,
  );
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('History'),
          backgroundColor: Colors.orangeAccent,
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.arrow_downward),
              onPressed: () {
                _infiniteController.animateTo(
                    _infiniteController.offset + 2000.0,
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeIn);
              },
            ),
            IconButton(
              icon: const Icon(Icons.arrow_upward),
              onPressed: () {
                _infiniteController.animateTo(
                    _infiniteController.offset - 2000.0,
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeIn);
              },
            ),
          ],
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(text: ''),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            _buildTab(0),
          ],
        ),
      ),
    );
  }

  Widget _buildTab(int tab) {
    return InfiniteListView.separated(
      key: PageStorageKey(tab),
      controller: _infiniteController,
      itemBuilder: (BuildContext context, int index) {
        return Material(
          child: InkWell(
            onTap: () {},
            child: ListTile(
              title: Text('Tab $tab Item #$index'),
              subtitle: Text('Subtitle $index'),
              trailing: const Icon(Icons.chevron_right),
            ),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) =>
          const Divider(height: 2.0),
      anchor: 0.5,
    );
  }
}
