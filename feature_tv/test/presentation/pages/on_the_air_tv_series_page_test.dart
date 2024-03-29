import 'package:bloc_test/bloc_test.dart';
import 'package:feature_tv/presentation/bloc/on_the_air/on_the_air_tv_bloc.dart';
import 'package:feature_tv/presentation/pages/on_the_air_tv_series_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../dummy_data/dummy_objects.dart';

class MockOnTheAirTvBloc extends MockBloc<OnTheAirTvEvent, OnTheAirTvState>
    implements OnTheAirTvBloc {}

class OnTheAirTvEventFake extends Fake implements OnTheAirTvEvent {}

class OnTheAirTvStateFake extends Fake implements OnTheAirTvState {}

void main() {
  late MockOnTheAirTvBloc mockBloc;

  setUpAll(() {
    registerFallbackValue(OnTheAirTvEventFake());
    registerFallbackValue(OnTheAirTvStateFake());
  });

  setUp(() {
    mockBloc = MockOnTheAirTvBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<OnTheAirTvBloc>.value(
      value: mockBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(OnTheAirTvLoadingState());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byKey(Key('loading_center'));

    await tester.pumpWidget(_makeTestableWidget(OnTheAirTvSeriesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => mockBloc.state)
        .thenReturn(OnTheAirTvHasDataState(testTvSeriesList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(OnTheAirTvSeriesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockBloc.state)
        .thenReturn(OnTheAirTvErrorState('Error message'));

    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(OnTheAirTvSeriesPage()));

    expect(textFinder, findsOneWidget);
  });
}
