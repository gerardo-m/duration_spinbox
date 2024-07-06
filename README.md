# Duration Spinbox

[![style: very good analysis][very_good_analysis_badge]][very_good_analysis_link]
[![Powered by Mason](https://img.shields.io/endpoint?url=https%3A%2F%2Ftinyurl.com%2Fmason-badge)](https://github.com/felangel/mason)
[![License: MIT][license_badge]][license_link]

A duration widget for Flutter, heavily inspired by flutter_spinbox

## Installation 💻

**❗ In order to start using Duration Spinbox you must have the [Flutter SDK][flutter_install_link] installed on your machine.**

Install via `flutter pub add`:

```sh
dart pub add duration_spinbox
```

or just add this line to your pubspec.yaml

```yaml
duration_spinbox: ^0.1.0
```

## Usage

Currently this only shows the Duration in the format `mm:ss`, more customization
options to come in the future.

The only required parameter is `value` which is the initial/current duration.

```dart
DurationSpinbox(
  value: Duration(minutes: 1),
),
```

This is designed to work similar to `DropDownButton` where you have to update
the value when changed. Like this:

```dart
var _duration = Duration(minutes: 1);

...

DurationSpinbox(
  value: _duration,
  onChanged: (value){
    setState((){
      _duration = value;
    });
  },
),
```

You can set a minimum and maximum value. By default minimum is `Duration.zero`
but max is by default `null`.

```dart
DurationSpinbox(
  value: Duration(minutes: 1),
  min: Duration(minutes: 1),
  max: Duration(minutes: 5),
),
```

You can set the `stepValue` which is the Duration the value will be increased
or decreased. By default it is `Duration(minutes: 1)`.

```dart
 DurationSpinbox(
  value: Duration.zero,
  stepValue: Duration(minutes: 5),
),
```

By default min is equal to Duration.zero, to allow negative values you have to 
set min to null manually.

```dart
 DurationSpinbox(
  value: Duration(minutes: 0),
  min: null,
),
```

## What's next

* Formatting options
* Editing options
* Customization options
---

[flutter_install_link]: https://docs.flutter.dev/get-started/install
[license_badge]: https://img.shields.io/badge/license-MIT-blue.svg
[license_link]: https://opensource.org/licenses/MIT
[logo_black]: https://raw.githubusercontent.com/VGVentures/very_good_brand/main/styles/README/vgv_logo_black.png#gh-light-mode-only
[logo_white]: https://raw.githubusercontent.com/VGVentures/very_good_brand/main/styles/README/vgv_logo_white.png#gh-dark-mode-only
[mason_link]: https://github.com/felangel/mason
[very_good_analysis_badge]: https://img.shields.io/badge/style-very_good_analysis-B22C89.svg
[very_good_analysis_link]: https://pub.dev/packages/very_good_analysis
[very_good_ventures_link]: https://verygood.ventures
[very_good_ventures_link_light]: https://verygood.ventures#gh-light-mode-only
[very_good_ventures_link_dark]: https://verygood.ventures#gh-dark-mode-only
