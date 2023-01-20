import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:core/utils/routes.dart';
import 'package:feature_tv/domain/entities/tv_series.dart';
import 'package:flutter/material.dart';

class TvSeriesCardGridWidget extends StatelessWidget {
  const TvSeriesCardGridWidget({
    Key? key,
    required this.tvSeries,
  }) : super(key: key);

  final TvSeries tvSeries;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(
            context,
            TV_SERIES_DETAIL_ROUTE,
            arguments: tvSeries.id,
          );
        },
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(16)),
              child: CachedNetworkImage(
                imageUrl: '$BASE_IMAGE_URL${tvSeries.posterPath}',
                placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(),
                ),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: 6.0,
              ),
              decoration: BoxDecoration(
                color: Colors.red.withAlpha(140),
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(16.0),
                  topLeft: Radius.circular(16.0),
                ),
              ),
              child: Text(
                'Tv Series',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
