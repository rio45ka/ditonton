import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:feature_tv/domain/usecases/get_tv_series_detail_usecase.dart';
import 'package:feature_tv/presentation/bloc/detail_tv/detail_tv_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../dummy_data/dummy_objects.dart';

class MockGetTvSeriesDetailUseCase extends Mock
    implements GetTvSeriesDetailUseCase {}

void main() {
  late DetailTvBloc detailTvBloc;
  late MockGetTvSeriesDetailUseCase mockUseCase;

  setUp(() {
    mockUseCase = MockGetTvSeriesDetailUseCase();
    detailTvBloc = DetailTvBloc(mockUseCase);
  });

  final tId = 1396;

  test('initialState should be Empty', () {
    expect(detailTvBloc.state, DetailTvInitialState());
  });

  blocTest<DetailTvBloc, DetailTvState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(() => mockUseCase.execute(tId))
          .thenAnswer((_) async => Right(testTvSeriesDetail));
      return detailTvBloc;
    },
    act: (bloc) => bloc.add(FetchDetailTvSeries(tId)),
    expect: () => [
      DetailTvLoadingState(),
      DetailTvHasDataState(testTvSeriesDetail),
    ],
    verify: (bloc) {
      verify(() => mockUseCase.execute(tId));
    },
  );

  blocTest<DetailTvBloc, DetailTvState>(
    'Should emit [Loading, Error] when get Detail Tv Series is unsuccessful',
    build: () {
      when(() => mockUseCase.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return detailTvBloc;
    },
    act: (bloc) => bloc.add(FetchDetailTvSeries(tId)),
    expect: () => [
      DetailTvLoadingState(),
      DetailTvErrorState('Server Failure'),
    ],
    verify: (bloc) {
      verify(() => mockUseCase.execute(tId));
    },
  );

  blocTest<DetailTvBloc, DetailTvState>(
    'Should emit [Loading, Error] when no internet connection',
    build: () {
      when(() => mockUseCase.execute(tId)).thenAnswer(
        (_) async => Left(
          ConnectionFailure('Failed to connect to the network'),
        ),
      );
      return detailTvBloc;
    },
    act: (bloc) => bloc.add(FetchDetailTvSeries(tId)),
    expect: () => [
      DetailTvLoadingState(),
      DetailTvErrorState('Failed to connect to the network'),
    ],
    verify: (bloc) => verify(
      () => mockUseCase.execute(tId),
    ),
  );
}
