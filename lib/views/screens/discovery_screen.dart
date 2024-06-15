import 'package:flutter/material.dart';
import 'package:music_app_project/view_model/playlist_view_model.dart';
import 'package:music_app_project/views/components/playlist_discovery_card.dart';

import '../../models/playlist.dart';

class DiscoveryScreen extends StatefulWidget {
  const DiscoveryScreen({super.key});

  @override
  State<DiscoveryScreen> createState() => _DiscoveryScreenState();
}

class _DiscoveryScreenState extends State<DiscoveryScreen> {
  List<Playlist> playlists = [];
  late PlaylistViewModel _playlistViewModel;

  @override
  void initState() {
    _playlistViewModel = PlaylistViewModel();
    _playlistViewModel.loadPlaylist();
    observeData();
    super.initState();
  }

  observeData() {
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
      child: CustomScrollView(
        primary: false,
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.all(20.0),
            sliver: SliverGrid.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
              itemCount: playlists.length,
              itemBuilder: (context, index) => PlaylistDiscoveryCard(
                playlist: playlists[index],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
