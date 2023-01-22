import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:feature_movie/domain/entities/movie.dart';
import 'package:feature_movie/domain/usecases/get_popular_movies.dart';
import 'package:feature_movie/presentation/bloc/popular/popular_movies_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetPopularMovies extends Mock implements GetPopularMovies {}

void main() {
  late PopularMoviesBloc popularMoviesBloc;
  late MockGetPopularMovies mockGetPopularMovies;

  setUp(() {
    mockGetPopularMovies = MockGetPopularMovies();
    popularMoviesBloc = PopularMoviesBloc(mockGetPopularMovies);
  });

  final tMovieModel = Movie(
    adult: false,
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    genreIds: [14, 28],
    id: 557,
    originalTitle: 'Spider-Man',
    overview:
        'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    popularity: 60.441,
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    releaseDate: '2002-05-01',
    title: 'Spider-Man',
    video: false,
    voteAverage: 7.2,
    voteCount: 13507,
  );

  final tMovieList = <Movie>[tMovieModel];

  test('initialState should be Empty', () {
    expect(popularMoviesBloc.state, PopularMoviesInitialState());
  });

  blocTest<PopularMoviesBloc, PopularMoviesState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(() => mockGetPopularMovies.execute())
          .thenAnswer((_) async => Right(tMovieList));
      return popularMoviesBloc;
    },
    act: (bloc) => bloc.add(FetchPopularMovies()),
    expect: () => [
      PopularMoviesLoadingState(),
      PopularMoviesHasDataState(tMovieList),
    ],
    verify: (bloc) {
      verify(() => mockGetPopularMovies.execute());
    },
  );

  blocTest<PopularMoviesBloc, PopularMoviesState>(
    'Should emit [Loading, Error] when get Popular is unsuccessful',
    build: () {
      when(() => mockGetPopularMovies.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return popularMoviesBloc;
    },
    act: (bloc) => bloc.add(FetchPopularMovies()),
    expect: () => [
      PopularMoviesLoadingState(),
      PopularMoviesErrorState('Server Failure'),
    ],
    verify: (bloc) {
      verify(() => mockGetPopularMovies.execute());
    },
  );

  blocTest<PopularMoviesBloc, PopularMoviesState>(
    'Should emit [Loading, Error] when no internet connection',
    build: () {
      when(() => mockGetPopularMovies.execute()).thenAnswer(
        (_) async => Left(
          ConnectionFailure('Failed to connect to the network'),
        ),
      );
      return popularMoviesBloc;
    },
    act: (bloc) => bloc.add(FetchPopularMovies()),
    expect: () => [
      PopularMoviesLoadingState(),
      PopularMoviesErrorState('Failed to connect to the network'),
    ],
    verify: (bloc) => verify(
      () => mockGetPopularMovies.execute(),
    ),
  );
}
