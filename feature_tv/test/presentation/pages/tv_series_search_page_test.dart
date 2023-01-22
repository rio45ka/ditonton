import 'package:bloc_test/bloc_test.dart';
import 'package:feature_tv/presentation/bloc/search/search_tv_bloc.dart';
import 'package:feature_tv/presentation/pages/tv_series_search_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../dummy_data/dummy_objects.dart';

class MockSearchTvBloc extends MockBloc<SearchTvEvent, SearchTvState>
    implements SearchTvBloc {}

class FakeSearchTvEvent extends Fake implements SearchTvEvent {}

class FakeSearchTvState extends Fake implements SearchTvState {}

void main() {
  late MockSearchTvBloc mockSearchTvBloc;

  setUpAll(() {
    registerFallbackValue(FakeSearchTvEvent());
    registerFallbackValue(FakeSearchTvState());
  });

  setUp(() {
    mockSearchTvBloc = MockSearchTvBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<SearchTvBloc>.value(
      value: mockSearchTvBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display loading when state is loading',
      (WidgetTester tester) async {
    when(() => mockSearchTvBloc.state).thenReturn(SearchLoading());

    await tester.pumpWidget(_makeTestableWidget(TvSeriesSearchPage()));

    final containerLoading = find.byKey(Key('ui_search_loading_key'));

    expect(containerLoading, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => mockSearchTvBloc.state)
        .thenReturn(SearchHasData(testTvSeriesList));

    await tester.pumpWidget(_makeTestableWidget(TvSeriesSearchPage()));

    final listViewFinder = find.byType(ListView);
    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockSearchTvBloc.state).thenReturn(SearchError('Error'));
    await tester.pumpWidget(_makeTestableWidget(TvSeriesSearchPage()));

    final containerFinder = find.byKey(Key('ui_search_tv_error_key'));

    expect(containerFinder, findsOneWidget);
  });
}
