/*
 * @Author:  
 * @Date: 2024-06-22 08:56:09
 * @LastEditors:  
 * @LastEditTime: 2024-06-22 11:19:11
 * @Description: 
 */
import 'package:flame/cache.dart';
import 'package:flame/components.dart';

class DashAnimations {
  DashAnimations({Images? images}) {
    _images = images ?? Images(prefix: 'assets/animations/');
  }

  late final Images _images;

  Images get images => _images;

  late final SpriteAnimation idleAnimation;
  late final SpriteAnimation waveAnimation;
  late final SpriteAnimation happyAnimation;
  late final SpriteAnimation sadAnimation;
  late final SpriteAnimation thinkingAnimation;

  Future<void> load() async {
    final [idle, wave, happy, sad, thinking] = await Future.wait([
      _images.load('dash_idle_animation.png'),
      _images.load('dash_wave_animation.png'),
      _images.load('dash_happy_animation.png'),
      _images.load('dash_sad_animation.png'),
      _images.load('dash_thinking_animation.png')
    ]);

    idleAnimation = SpriteAnimation.fromFrameData(
        idle,
        SpriteAnimationData.sequenced(
            amount: 12,
            amountPerRow: 4,
            stepTime: 0.07,
            textureSize: Vector2.all(1500)));

    waveAnimation = SpriteAnimation.fromFrameData(
        wave,
        SpriteAnimationData.sequenced(
            amount: 25,
            amountPerRow: 5,
            stepTime: 0.07,
            textureSize: Vector2.all(1500)));
    happyAnimation = SpriteAnimation.fromFrameData(
        happy,
        SpriteAnimationData.sequenced(
            amount: 12,
            amountPerRow: 4,
            stepTime: 0.07,
            textureSize: Vector2.all(1500)));
    sadAnimation = SpriteAnimation.fromFrameData(
        sad,
        SpriteAnimationData.sequenced(
            amount: 12,
            amountPerRow: 4,
            stepTime: 0.07,
            textureSize: Vector2.all(1500)));

    thinkingAnimation = SpriteAnimation.fromFrameData(
        thinking,
        SpriteAnimationData.sequenced(
            amount: 24,
            amountPerRow: 5,
            stepTime: 0.07,
            textureSize: Vector2.all(1500)));
  }
}

class Dash {
  final LoaderDashStatus dashStatus;

  Dash(Images images) : dashStatus = LoaderDashStatus(images);

  void idle() => dashStatus.idleStatus();
  void happy() => dashStatus.happyStatus();
  void wave() => dashStatus.waveStatus();
  void thinking() => dashStatus.thinkingStatus();
  void sad() => dashStatus.sadStatus();
}

abstract class DashStatus {
  void idleStatus();
  void happyStatus();
  void waveStatus();
  void thinkingStatus();
  void sadStatus();
}

mixin Loader {
  late final Images idle;
  late final Images wave;
  late final Images happy;
  late final Images sad;
  late final Images thinking;

  late final SpriteAnimation idleAnimation;
  late final SpriteAnimation waveAnimation;
  late final SpriteAnimation happyAnimation;
  late final SpriteAnimation sadAnimation;
  late final SpriteAnimation thinkingAnimation;
}

class LoaderDashStatus with Loader implements DashStatus {
  final Images _images;

  LoaderDashStatus(this._images);

  Future<void> load() async {
    final loadedImages = await Future.wait([
      _images.load('dash_idle_animation.png'),
      _images.load('dash_wave_animation.png'),
      _images.load('dash_happy_animation.png'),
      _images.load('dash_sad_animation.png'),
      _images.load('dash_thinking_animation.png')
    ]);

    idle = loadedImages[0];
    wave = loadedImages[1];
    happy = loadedImages[2];
    sad = loadedImages[3];
    thinking = loadedImages[4];

    idleStatus();
    happyStatus();
    waveStatus();
    thinkingStatus();
    sadStatus();
  }

  @override
  void idleStatus() {
    idleAnimation = SpriteAnimation.fromFrameData(
      idle,
      SpriteAnimationData.sequenced(
        amount: 12,
        amountPerRow: 4,
        stepTime: 0.07,
        textureSize: Vector2.all(1500),
      ),
    );
  }

  @override
  void happyStatus() {
    happyAnimation = SpriteAnimation.fromFrameData(
      happy,
      SpriteAnimationData.sequenced(
        amount: 12,
        amountPerRow: 4,
        stepTime: 0.07,
        textureSize: Vector2.all(1500),
      ),
    );
  }

  @override
  void waveStatus() {
    waveAnimation = SpriteAnimation.fromFrameData(
      wave,
      SpriteAnimationData.sequenced(
        amount: 25,
        amountPerRow: 5,
        stepTime: 0.07,
        textureSize: Vector2.all(1500),
      ),
    );
  }

  @override
  void thinkingStatus() {
    thinkingAnimation = SpriteAnimation.fromFrameData(
      thinking,
      SpriteAnimationData.sequenced(
        amount: 24,
        amountPerRow: 5,
        stepTime: 0.07,
        textureSize: Vector2.all(1500),
      ),
    );
  }

  @override
  void sadStatus() {
    sadAnimation = SpriteAnimation.fromFrameData(
      sad,
      SpriteAnimationData.sequenced(
        amount: 12,
        amountPerRow: 4,
        stepTime: 0.07,
        textureSize: Vector2.all(1500),
      ),
    );
  }
}

void main() async {
  final images = Images();
  final dash = Dash(images);

  await dash.dashStatus.load();

  dash.idle();
  dash.happy();
  dash.wave();
  dash.thinking();
  dash.sad();
}
