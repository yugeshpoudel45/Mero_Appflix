  // final String accessUrl =
  //     'https://api.themoviedb.org/3/trending/tv/day?language=en-US';

  // Future<void> _fetchTrendingMovies() async {
  //   Map<String, String> headers = {
  //     'accept': 'application/json',
  //     "Authorization": "Bearer $accessToken",
  //   };
  //   try {
  //     http.Response response = await http.get(
  //       Uri.parse(accessUrl),
  //       headers: headers,
  //     );

  //     if (response.statusCode == 200) {
  //       final trendingPeopleModel =
  //           trendingPeopleModelFromJson(response.body.toString());
  //       log(response.body.toString());

  //       log(trendingPeopleModel.page.toString());
  //       log(trendingPeopleModel.results![0].name.toString());
  //       setState(() {
  //         myimage = trendingPeopleModel.results![0].posterPath.toString();
  //         myrating = trendingPeopleModel.results![0].voteAverage.toString();
  //       });
  //     } else {
  //       log("Hello World");
  //       log(response.statusCode.toString());
  //       log(response.body.toString());
  //     }
  //   } catch (e) {
  //     print("Exception caught: $e");
  //   }
  // }

  // @override
  // void initState() {
  //   isLoading = true;
  //   _fetchTrendingMovies();
  //   isLoading = false;

  //   super.initState();
  // }