import 'package:bloc_test/bloc_test.dart';
import 'package:feature_movie/presentation/bloc/watchlist/watchlist_movie_bloc.dart';
import 'package:feature_movie/presentation/pages/watchlist_movies_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../dummy_data/dummy_objects.dart';

class MockWatchlistMovieBloc
    extends MockBloc<WatchlistMovieEvent, WatchlistMovieState>
    implements WatchlistMovieBloc {}

class WatchlistMovieEventFake extends Fake implements WatchlistMovieEvent {}

class WatchlistMovieStateFake extends Fake implements WatchlistMovieState {}

void main() {
  late MockWatchlistMovieBloc mockWatchlistMovieBloc;

  setUpAll(() {
    registerFallbackValue(WatchlistMovieStateFake);
    registerFallbackValue(WatchlistMovieEventFake);
  });

  setUp(() {
    mockWatchlistMovieBloc = MockWatchlistMovieBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<WatchlistMovieBloc>.value(
      value: mockWatchlistMovieBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockWatchlistMovieBloc.state)
        .thenReturn(WatchlistMovieLoadingState());
    await tester.pumpWidget(_makeTestableWidget(WatchlistMoviesPage()));

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('page should display LisMovieiew when data is loaded',
      (WidgetTester tester) async {
    when(() => mockWatchlistMovieBloc.state)
        .thenReturn(WatchlistMovieHasDataState(testMovieList));

    await tester.pumpWidget(_makeTestableWidget(WatchlistMoviesPage()));

    final lisMovieiewFinder = find.byType(ListView);
    expect(lisMovieiewFinder, findsOneWidget);
  });

  testWidgets('page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockWatchlistMovieBloc.state)
        .thenReturn(WatchlistMovieErrorState('Error'));

    await tester.pumpWidget(_makeTestableWidget(WatchlistMoviesPage()));

    final textFinder = find.byKey(Key('error_message'));
    expect(textFinder, findsOneWidget);
  });
}
