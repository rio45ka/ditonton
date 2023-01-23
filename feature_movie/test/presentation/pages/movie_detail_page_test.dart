import 'package:bloc_test/bloc_test.dart';
import 'package:feature_movie/presentation/bloc/detail/detail_movie_bloc.dart';
import 'package:feature_movie/presentation/bloc/recommendations/recommendations_movie_bloc.dart';
import 'package:feature_movie/presentation/bloc/watchlist_status/watchlist_status_movie_cubit.dart';
import 'package:feature_movie/presentation/pages/movie_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../dummy_data/dummy_objects.dart';

class MockDetailMovieBloc extends MockBloc<DetailMovieEvent, DetailMovieState>
    implements DetailMovieBloc {}

class DetailMovieEventFake extends Fake implements DetailMovieEvent {}

class DetailMovieStateFake extends Fake implements DetailMovieState {}

class MockRecommendationMovieBloc
    extends MockBloc<RecommendationsMovieEvent, RecommendationsMovieState>
    implements RecommendationsMovieBloc {}

class RecommendationMovieEventFake extends Fake
    implements RecommendationsMovieEvent {}

class RecommendationMovieStateFake extends Fake
    implements RecommendationsMovieState {}

class MockWatchlistStatusMovieCubit extends MockCubit<WatchlistStatusMovieState>
    implements WatchlistStatusMovieCubit {}

class WatchlistStatusMovieStateFake extends Fake
    implements WatchlistStatusMovieState {}

void main() {
  late MockDetailMovieBloc mockDetailMovieBloc;
  late MockRecommendationMovieBloc mockRecommendationMovieBloc;
  late MockWatchlistStatusMovieCubit mockWatchlistStatusMovieCubit;

  setUpAll(() {
    registerFallbackValue(DetailMovieEventFake());
    registerFallbackValue(DetailMovieStateFake());
  });

  setUp(() {
    mockDetailMovieBloc = MockDetailMovieBloc();
    mockRecommendationMovieBloc = MockRecommendationMovieBloc();
    mockWatchlistStatusMovieCubit = MockWatchlistStatusMovieCubit();
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DetailMovieBloc>.value(value: mockDetailMovieBloc),
        BlocProvider<RecommendationsMovieBloc>.value(
          value: mockRecommendationMovieBloc,
        ),
        BlocProvider<WatchlistStatusMovieCubit>.value(
          value: mockWatchlistStatusMovieCubit,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('page should nothing when empty', (WidgetTester tester) async {
    when(() => mockDetailMovieBloc.state).thenReturn(DetailMovieInitialState());
    when(() => mockWatchlistStatusMovieCubit.state).thenReturn(
        const WatchlistStatusMovieState(isAddedWatchlist: false, message: ''));
    when(() => mockRecommendationMovieBloc.state)
        .thenReturn(RecommendationsMovieInitialState());

    await tester.pumpWidget(
        _makeTestableWidget(MovieDetailPage(id: testMovieDetail.id)));

    final progressBarFinder = find.byType(CircularProgressIndicator);
    expect(progressBarFinder, findsNothing);
  });

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockDetailMovieBloc.state).thenReturn(
      DetailMovieLoadingState(),
    );
    when(() => mockWatchlistStatusMovieCubit.state).thenReturn(
      WatchlistStatusMovieState(isAddedWatchlist: false, message: ''),
    );
    when(() => mockRecommendationMovieBloc.state).thenReturn(
      RecommendationsMovieLoadingState(),
    );

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(
        _makeTestableWidget(MovieDetailPage(id: testMovieDetail.id)));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockDetailMovieBloc.state)
        .thenReturn(DetailMovieErrorState('Error'));
    when(() => mockWatchlistStatusMovieCubit.state).thenReturn(
        const WatchlistStatusMovieState(isAddedWatchlist: false, message: ''));
    when(() => mockRecommendationMovieBloc.state)
        .thenReturn(RecommendationsMovieErrorState('Error'));

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(
      id: testMovieDetail.id,
    )));

    final textFinder = find.byKey(const Key('error_message'));
    expect(textFinder, findsOneWidget);
  });

  testWidgets('page should display Detail when data is loaded',
      (WidgetTester tester) async {
    when(() => mockDetailMovieBloc.state).thenReturn(
      DetailMovieHasDataState(testMovieDetail),
    );
    when(() => mockWatchlistStatusMovieCubit.state).thenReturn(
      const WatchlistStatusMovieState(isAddedWatchlist: false, message: ''),
    );
    when(() => mockRecommendationMovieBloc.state).thenReturn(
      RecommendationsMovieHasDataState(testMovieList),
    );

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(
      id: testMovieDetail.id,
    )));

    final buttonFinder = find.byType(ElevatedButton);

    expect(buttonFinder, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display add icon when Movie not added to watchlist',
      (WidgetTester tester) async {
    final watchlistButton = find.byType(ElevatedButton);
    final iconButton = find.byIcon(Icons.add);

    when(() => mockDetailMovieBloc.state)
        .thenReturn(DetailMovieHasDataState(testMovieDetail));
    when(() => mockWatchlistStatusMovieCubit.state).thenReturn(
        const WatchlistStatusMovieState(isAddedWatchlist: false, message: ''));
    when(() => mockRecommendationMovieBloc.state)
        .thenReturn(RecommendationsMovieHasDataState(testMovieList));

    await tester.pumpWidget(
        _makeTestableWidget(MovieDetailPage(id: testMovieDetail.id)));

    expect(watchlistButton, findsOneWidget);
    expect(iconButton, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should dispay check icon when Movie series is added to wathclist',
      (WidgetTester tester) async {
    final watchlistButton = find.byType(ElevatedButton);
    final iconButton = find.byIcon(Icons.check);

    when(() => mockDetailMovieBloc.state)
        .thenReturn(DetailMovieHasDataState(testMovieDetail));
    when(() => mockWatchlistStatusMovieCubit.state).thenReturn(
        const WatchlistStatusMovieState(isAddedWatchlist: true, message: ''));
    when(() => mockRecommendationMovieBloc.state)
        .thenReturn(RecommendationsMovieHasDataState(testMovieList));

    await tester.pumpWidget(
        _makeTestableWidget(MovieDetailPage(id: testMovieDetail.id)));

    expect(watchlistButton, findsOneWidget);
    expect(iconButton, findsOneWidget);
  });
}
