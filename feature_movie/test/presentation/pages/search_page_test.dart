import 'package:bloc_test/bloc_test.dart';
import 'package:feature_movie/presentation/bloc/search/search_bloc.dart';
import 'package:feature_movie/presentation/pages/search_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../dummy_data/dummy_objects.dart';

class MockSearchMovieBloc extends MockBloc<SearchEvent, SearchState>
    implements SearchBloc {}

class FakeSearchMovieEvent extends Fake implements SearchEvent {}

class FakeSearchMovieState extends Fake implements SearchState {}

void main() {
  late MockSearchMovieBloc mockSearchMovieBloc;

  setUpAll(() {
    registerFallbackValue(FakeSearchMovieEvent());
    registerFallbackValue(FakeSearchMovieState());
  });

  setUp(() {
    mockSearchMovieBloc = MockSearchMovieBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<SearchBloc>.value(
      value: mockSearchMovieBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display loading when state is loading',
      (WidgetTester tester) async {
    when(() => mockSearchMovieBloc.state).thenReturn(SearchLoading());

    await tester.pumpWidget(_makeTestableWidget(SearchPage()));

    final containerLoading = find.byKey(Key('ui_search_loading_key'));

    expect(containerLoading, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => mockSearchMovieBloc.state)
        .thenReturn(SearchHasData(testMovieList));

    await tester.pumpWidget(_makeTestableWidget(SearchPage()));

    final listViewFinder = find.byType(ListView);
    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockSearchMovieBloc.state).thenReturn(SearchError('Error'));
    await tester.pumpWidget(_makeTestableWidget(SearchPage()));

    final containerFinder = find.byKey(Key('ui_search_tv_error_key'));

    expect(containerFinder, findsOneWidget);
  });
}
