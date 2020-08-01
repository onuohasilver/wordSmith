import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';

class GameSound {
  AudioPlayer player = AudioPlayer(mode: PlayerMode.LOW_LATENCY);
  AudioCache cache = AudioCache();
  void playFile() async {
    player = await cache.play('g.mp3', volume: 0.3); // assign player here
  }

  void buttonSound(player, cache) async {
    player = await cache.play('magicPop.mp3', volume: 0.4);
  }

  void gameStart(player, cache) async {
    player = await cache.play('Button.mp3', volume: 0.4);
  }

  void stopFile() {
    player?.stop();
    player.dispose();
  }

  void quit() {
    player.stop();
    // player.dispose();
  }
}
