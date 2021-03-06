import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Episode3BottomSlider extends StatefulWidget {
  final RealtimePlayingInfos realtimePlayingInfos;
  final AssetsAudioPlayer audioPlayer;
  Episode3BottomSlider({this.realtimePlayingInfos,this.audioPlayer});
  @override
  _Episode3BottomSliderState createState() =>
      _Episode3BottomSliderState();
}

class _Episode3BottomSliderState extends State<Episode3BottomSlider> {

  double screenWidth = 0;
  double screenHeight = 0;

  /// List of placeholder icon buttons used for the bottom navigation bar
  final List<Widget> bottomNavigationBar = [
    IconButton(
        icon: Icon(Icons.autorenew_rounded),
        onPressed: () {},
        color: Colors.white),
    IconButton(
        icon: Icon(Icons.favorite_outline_rounded),
        onPressed: () {},
        color: Colors.white),
    IconButton(
        icon: Icon(Icons.menu_rounded), onPressed: () {}, color: Colors.white),
    IconButton(
        icon: Icon(Icons.bookmark_border),
        onPressed: () {},
        color: Colors.white),
  ];

  @override
  void initState() {
    super.initState();
    //setupPlaylist();
  }

  void setupPlaylist() async {
    widget.audioPlayer.open(
        Playlist(audios: [
          Audio('assets/mauli.mp3',
              metas: Metas(
                  title: 'All That',
                  artist: 'Benjamin Tissot',
                  image: MetasImage.asset('assets/corona.png'))),
          Audio('assets/mauli.mp3',
              metas: Metas(
                  title: 'Love',
                  artist: 'Benjamin Tissot',
                  image: MetasImage.asset('assets/splash.png'))),
          Audio('assets/mauli.mp3',
              metas: Metas(
                  title: 'The Jazz Piano',
                  artist: 'Benjamin Tissot',
                  image: MetasImage.asset('assets/corona.png'))),
        ]),
        autoStart: false,
        loopMode: LoopMode.playlist);
  }

  Widget audioImage(RealtimePlayingInfos realtimePlayingInfos) {
    return Container(
      height: screenHeight * 0.3,
      width: screenWidth * 0.5,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Image.asset(
          widget.realtimePlayingInfos.current.audio.audio.metas.image.path,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget titleText(RealtimePlayingInfos realtimePlayingInfos) {
    return Text(
      widget.realtimePlayingInfos.current.audio.audio.metas.title,
      style:
          TextStyle(fontSize: 40, color: Colors.white, fontFamily: 'DMSerif'),
    );
  }

  Widget artistText(RealtimePlayingInfos realtimePlayingInfos) {
    return Text(
      widget.realtimePlayingInfos.current.audio.audio.metas.artist,
      style: TextStyle(fontSize: 13, color: Colors.grey),
    );
  }

  Widget playBar(RealtimePlayingInfos realtimePlayingInfos) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: Icon(Icons.skip_previous_rounded),
          onPressed: () => widget.audioPlayer.previous(),
          iconSize: screenHeight * 0.04,
          color: Colors.white,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        IconButton(
          icon: Icon(realtimePlayingInfos.isPlaying
              ? Icons.pause_circle_filled_rounded
              : Icons.play_circle_fill_rounded),
          onPressed: () => widget.audioPlayer.playOrPause(),
          iconSize: screenHeight * 0.08,
          color: Colors.white,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        IconButton(
          icon: Icon(Icons.skip_next_rounded),
          onPressed: () => widget.audioPlayer.next(),
          iconSize: screenHeight * 0.04,
          color: Colors.white,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
      ],
    );
  }

  Widget timestamps(RealtimePlayingInfos realtimePlayingInfos) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          transformString(widget.realtimePlayingInfos.currentPosition.inSeconds),
          style: TextStyle(color: Colors.grey),
        ),
        SizedBox(width: screenWidth * 0.7),
        Text(
          transformString(widget.realtimePlayingInfos.duration.inSeconds),
          style: TextStyle(color: Colors.grey),
        ),
      ],
    );
  }

  Widget slider(RealtimePlayingInfos realtimePlayingInfos) {
    return Stack(
      children: [
        Positioned.fill(
            child: Container(
          height: screenHeight * 0.03,
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            Color(0xff1c1c1e),
            Color(0xff1c1c1e),
            Colors.black,
            Colors.black
          ], stops: [
            0.0,
            0.55,
            0.55,
            1.0
          ], end: Alignment.bottomCenter, begin: Alignment.topCenter)),
        )),
        SliderTheme(
            data: SliderThemeData(
                trackShape: CustomTrackShape(),
                thumbColor: Colors.white,
                activeTrackColor: Color(0xffe45923),
                inactiveTrackColor: Colors.grey[800],
                overlayColor: Colors.transparent),
            child: Slider.adaptive(
                value:
                    widget.realtimePlayingInfos.currentPosition.inSeconds.toDouble(),
                max: widget.realtimePlayingInfos.duration.inSeconds.toDouble() + 3,
                min: -3,
                onChanged: (value) {
                  if (value <= 0) {
                    widget.audioPlayer.seek(Duration(seconds: 0));
                  } else if (value >= widget.realtimePlayingInfos.duration.inSeconds) {
                    widget.audioPlayer.seek(widget.realtimePlayingInfos.duration);
                  } else {
                    widget.audioPlayer.seek(Duration(seconds: value.toInt()));
                  }
                })),
      ],
    );
  }

  /// Transforms string into a mm:ss format
  String transformString(int seconds) {
    String minuteString =
        '${(seconds / 60).floor() < 10 ? 0 : ''}${(seconds / 60).floor()}';
    String secondString = '${seconds % 60 < 10 ? 0 : ''}${seconds % 60}';
    return '$minuteString:$secondString'; // Returns a string with the format mm:ss
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xff1c1c1e),
      bottomNavigationBar: BottomAppBar(
        color: Colors.black,
        child: SizedBox(
          height: screenHeight * 0.15,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: bottomNavigationBar,
          ),
        ),
      ),
      body: Container (

          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              audioImage(widget.realtimePlayingInfos),
              SizedBox(height: screenHeight * 0.05),
              titleText(widget.realtimePlayingInfos),
              SizedBox(height: screenHeight * 0.01),
              artistText(widget.realtimePlayingInfos),
              SizedBox(height: screenHeight * 0.05),
              playBar(widget.realtimePlayingInfos),
              SizedBox(height: screenHeight * 0.05),
              timestamps(widget.realtimePlayingInfos),
              slider(widget.realtimePlayingInfos)
            ],
          ),

    ),);

  }
}

class CustomTrackShape extends RoundedRectSliderTrackShape {
  /// Removes side padding of slider
  /// Credit goes to @clocksmith, https://github.com/flutter/flutter/issues/37057
  Rect getPreferredRect({
    @required RenderBox parentBox,
    Offset offset = Offset.zero,
    @required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double trackHeight = sliderTheme.trackHeight;
    final double trackLeft = offset.dx;
    final double trackTop =
        offset.dy + (parentBox.size.height - trackHeight) / 2;
    final double trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}
