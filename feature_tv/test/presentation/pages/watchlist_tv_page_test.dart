import 'package:bloc_test/bloc_test.dart';
import 'package:feature_tv/presentation/bloc/watchlist/watchlist_tv_bloc.dart';
import 'package:feature_tv/presentation/pages/watchlist_tv_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../dummy_data/dummy_objects.dart';

class MockWatchlistTvBloc extends MockBloc<WatchlistTvEvent, WatchlistTvState>
    implements WatchlistTvBloc {}

class WatchlistTvEventFake extends Fake implements WatchlistTvEvent {}

class WatchlistTvStateFake extends Fake implements WatchlistTvState {}

void main() {
  late MockWatchlistTvBloc mockWatchlistTvBloc;

  setUpAll(() {
    registerFallbackValue(WatchlistTvEventFake());
    registerFallbackValue(WatchlistTvStateFake());
  });

  setUp(() {
    mockWatchlistTvBloc = MockWatchlistTvBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<WatchlistTvBloc>.value(
      value: mockWatchlistTvBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  group('TV Page, Watchlist TV Page:', () {
    testWidgets('page should display center progress bar when loading',
        (WidgetTester tester) async {
      when(() => mockWatchlistTvBloc.state)
          .thenReturn(WatchlistTvLoadingState());
      await tester.pumpWidget(_makeTestableWidget(WatchlistTvPage()));

      final progressBarFinder = find.byType(CircularProgressIndicator);
      final centerFinder = find.byType(Center);

      expect(centerFinder, findsOneWidget);
      expect(progressBarFinder, findsOneWidget);
    });

    testWidgets('page should display ListView when data is loaded',
        (WidgetTester tester) async {
      when(() => mockWatchlistTvBloc.state)
          .thenReturn(WatchlistTvHasDataState(testTvSeriesList));

      await tester.pumpWidget(_makeTestableWidget(WatchlistTvPage()));

      final listViewFinder = find.byType(ListView);
      expect(listViewFinder, findsOneWidget);
    });

    testWidgets('page should display text with message when Error',
        (WidgetTester tester) async {
      when(() => mockWatchlistTvBloc.state)
          .thenReturn(WatchlistTvErrorState('Error'));

      await tester.pumpWidget(_makeTestableWidget(WatchlistTvPage()));

      final textFinder = find.byKey(Key('error_message'));
      expect(textFinder, findsOneWidget);
    });
  });
}
