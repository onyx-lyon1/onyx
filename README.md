
<h1 align="center">
  <br>
  <a href="https://onyx-lyon1.github.io/"><img src="https://onyx-lyon1.github.io/assets/Onyx_v16_onyx.png" alt="Onyx" width="200"></a>
  <br>
  Onyx : Everything for Lyon 1
  <br>
</h1>

<h4 align="center">The student application for Claude Bernard Lyon 1 University </h4>

<p align="center">
  <a href="https://github.com/onyx-lyon1/onyx/releases">
    <img src="https://img.shields.io/github/release/onyx-lyon1/onyx?include_prereleases=&sort=semver&color=blue"
         alt="Releases">
  </a>

  <a href="https://creativecommons.org/licenses/by-nc/4.0/">
      <img src="https://img.shields.io/badge/License-CC BY--NC-blue">
  </a>
</p>

<p align="center">
  <a href="#features">Features</a>
  <a href="#download">Download</a>
  <a href="#contribute">Contribute</a>
  <a href="#build">Build</a>
  <a href="#license">License</a>
</p>

![Banner](apps/onyx/assets/screenshots/banner_en.png)


Onyx is an unofficial, open-source application that lets you access all Université Claude Bernard Lyon 1 services from your phone.

## Features

<p align="center">
<img src="apps/onyx/assets/screenshots/onyx_screenshot_calendar_en.png" width="18%"></img> <img src="apps/onyx/assets/screenshots/onyx_screenshot_email_en.png" width="18%"></img> <img src="apps/onyx/assets/screenshots/onyx_screenshot_grades_en.png" width="18%"></img> <img src="apps/onyx/assets/screenshots/onyx_screenshot_map_en.png" width="18%"></img> <img src="apps/onyx/assets/screenshots/onyx_screenshot_izly_en.png" width="18%"></img>
</p>

## Download

Coming soon.

## Contribute

An application for students, by students. Feel free to contribute to this project by opening issues or pull requests.
We really appreciate any help. You can also chat with us on [Discord](https://discord.gg/AtCc3pcaNm).

## Build

### Run the integration test

Start app in test mode : `flutter run integration_test/app_test.dart --host-vmservice-port 9753 --disable-service-auth-codes --dart-define CONVENIENT_TEST_MANAGER_HOST="an ip address" --dart-define CONVENIENT_TEST_APP_CODE_DIR=/path/to/onyx`.

Replace `an ip address` with the ip address of your computer (if using an emulator, set to 10.0.2.2).
Replace `/path/to/onyx` with the path to the onyx directory.

Run the test manager (can be found here : https://github.com/fzyzcjy/flutter_convenient_test/)
`flutter run packages/convenient_test_manager/lib/main.dart --profile --dart-define CONVENIENT_TEST_WORKER_HOST="an ip address" -d linux`.

Replace `an ip address` with the ip address of your phone (if using an emulator, set to 127.0.0.1).

Replace `linux` with your operating system.

Common issue :
- You will maybe need to install vlc-dev on linux to be able to compile the test manager.
- Enable isolation in the test manager to run all the tests at once.

## License

This work is licensed under the Creative Commons Attribution-NonCommercial 4.0 International License. To view a copy of this license, visit http://creativecommons.org/licenses/by-nc/4.0/ or send a letter to Creative Commons, PO Box 1866, Mountain View, CA 94042, USA.\

<p align="center">
<img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by-nc/4.0/88x31.png" />
</p>
