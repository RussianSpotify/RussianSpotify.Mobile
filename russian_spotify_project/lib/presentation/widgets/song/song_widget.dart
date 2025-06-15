import 'package:flutter/material.dart';
import '../../../data/dto/song.dart';
import '../../../services/song_statistic_service.dart';
import '../../../core/di/locator.dart';

class SongWidget extends StatefulWidget {
  final Song song;
  final VoidCallback? onTap;

  const SongWidget({
    super.key,
    required this.song,
    this.onTap,
  });

  @override
  State<SongWidget> createState() => _SongWidgetState();
}

class _SongWidgetState extends State<SongWidget> {
  int? playsNumber;
  bool isLoading = false;
  late final SongStatisticService _songStatisticService;

  @override
  void initState() {
    super.initState();
    _songStatisticService = locator<SongStatisticService>();
    _initializeRabbitMQ();
  }

  Future<void> _initializeRabbitMQ() async {
    await _songStatisticService.initialize();
    await _songStatisticService.subscribeToPlaysNumberUpdates(
      widget.song.id,
      (data) {
        if (data['songId'] == widget.song.id) {
          setState(() {
            playsNumber = data['currentPlaysNumber'];
          });
        }
      },
    );
  }

  @override
  void dispose() {
    _songStatisticService.close();
    super.dispose();
  }

  Future<void> _fetchPlaysNumber() async {
    setState(() {
      isLoading = true;
    });

    try {
      playsNumber = await _songStatisticService.getSongPlaysNumber(widget.song.id);
    } catch (e) {
      print('Error fetching plays number: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _updatePlaysNumber() async {
    try {
      await _songStatisticService.updateSongPlaysNumber(widget.song.id);
      _fetchPlaysNumber();
    } catch (e) {
      print('Error updating plays number: $e');
    }
  }

  void _showPlaysNumberDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Количество прослушиваний'),
        content: isLoading
            ? const CircularProgressIndicator()
            : Text(playsNumber?.toString() ?? 'Загрузка...'),
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
    _fetchPlaysNumber();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _updatePlaysNumber();
        if (widget.onTap != null) {
          widget.onTap!();
        }
      },
      child: ListTile(
        title: Text(
          widget.song.songName,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          widget.song.authors.map((author) => author.userName).join(', '),
          style: const TextStyle(color: Colors.grey),
        ),
        leading: const Icon(Icons.music_note, color: Colors.purple),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.visibility, color: Colors.white),
              onPressed: _showPlaysNumberDialog,
            ),
            const Icon(Icons.play_arrow, color: Colors.white),
          ],
        ),
      ),
    );
  }
}
