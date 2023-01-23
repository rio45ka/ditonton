import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:feature_movie/domain/usecases/get_movie_detail.dart';
import 'package:feature_movie/presentation/bloc/detail/detail_movie_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../dummy_data/dummy_objects.dart';

class MockGetMovieDetail extends Mock implements GetMovieDetail {}

void main() {
  late MockGetMovieDetail mockUseCase;
  late DetailMovieBloc detailMovieBloc;

  setUp(() {
    mockUseCase = MockGetMovieDetail();
    detailMovieBloc = DetailMovieBloc(mockUseCase);
  });

  final tId = 1;

  test('initialState should be Empty', () {
    expect(detailMovieBloc.state, DetailMovieInitialState());
  });

  blocTest<DetailMovieBloc, DetailMovieState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(() => mockUseCase.execute(tId))
          .thenAnswer((_) async => Right(testMovieDetail));
      return detailMovieBloc;
    },
    act: (bloc) => bloc.add(FetchDetailMovie(tId)),
    expect: () => [
      DetailMovieLoadingState(),
      DetailMovieHasDataState(testMovieDetail),
    ],
    verify: (bloc) {
      verify(() => mockUseCase.execute(tId));
    },
  );

  blocTest<DetailMovieBloc, DetailMovieState>(
    'Should emit [Loading, Error] when get Detail Movie Series is unsuccessful',
    build: () {
      when(() => mockUseCase.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return detailMovieBloc;
    },
    act: (bloc) => bloc.add(FetchDetailMovie(tId)),
    expect: () => [
      DetailMovieLoadingState(),
      DetailMovieErrorState('Server Failure'),
    ],
    verify: (bloc) {
      verify(() => mockUseCase.execute(tId));
    },
  );

  blocTest<DetailMovieBloc, DetailMovieState>(
    'Should emit [Loading, Error] when no internet connection',
    build: () {
      when(() => mockUseCase.execute(tId)).thenAnswer(
        (_) async => Left(
          ConnectionFailure('Failed to connect to the network'),
        ),
      );
      return detailMovieBloc;
    },
    act: (bloc) => bloc.add(FetchDetailMovie(tId)),
    expect: () => [
      DetailMovieLoadingState(),
      DetailMovieErrorState('Failed to connect to the network'),
    ],
    verify: (bloc) => verify(
      () => mockUseCase.execute(tId),
    ),
  );
}
