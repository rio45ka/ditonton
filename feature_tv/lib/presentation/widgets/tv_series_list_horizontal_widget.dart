import 'package:feature_tv/domain/entities/tv_series.dart';
import 'package:flutter/material.dart';
import 'tv_series_card_grid_widget.dart';

class TvSeriesListHorizontalWidget extends StatelessWidget {
  final List<TvSeries> tvSeriesList;

  TvSeriesListHorizontalWidget(this.tvSeriesList);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final tvSeries = tvSeriesList[index];
          return TvSeriesCardGridWidget(tvSeries: tvSeries);
        },
        itemCount: tvSeriesList.length,
      ),
    );
  }
}
