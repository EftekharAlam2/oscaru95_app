import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oscaru95/gen/assets.gen.dart';
import 'package:oscaru95/gen/colors.gen.dart';
import 'package:oscaru95/helpers/all_routes.dart';
import 'package:oscaru95/helpers/navigation_service.dart';
import 'package:video_player/video_player.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  late VideoPlayerController _controller;
  bool _isVideoInitialized = false;
  bool _hasNavigated = false;

  @override
  void initState() {
    super.initState();

    // Hide system UI for full immersive video
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

    _controller = VideoPlayerController.asset(
     Assets.images.logoVideo
    )
      ..initialize().then((_) {
        _controller.setVolume(1.0);
        setState(() {
          _isVideoInitialized = true;
        });
        _controller.play();
        _controller.addListener(_videoListener);
      });
  }

  void _videoListener() {
    if (_controller.value.isInitialized &&
        !_controller.value.isPlaying &&
        _controller.value.position >= _controller.value.duration &&
        !_hasNavigated) {
      _hasNavigated = true;
      _controller.removeListener(_videoListener);

      // Navigate to the next screen when the video finishes
      NavigationService.navigateToReplacement(Routes.loading);
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_videoListener);
    _controller.dispose();

    // Restore system UI when leaving
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Prevent white flash on load
      body: _isVideoInitialized
          ? SizedBox.expand(
              child: FittedBox(
                fit: BoxFit.fitWidth, // Fill and crop to cover screen
                child: SizedBox(
                  width: _controller.value.size.width,
                  height: _controller.value.size.height,
                  child: VideoPlayer(_controller),
                ),
              ),
            )
          : const Center(child: CircularProgressIndicator(color: AppColors.c1A1A1A,)),
    );
  }
}
