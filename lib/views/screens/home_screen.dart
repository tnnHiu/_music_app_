import 'package:flutter/material.dart';
import 'package:music_app_project/view_model/playlist_view_model.dart';
import 'package:music_app_project/view_model/recommend_song_view_model.dart';

import '../../models/models.dart';
import '../components/discovery_music.dart';
import '../components/playlist_card.dart';
import '../components/section_header.dart';
import '../components/song_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Song> recommendSongsRate = [];
  List<Song> recommendSongsView = [];
  List<Playlist> playlists = [];

  // late SongViewModel _songViewModel;
  late RecommendSongViewModel _recommendSongViewModel;
  late PlaylistViewModel _playlistViewModel;

  @override
  void initState() {
    _recommendSongViewModel = RecommendSongViewModel();
    _recommendSongViewModel.loadRecommendSong();
    _playlistViewModel = PlaylistViewModel();
    _playlistViewModel.loadPlaylist();
    observeData();
    super.initState();
  }

  void observeData() {
    _recommendSongViewModel.recommendSongStream.stream.listen((recommendSong) {
      setState(() {
        recommendSongsRate.addAll(recommendSong.songsRate);
        recommendSongsView.addAll(recommendSong.songsView);
      });
    });
    _playlistViewModel.playlistStream.stream.listen((playlist) {
      setState(() {
        playlists.addAll(playlist);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.deepPurple.shade800,
            Colors.deepPurple.shade200,
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Column(
            children: [
              const DiscoverMusic(),
              _TrendingMusic(title: 'Songs Rate', songs: recommendSongsRate),
              _TrendingMusic(title: 'Songs View', songs: recommendSongsView),
              _PlaylistMusic(playlists: playlists)
            ],
          ),
        ),
      ),
    );
  }
}

class _PlaylistMusic extends StatelessWidget {
  const _PlaylistMusic({
    required this.playlists,
  });

  final List<Playlist> playlists;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          const SectionHeader(title: 'Playlists', action: 'View more'),
          ListView.builder(
            padding: const EdgeInsets.only(top: 20),
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: playlists.length,
            itemBuilder: (context, index) {
              return PlaylistCard(playlist: playlists[index]);
            },
          ),
        ],
      ),
    );
  }
}

class _TrendingMusic extends StatelessWidget {
  const _TrendingMusic({
    required this.title,
    required this.songs,
  });

  final List<Song> songs;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20.0,
        top: 20.0,
        bottom: 20.0,
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: SectionHeader(
              title: title,
              action: 'View More',
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.27,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: songs.length,
              itemBuilder: (context, index) {
                return SongCard(
                  songIndex: index,
                  songs: songs,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
