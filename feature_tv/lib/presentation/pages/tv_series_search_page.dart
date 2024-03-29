import 'package:core/core.dart';
import 'package:feature_tv/presentation/bloc/search/search_tv_bloc.dart';
import 'package:feature_tv/presentation/widgets/tv_series_card_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TvSeriesSearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onChanged: (query) {
                context.read<SearchTvBloc>().add(OnQueryChanged(query));
              },
              decoration: InputDecoration(
                hintText: 'Search title',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.search,
            ),
            SizedBox(height: 16),
            Text(
              'Search Result',
              style: kHeading6,
            ),
            BlocBuilder<SearchTvBloc, SearchTvState>(
              builder: (context, state) {
                if (state is SearchLoading) {
                  return Center(
                    key: Key('ui_search_loading_key'),
                    child: CircularProgressIndicator(),
                  );
                } else if (state is SearchHasData) {
                  return Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemBuilder: (context, index) {
                        return TvSeriesCardListWidget(state.result[index]);
                      },
                      itemCount: state.result.length,
                    ),
                  );
                } else if (state is SearchError) {
                  return Expanded(
                    key: Key('ui_search_tv_error_key'),
                    child: Center(
                      child: Text(state.message),
                    ),
                  );
                } else {
                  return Container();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
