import 'package:core/core.dart';
import 'package:core/domain/entities/tv_series.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:search/presentation/pages/tv_series_search_page.dart';
import 'package:search/presentation/provider/tv_series_search_notifier.dart';

import 'search_tv_series_page_test.mocks.dart';


@GenerateMocks([TvSeriesSearchNotifier])
void main() {
  late MockTvSeriesSearchNotifier mockNotifier;

  setUp(() {
    mockNotifier = MockTvSeriesSearchNotifier();
  });

  Widget _makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<TvSeriesSearchNotifier>.value(
      value: mockNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(mockNotifier.state).thenReturn(RequestState.Loaded);
    when(mockNotifier.searchResult).thenReturn(<TvSeries>[]);

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(TvSeriesSearchPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(mockNotifier.state).thenReturn(RequestState.Error);
    when(mockNotifier.message).thenReturn('Error message');

    final containerFinder = find.byType(Container);

    await tester.pumpWidget(_makeTestableWidget(TvSeriesSearchPage()));

    expect(containerFinder, findsOneWidget);
  });
}
