import 'dart:math';

import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

class AnimatedBackground extends StatelessWidget {
  final AlignmentGeometry begin;
  final AlignmentGeometry end;
  final Duration tweenDuration;
  final List<ColorPair> colorPairs;

  AnimatedBackground({
    this.begin = Alignment.topLeft,
    this.end = Alignment.bottomRight,
    this.tweenDuration = const Duration(seconds: 3),
    @required this.colorPairs,
  });
  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    final tween = MultiTrackTween(
      List.generate(colorPairs.length, (index) {
        ColorPair colorPair = colorPairs[index];
        // ignore: deprecated_member_use
        return Track('color$index').add(
          tweenDuration,
          ColorTween(begin: colorPair.color1, end: colorPair.color2),
        );
      }),
    );

    // ignore: deprecated_member_use
    return ControlledAnimation(
      // ignore: deprecated_member_use
      playback: Playback.MIRROR,
      tween: tween,
      duration: tween.duration,
      builder: (context, animation) {
        final colors = List<Color>.generate(
            colorPairs.length, (index) => animation['color$index']);
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: begin,
              end: end,
              colors: colors,
            ),
          ),
        );
      },
    );
  }
}

class ColorPair {
  Color color1;
  Color color2;
  ColorPair({@required this.color1, @required this.color2});
}

class Particles extends StatefulWidget {
  final int numberOfParticles;
  final List<Color> colors;

  Particles({
    this.numberOfParticles = 10,
    this.colors = Colors.accents,
  });

  @override
  _ParticlesState createState() => _ParticlesState();
}

class _ParticlesState extends State<Particles> {
  final Random random = Random();

  final List<ParticleModel> particles = [];

  @override
  void initState() {
    int numberOfParticles = widget.numberOfParticles;
    List<Color> colors = widget.colors;
    List.generate(numberOfParticles, (index) {
      int colorPos = (colors.length * index / numberOfParticles).round();
      Color color = colors[colorPos];
      particles.add(ParticleModel(random, color));
    });
    particles.shuffle();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Color> colors = widget.colors;
    return Rendering(
      startTime: Duration(seconds: 30),
      onTick: _simulateParticles,
      builder: (context, time) {
        return CustomPaint(
          painter: ParticlePainter(particles, time),
        );
      },
    );
  }

  _simulateParticles(Duration time) {
    particles.forEach((particle) => particle.maintainRestart(time));
  }
}

class ParticleModel {
  AnimationProgress animationProgress;
  Animatable tween;
  Color color;
  double size;

  Random random;

  ParticleModel(this.random, this.color) {
    restart();
  }

  restart({Duration time = Duration.zero}) {
    final startPosition = Offset(-0.2 + 1.4 * random.nextDouble(), 1.2);
    final endPosition = Offset(-0.2 + 1.4 * random.nextDouble(), -0.2);
    final duration = Duration(seconds: 5 + random.nextInt(10));

    tween = MultiTrackTween([
      Track("x").add(
          duration, Tween(begin: startPosition.dx, end: endPosition.dx),
          curve: Curves.easeInOutSine),
      Track("y").add(
          duration, Tween(begin: startPosition.dy, end: endPosition.dy),
          curve: Curves.easeIn),
    ]);
    animationProgress = AnimationProgress(duration: duration, startTime: time);
    size = 0.1 + random.nextDouble() * 0.4;
  }

  maintainRestart(Duration time) {
    if (animationProgress.progress(time) == 1.0) {
      restart(time: time);
    }
  }
}

class ParticlePainter extends CustomPainter {
  List<ParticleModel> particles;
  Duration time;

  ParticlePainter(this.particles, this.time);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();

    particles.forEach((particle) {
      paint.color = particle.color.withAlpha(70);
      var progress = particle.animationProgress.progress(time);
      final animation = particle.tween.transform(progress);
      final position =
          Offset(animation["x"] * size.width, animation["y"] * size.height);
      canvas.drawCircle(position, size.width * 0.2 * particle.size, paint);
    });
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
