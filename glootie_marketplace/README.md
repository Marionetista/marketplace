# glootie_marketplace

Glootie is a Rick And Morty character from "The Old Man and the Seat" episode.
The cool thing is: all colors used in this app is on Glootie's skin. 
And yes, I've developed his app.

## Getting Started
This project is a starting point for a Flutter application.
[Get Started](https://flutter.dev/docs/get-started/install)

## Run app
flutter run

## Show Tests Coverage

Install lcov in your mac:

```brew install lcov```

After, run command for generate tests:

```flutter test --coverage```

Generate files for show coverage tests:

```genhtml -o coverage coverage/lcov.info```


## App Architecture


## Dependencies

  # graphql_flutter: ^5.0.0
    -Used to implement GraphQL.
    - Dart Package: <https://pub.dev/packages/graphql_flutter>
    - GitHub: <https://github.com/zino-app/graphql-flutter>
    - License: [MIT](https://github.com/zino-app/graphql-flutter/blob/master/packages/graphql_flutter/LICENSE)

  # flutter_bloc: ^7.0.1
    -Used to separate presentation from business logic. Following the BLoC pattern facilitates testability and reusability.
    - Dart Package: <https://pub.dev/packages/bloc>
    - GitHub: <https://github.com/felangel/bloc>
    - License: [MIT](https://github.com/felangel/bloc/blob/master/LICENSE)

  # equatable: ^2.0.2
    -Comparsion simplified.
    - Dart Package: <https://pub.dev/packages/equatable>
    - GitHub: <https://github.com/felangel/equatable>
    - License: [MIT](https://pub.dev/packages/equatable/license)

  # flutter_launcher_icons: ^0.9.0
    -Used to apply the app launch icon.
    - Dart Package: <https://pub.dev/packages/flutter_launcher_icons>
    - GitHub: <https://github.com/fluttercommunity/flutter_launcher_icons>
    - License: [MIT](https://pub.dev/packages/flutter_launcher_icons/license)

  # intl: ^0.17.0
    -Comparsion simplified.
    - Dart Package: <https://pub.dev/packages/equatable>
    - GitHub: <https://github.com/felangel/equatable>
    - License: [MIT](https://pub.dev/packages/equatable/license)
 
  # mocktail: ^0.1.4
    -Mock package inspired by Mockito for Null Safety apps.
    - Dart Package: <https://pub.dev/packages/mocktail>
    - GitHub: <https://github.com/felangel/mocktail>
    - License: [MIT](https://pub.dev/packages/mocktail/license)
  
  # bloc_test: ^8.0.2
    -Easy way to test blocs and cubits.
    - Dart Package: <https://pub.dev/packages/bloc_test>
    - GitHub: <https://github.com/felangel/bloc/tree/master/packages/bloc_test>
    - License: [MIT](https://pub.dev/packages/bloc_test/license)
  
  