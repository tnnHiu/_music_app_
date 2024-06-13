import 'dart:convert';
import 'dart:core';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:music_app_project/constants/app_constants.dart';
import 'package:music_app_project/view_model/genre_view_model.dart';
import 'package:music_app_project/views/components/app_button.dart';
import 'package:music_app_project/views/components/app_text_field.dart';
import 'package:path/path.dart' as p;

import '../../models/artist.dart';
import '../../models/genre.dart';
import '../../view_model/artist_view_model.dart';

class UploadSongScreen extends StatefulWidget {
  const UploadSongScreen({super.key});

  @override
  State<UploadSongScreen> createState() => _UploadSongScreenState();
}

class _UploadSongScreenState extends State<UploadSongScreen> {
  final _formKey = GlobalKey<FormState>();

  List<Artist> artists = [];
  List<Genre> genres = [];
  String? name;
  String? author;
  String? description;
  int? genreId;
  int? artistId;
  String? _imagePath;
  String? _audioPath;

  late ArtistViewModel _artistViewModel;
  late GenreViewModel _genreViewModel;

  @override
  void initState() {
    super.initState();
    _artistViewModel = ArtistViewModel();
    _genreViewModel = GenreViewModel();
    _artistViewModel.loadArtist();
    _genreViewModel.loadGenre();
    _artistViewModel.artistStream.stream.listen((artist) {
      setState(() {

          artists.addAll(artist);
        // artists.addAll(artist);
      });
    });
    _genreViewModel.genreStream.stream.listen((genre) {
      setState(() {
        genres.addAll(genre);
      });
    });
  }

  Future<void> uploadMusic(BuildContext context) async {
    if (_imagePath == null || _audioPath == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Vui lòng chọn cả hình ảnh và file âm thanh')),
      );
      return;
    }
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('${apiUrl}song'),
    );

    request.fields['info'] = json.encode({
      'title': name,
      'description': description,
      'url_thumbnail': '',
      'url_audio': '',
      'genreID': genreId,
      'artistID': artistId,
      'views': 0,
    });

    var imageFile = await http.MultipartFile.fromPath(
      'fileImage',
      _imagePath!,
      filename: p.basename(_imagePath!),
    );
    request.files.add(imageFile);

    var audioFile = await http.MultipartFile.fromPath(
      'fileAudio',
      _audioPath!,
      filename: p.basename(_audioPath!),
    );
    request.files.add(audioFile);

    try {
      var response = await request.send();

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Upload thành công!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Upload thất bại.')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Có lỗi xảy ra: $e')),
      );
    }
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
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            'Tải nhạc lên',
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        body: SingleChildScrollView(
          child: SafeArea(
            child: _buildFormUploadSong(context),
          ),
        ),
      ),
    );
  }

  Form _buildFormUploadSong(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 80),
          AppTextField(
            hintText: 'Tên bài hát',
            onSaved: (value) => name = value,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Vui lòng nhập tên bài hát';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 25),
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.deepPurple.shade800.withOpacity(0.35),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Expanded(
              child: DropdownButtonFormField<int>(
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  border: InputBorder.none,
                  hintText: 'Nghệ sĩ',
                  hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Colors.grey.shade400,
                      ),
                ),
                dropdownColor: Colors.deepPurple.shade800,
                items: artists.map((artist) {
                  return DropdownMenuItem(
                    value: artist.id,
                    child: Text(
                      artist.name,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Colors.white,
                          ),
                    ),
                  );
                }).toList(),
                onChanged: (value) => setState(() => artistId = value),
                validator: (value) {
                  if (value == null) {
                    return 'Vui lòng chọn tác giả';
                  }
                  return null;
                },
                icon: const Icon(Icons.arrow_drop_down_rounded),
              ),
            ),
          ),
          const SizedBox(height: 20),
          AppTextField(
            hintText: 'Mô tả',
            onSaved: (value) => description = value,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Vui lòng nhập mô tả';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 25),
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.deepPurple.shade800.withOpacity(0.35),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Expanded(
              child: DropdownButtonFormField(
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  border: InputBorder.none,
                  hintText: 'Thể loại',
                  hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Colors.grey.shade400,
                      ),
                ),
                dropdownColor: Colors.deepPurple.shade800,
                items: genres.map((genre) {
                  return DropdownMenuItem(
                    value: genre.id,
                    child: Text(
                      genre.name,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Colors.white,
                          ),
                    ),
                  );
                }).toList(),
                onChanged: (value) => setState(() => genreId = value),
                validator: (value) {
                  if (value == null) {
                    return 'Vui lòng chọn thể loại';
                  }
                  return null;
                },
                icon: const Icon(Icons.arrow_drop_down_rounded),
              ),
            ),
          ),
          const SizedBox(height: 20),
          AppButton(
            color: Colors.deepPurple.shade800.withOpacity(0.35),
            text: _imagePath == null ? 'Chọn hình ảnh' : 'Hình ảnh đã chọn',
            onTap: () async {
              final result = await FilePicker.platform.pickFiles(
                type: FileType.image,
              );
              if (result != null) {
                setState(() {
                  _imagePath = result.files.single.path;
                });
              }
            },
          ),
          const SizedBox(height: 20),
          AppButton(
            color: Colors.deepPurple.shade800.withOpacity(0.35),
            text: _audioPath == null
                ? 'Chọn file âm thanh'
                : 'File âm thanh đã chọn',
            onTap: () async {
              final result = await FilePicker.platform.pickFiles(
                type: FileType.audio,
              );
              if (result != null) {
                setState(() {
                  _audioPath = result.files.single.path;
                });
              }
            },
          ),
          const SizedBox(height: 80),
          AppButton(
            color: Colors.deepPurple,
            text: 'Tải lên',
            onTap: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                uploadMusic(context);
              }
            },
          ),
        ],
      ),
    );
  }
}
