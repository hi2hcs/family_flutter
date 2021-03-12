#### 1. 国际化生成

先在lib/l10n/localizations.dart中添加方法，运行：
```sh
flutter pub pub run intl_translation:extract_to_arb --output-dir=lib/l10n lib/l10n/localizations.dart
```

在lib/l10n/intl_messages.arb中复制生成的json，追加到目标intl_*.arb中并修改相关翻译，运行：
(Windows下会因通配符问题无法识别最后一段路径，在git bash中执行即可)
```sh
flutter pub pub run intl_translation:generate_from_arb --output-dir=lib/l10n/generated \
   --no-use-deferred-loading lib/l10n/localizations.dart lib/l10n/intl_??.arb
```

#### 2. JSON类生成

```sh
flutter packages pub run build_runner build --delete-conflicting-outputs
```