import 'dart:html';
import 'dart:math';
import 'package:fire/ball.dart';

class Fire {
  final Random random = new Random();
  final CanvasRenderingContext2D context;
  final List<Ball> balls = [];
  var mouse = new Point(232, 232);

  Fire(CanvasElement canvas) : context = canvas.context2D {
    canvas.onMouseMove.listen((e) => mouse = e.client);
  }

  void draw() {
    // create new balls
    final newBalls = new List<Ball>.generate(10, (i) {
      return new Ball(
          x: mouse.x.toDouble(),
          y: mouse.y.toDouble(),
          vx: random.nextDouble() * 10 - 5,
          vy: random.nextDouble() * 10 - 7,
          size: random.nextDouble() * 35 + 10,
          r: (random.nextDouble() * 128 + 127).floor(),
          g: (random.nextDouble() * 255 * 0.5).floor(),
          b: (random.nextDouble() * 255 * 0.5).floor(),
          cx: mouse.x);
    });

    balls.addAll(newBalls);

    // update balls
    for (final ball in balls) {
      ball
        ..x += ball.vx
        ..y += ball.vy
        ..vy -= 0.4
        ..vx += (ball.cx - ball.x) / ball.size * 0.5
        ..size -= 1.3;
    }

    // remove balls
    balls.removeWhere((ball) => ball.size < 1.0);

    // fill canvas with a color
    context.globalCompositeOperation = 'source-over';
    context.fillStyle = 'rgb(0, 0, 0)';
    context.fillRect(0, 0, 500, 500);

    // draw balls
    context.globalCompositeOperation = 'lighter';

    for (final ball in balls) {
      context.beginPath();
      final edgecolor0 =
          "rgba(${ball.r}, ${ball.g}, ${ball.b}, ${ball.size / 20})";
      final edgecolor1 = "rgba(${ball.r}, ${ball.g}, ${ball.b}, 0)";
      final gradblur = context.createRadialGradient(
          ball.x, ball.y, 0, ball.x, ball.y, ball.size);
      gradblur.addColorStop(0, edgecolor0);
      gradblur.addColorStop(1, edgecolor1);
      context.fillStyle = gradblur;
      context.arc(ball.x, ball.y, ball.size, 0, PI * 2, false);
      context.fill();
    }
  }
}
