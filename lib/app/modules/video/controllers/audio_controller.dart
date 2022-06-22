import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class AudioController extends ChangeNotifier {
  late YoutubePlayerController controller;
  bool _muted = false;
  int _volume = 100;
  IconData _volumeIcon = Icons.volume_up;

  IconData get volumeIcon => _volumeIcon;
  double get volumePercent => _volume / 100;

  mute() {
    if (_muted) {
      controller.unMute();
      _volumeIcon = Icons.volume_up;
      _muted = !_muted;
    } else {
      controller.mute();
      _volumeIcon = Icons.volume_off;
      _muted = !_muted;
    }
    notifyListeners();
  }

  volume(bool setVolume) {
    if (setVolume && _volume < 100) {
      _volume = _volume + 10;
      if (_volume > 50 && _volumeIcon != Icons.volume_up) {
        _volumeIcon = Icons.volume_up;
      }
      if (_volume == 10 && _muted) {
        controller.unMute();
        _volumeIcon = Icons.volume_down;
        _muted = false;
      }
    }

    if (!setVolume && _volume > 0) {
      _volume = _volume - 10;
      if ((_volume > 0 && _volume < 50) && _volumeIcon != Icons.volume_down) {
        _volumeIcon = Icons.volume_down;
      }
      if (_volume == 0) mute();
    }

    if (_muted && _volume > 0) {
      controller.unMute();
      _muted = false;
    }
    controller.setVolume(_volume);
    notifyListeners();
  }
}
