import 'package:audio_players/audio_player_background_playlist.dart';
import 'package:audio_players/audio_player_local_asset.dart';
import 'package:audio_players/audio_player_url.dart';
import 'package:audio_players/design_examples/episode1_circular_progress.dart';
import 'package:audio_players/design_examples/episode2_linear_progress.dart';
import 'package:audio_players/design_examples/episode3_bottom_slider.dart';
import 'package:audio_players/design_examples/episode5_swiper.dart';
import 'package:audio_players/design_examples/episode4_yellow_design.dart';
import 'package:audio_players/design_examples/episode6_playlist_view.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),

        /// Swap classes here:
        ///       - AudioPlayerUrl():
        ///           -> plays audio file from a url source (can be local or on the Internet)
        ///
        ///       - AudioPlayerLocalAsset():
        ///           -> plays audio file from local asset (stored in /assets)
        ///
        ///       - AudioPlayerBackgroundPlaylist():
        ///           -> plays multiple songs from URL + allows background playing with sound control in notification bar
        ///
        ///       - AudioPlayerLinearProgress():
        ///           -> example design of an audio player with linear progress bar
        ///
        ///       - AudioPlayerCircularProgress():
        ///           -> example design of an audio player with circular progress bar

        home:Episode6PlaylistView());
  }
}
