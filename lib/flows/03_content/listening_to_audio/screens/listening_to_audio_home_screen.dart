import 'package:enterprise_ui_playground/flows/03_content/listening_to_audio/constants/song_details.dart';
import 'package:enterprise_ui_playground/flows/03_content/listening_to_audio/screens/playing_song_screen.dart';
import 'package:flutter/material.dart';

class ListeningToAudioHomeScreen extends StatefulWidget {
  const ListeningToAudioHomeScreen({super.key});

  @override
  State<ListeningToAudioHomeScreen> createState() =>
      _ListeningToAudioHomeScreenState();
}

class _ListeningToAudioHomeScreenState extends State<ListeningToAudioHomeScreen>
  {
  static const _artworkUrl =
      'lib/flows/03_content/listening_to_audio/assets/images/listening_to_audio_home_page_background_image.jpg';

  bool _isShuffleEnabled = false;

  void _playFirstSong() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => const PlayingSongScreen(songIndex: 0, autoPlay: true),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        top: false,
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 520),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [_buildHero(context), _buildCollectionDetails()],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHero(BuildContext context) {
    final heroHeight = (MediaQuery.sizeOf(context).width * 1.30)
        .clamp(470.0, 620.0)
        .toDouble();

    return SizedBox(
      height: heroHeight,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Hero(
            tag: 'track-artwork-1',
            child: Image.asset(
              _artworkUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                color: const Color(0xff171719),
                alignment: Alignment.center,
                child: const Icon(
                  Icons.image_not_supported_outlined,
                  color: Colors.white54,
                  size: 42,
                ),
              ),
              // loadingBuilder: (context, child, loadingProgress) {
              //   if (loadingProgress == null) return child;
              //   return Container(
              //     color: const Color(0xff171719),
              //     alignment: Alignment.center,
              //     child: const CircularProgressIndicator(
              //       color: Colors.white,
              //       strokeWidth: 2,
              //     ),
              //   );
              // },
            ),
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.5),
                  Colors.transparent,
                  Colors.black.withOpacity(0.94),
                ],
                stops: const [0.0, 0.43, 1.0],
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.paddingOf(context).top + 10,
            left: 18,
            right: 18,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _heroIconButton(Icons.arrow_back_ios_new, () {
                  Navigator.maybePop(context);
                }),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 13,
                    vertical: 7,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.18),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.headphones, color: Colors.white70, size: 14),
                      SizedBox(width: 6),
                      Text(
                        'HELP',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ],
                  ),
                ),
                _heroIconButton(Icons.more_horiz, () {}),
              ],
            ),
          ),
          Positioned(
            left: 24,
            right: 24,
            bottom: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'SOUNDSCAPES  •  4 TRACKS',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.1,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'MID-DAY\nBREAK',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 46,
                    height: 0.95,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 0.4,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _heroAction(Icons.ios_share, 'SHARE'),
                    const SizedBox(width: 34),
                    _heroAction(Icons.add, 'MY LIST'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCollectionDetails() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 0, 18, 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 2),
          const Text(
            'Engage in lush soundscapes for a short breath from reality so you return refreshed and pick up where you last left off.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white70, fontSize: 13, height: 1.45),
          ),
          TextButton(
            onPressed: () {},
            child: const Text(
              'READ MORE',
              style: TextStyle(
                color: Colors.white,
                fontSize: 11,
                fontWeight: FontWeight.w800,
                letterSpacing: 1,
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: _primaryAction(
                  icon: const Icon(Icons.play_arrow, size: 18),
                  label: 'PLAY',
                  onPressed: _playFirstSong,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _secondaryAction(
                  icon: Icons.shuffle,
                  label: 'SHUFFLE',
                  selected: _isShuffleEnabled,
                  onPressed: () {
                    setState(() => _isShuffleEnabled = !_isShuffleEnabled);
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 22),
          const Text(
            'TRACKS',
            style: TextStyle(
              color: Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.1,
            ),
          ),
          const SizedBox(height: 9),
          _trackTile(),
        ],
      ),
    );
  }

  Widget _heroIconButton(IconData icon, VoidCallback onPressed) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(icon, color: Colors.white, size: 19),
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(minWidth: 30, minHeight: 30),
    );
  }

  Widget _heroAction(IconData icon, String label) {
    return Column(
      children: [
        Icon(icon, color: Colors.white70, size: 15),
        const SizedBox(height: 5),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 8,
            fontWeight: FontWeight.w800,
            letterSpacing: 2.4,
          ),
        ),
      ],
    );
  }

  Widget _primaryAction({
    required Widget icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: icon,
      label: Text(label),
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.black,
        side: const BorderSide(color: Colors.grey, width: 1.5),
        minimumSize: const Size.fromHeight(52),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w800,
          letterSpacing: 1.1,
        ),
      ),
    );
  }

  Widget _secondaryAction({
    required IconData icon,
    required String label,
    required bool selected,
    required VoidCallback onPressed,
  }) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 16),
      label: Text(label),
      style: OutlinedButton.styleFrom(
        foregroundColor: selected ? Colors.white : Colors.white54,
        backgroundColor: selected ? Colors.white12 : Colors.transparent,
        side: BorderSide(color: selected ? Colors.white54 : Colors.white24),
        minimumSize: const Size.fromHeight(52),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w800,
          letterSpacing: 1.1,
        ),
      ),
    );
  }

  Widget _trackTile() {
    return ListView.builder(
      itemCount: SongDetails.allSongTitles.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (_) => PlayingSongScreen(songIndex: index),
              ),
            );
          },
          child: Container(
            margin: const EdgeInsets.only(bottom: 2),
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: Color(0xff151517),
              border: Border(bottom: BorderSide(color: Color(0xff252527))),
            ),
            child: Row(
              children: [
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: const Color(0xff2d3032),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Image.asset(
                    SongDetails.allSongImagePath[index],
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => const Icon(
                      Icons.image_not_supported_outlined,
                      color: Colors.white54,
                      size: 20,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        SongDetails.allSongTitles[index],
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                          fontStyle: FontStyle.italic,
                          letterSpacing: 0.3,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Text(
                            SongDetails.allSongArtists[index],
                            style: const TextStyle(
                              color: Colors.white38,
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.8,
                            ),
                          ),
                          const SizedBox(width: 6),
                          const Text(
                            '•',
                            style: TextStyle(
                              color: Colors.white38,
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.8,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            SongDetails.allSongDuration[index],
                            style: const TextStyle(
                              color: Colors.white38,
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.8,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.chevron_right,
                  color: Colors.white30,
                  size: 20,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
