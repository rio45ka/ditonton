import 'package:bloc_test/bloc_test.dart';
import 'package:feature_tv/presentation/bloc/detail_tv/detail_tv_bloc.dart';
import 'package:feature_tv/presentation/bloc/recommendations/recommendations_tv_bloc.dart';
import 'package:feature_tv/presentation/bloc/watchlist_status/watchlist_status_tv_cubit.dart';
import 'package:feature_tv/presentation/pages/tv_series_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../dummy_data/dummy_objects.dart';

class MockDetailTvBloc extends MockBloc<DetailTvEvent, DetailTvState>
    implements DetailTvBloc {}

class DetailTvEventFake extends Fake implements DetailTvEvent {}

class DetailTvStateFake extends Fake implements DetailTvState {}

class MockRecommendationTvBloc
    extends MockBloc<RecommendationsTvEvent, RecommendationsTvState>
    implements RecommendationsTvBloc {}

class RecommendationTvEventFake extends Fake implements RecommendationsTvEvent {
}

class RecommendationTvStateFake extends Fake implements RecommendationsTvState {
}

class MockWatchlistStatusTvCubit extends MockCubit<WatchlistStatusTvState>
    implements WatchlistStatusTvCubit {}

class WatchlistStatusTvStateFake extends Fake
    implements WatchlistStatusTvState {}

void main() {
  late MockDetailTvBloc mockDetailTvBloc;
  late MockRecommendationTvBloc mockRecommendationTvBloc;
  late MockWatchlistStatusTvCubit mockWatchlistStatusTvCubit;

  setUpAll(() {
    registerFallbackValue(DetailTvEventFake());
    registerFallbackValue(DetailTvStateFake());
  });

  setUp(() {
    mockDetailTvBloc = MockDetailTvBloc();
    mockRecommendationTvBloc = MockRecommendationTvBloc();
    mockWatchlistStatusTvCubit = MockWatchlistStatusTvCubit();
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DetailTvBloc>.value(value: mockDetailTvBloc),
        BlocProvider<RecommendationsTvBloc>.value(
          value: mockRecommendationTvBloc,
        ),
        BlocProvider<WatchlistStatusTvCubit>.value(
          value: mockWatchlistStatusTvCubit,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('page should nothing when empty', (WidgetTester tester) async {
    when(() => mockDetailTvBloc.state).thenReturn(DetailTvInitialState());
    when(() => mockWatchlistStatusTvCubit.state).thenReturn(
        const WatchlistStatusTvState(isAddedWatchlist: false, message: ''));
    when(() => mockRecommendationTvBloc.state)
        .thenReturn(RecommendationsTvInitialState());

    await tester.pumpWidget(
        _makeTestableWidget(TvSeriesDetailPage(id: testTvSeriesDetail.id)));

    final progressBarFinder = find.byType(CircularProgressIndicator);
    expect(progressBarFinder, findsNothing);
  });

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockDetailTvBloc.state).thenReturn(
      DetailTvLoadingState(),
    );
    when(() => mockWatchlistStatusTvCubit.state).thenReturn(
      WatchlistStatusTvState(isAddedWatchlist: false, message: ''),
    );
    when(() => mockRecommendationTvBloc.state).thenReturn(
      RecommendationsTvLoadingState(),
    );

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(
        _makeTestableWidget(TvSeriesDetailPage(id: testTvSeriesDetail.id)));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockDetailTvBloc.state).thenReturn(DetailTvErrorState('Error'));
    when(() => mockWatchlistStatusTvCubit.state).thenReturn(
        const WatchlistStatusTvState(isAddedWatchlist: false, message: ''));
    when(() => mockRecommendationTvBloc.state)
        .thenReturn(RecommendationsTvErrorState('Error'));

    await tester.pumpWidget(_makeTestableWidget(TvSeriesDetailPage(
      id: testTvSeriesDetail.id,
    )));

    final textFinder = find.byKey(const Key('error_message'));
    expect(textFinder, findsOneWidget);
  });

  testWidgets('page should display Detail when data is loaded',
      (WidgetTester tester) async {
    when(() => mockDetailTvBloc.state).thenReturn(
      DetailTvHasDataState(testTvSeriesDetail),
    );
    when(() => mockWatchlistStatusTvCubit.state).thenReturn(
      const WatchlistStatusTvState(isAddedWatchlist: false, message: ''),
    );
    when(() => mockRecommendationTvBloc.state).thenReturn(
      RecommendationsTvHasDataState(testTvSeriesList),
    );

    await tester.pumpWidget(_makeTestableWidget(TvSeriesDetailPage(
      id: testTvSeriesDetail.id,
    )));

    final buttonFinder = find.byType(ElevatedButton);

    expect(buttonFinder, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display add icon when tv series not added to watchlist',
      (WidgetTester tester) async {
    final watchlistButton = find.byType(ElevatedButton);
    final iconButton = find.byIcon(Icons.add);

    when(() => mockDetailTvBloc.state)
        .thenReturn(DetailTvHasDataState(testTvSeriesDetail));
    when(() => mockWatchlistStatusTvCubit.state).thenReturn(
        const WatchlistStatusTvState(isAddedWatchlist: false, message: ''));
    when(() => mockRecommendationTvBloc.state)
        .thenReturn(RecommendationsTvHasDataState(testTvSeriesList));

    await tester.pumpWidget(
        _makeTestableWidget(TvSeriesDetailPage(id: testTvSeriesDetail.id)));

    expect(watchlistButton, findsOneWidget);
    expect(iconButton, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should dispay check icon when tv series is added to wathclist',
      (WidgetTester tester) async {
    final watchlistButton = find.byType(ElevatedButton);
    final iconButton = find.byIcon(Icons.check);

    when(() => mockDetailTvBloc.state)
        .thenReturn(DetailTvHasDataState(testTvSeriesDetail));
    when(() => mockWatchlistStatusTvCubit.state).thenReturn(
        const WatchlistStatusTvState(isAddedWatchlist: true, message: ''));
    when(() => mockRecommendationTvBloc.state)
        .thenReturn(RecommendationsTvHasDataState(testTvSeriesList));

    await tester.pumpWidget(
        _makeTestableWidget(TvSeriesDetailPage(id: testTvSeriesDetail.id)));

    expect(watchlistButton, findsOneWidget);
    expect(iconButton, findsOneWidget);
  });
}
