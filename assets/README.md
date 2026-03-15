# Assets

This game uses **code-drawn graphics** (Canvas API) instead of image files.
All cars, obstacles, coins, and the road are rendered procedurally – 
no PNG/SVG files are needed to run the game.

## Adding your own images later

If you want to replace the code-drawn graphics with custom sprites:

1. Put your PNG files in `assets/images/`
2. Update `pubspec.yaml` to list them
3. Load them in each component's `onLoad()` using `Sprite.load()`

## Audio

Place `.mp3` or `.ogg` files in `assets/audio/` and use the
`flame_audio` package to play them.  A toggle already exists in Settings.
