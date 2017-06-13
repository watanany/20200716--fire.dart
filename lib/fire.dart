import 'dart:html';
import 'dart:math';
import 'package:fire/ball.dart';

class Fire {
  Random random;
  CanvasRenderingContext2D context;
  int mouseX = 232;
  int mouseY = 232;
  List<Ball> balls = [];

  Fire() {
    final CanvasElement canvas = document.querySelector('canvas');
    canvas.onMouseMove.listen((e) {
      mouseX = e.client.x;
      mouseY = e.client.y;
    });
    context = canvas.context2D;
    random = new Random();
  }

  void draw() {
    context.globalCompositeOperation = 'source-over';
    context.fillStyle = 'rgb(0, 0, 0)';
    context.fillRect(0, 0, 500, 500);

    context.globalCompositeOperation = 'lighter';

    for (int i = 0; i < 10; i++) {
      final ball = new Ball(
          x: mouseX.toDouble(),
          y: mouseY.toDouble(),
          vx: random.nextDouble() * 10 - 5,
          vy: random.nextDouble() * 10 - 7,
          size: random.nextDouble() * 35 + 10,
          r: (random.nextDouble() * 128 + 127).floor(),
          g: (random.nextDouble() * 255 * 0.5).floor(),
          b: (random.nextDouble() * 255 * 0.5).floor(),
          cx: mouseX);
      balls.add(ball);
    }

    for (var i = balls.length - 1; 0 <= i; i--) {
      final ball = balls[i];
      ball.x += ball.vx;
      ball.y += ball.vy;
      ball.vy -= 0.4;
      ball.vx += (ball.cx - ball.x) / ball.size * 0.5;
      ball.size -= 1.3;

      if (ball.size < 1.0) {
        balls.removeAt(i);
      } else {
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
}
