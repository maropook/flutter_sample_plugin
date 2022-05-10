
# FlutterでPluginを自作する

今回はKotlinでAndroid，swiftでiosでプラグインの開発をします。
PluginをPub.devに公開せずに、Githubに公開して参照する方法を取ります。

## flutterのpluginとは
Flutterには、Dart PackagesとPlugin Packagesの2種類のPackageがあります。
Dart Packages
Flutterフレームワークのみを使ったPackageです。Dartだけで書きます。

Plugin Packages
iOSやAndroidのネイティブAPIを活用したPackageです。Dartだけではなく、iOSならSwiftかObjective-C、AndroidならKotlinかJavaを書くことになります。


## Plugin用のプロジェクトを作る

まずは下記のようなコマンドでPluginの雛型を作成します。
今回はKotlinでAndroid，swiftでiosのPluginを開発したかったので下記のコマンドを利用しました。

`flutter create --org com.example --template=plugin --platforms=android,ios -i swift -a kotlin [プラグインの名前]`


flutter createコマンドのオプションは下記になります。

|オプション|指定できる値|補足|
|---|---|---|
|--org|任意の文字列||
|--template|`package` または `plugin`||
|--platforms|android / ios / web / linux / macos| , 区切りで複数指定|
|--a|kotlin または java|defaultはkotlin|
|--i|swift または objc|defaultはswift|


### コードを実装する

- テンプレート作成時に追加されている、 `example` ディレクトリに移動し、AndroidとiOSをそれぞれ事前にビルドしておきます。
exampleではデフォルトで端末のバージョンを表示するコードが書いてあります．
<img width="432" alt="スクリーンショット 2022-05-10 11 22 55" src="https://user-images.githubusercontent.com/84751550/167543679-ab46c906-d7b8-4813-9423-faae6174a58e.png">



#### Android向けのコード
- Android Studioを起動し、 `[プラグイン名]/example/android/build.gradle` を選択してプロジェクトを開きます。
- プラグイン名のモジュールを開いて `[プラグイン名]/java/[パッケージ名]/[プラグイン名]Plugin` というファイルに実装を追加していきます。
<img width="688" alt="スクリーンショット 2022-05-10 11 23 21" src="https://user-images.githubusercontent.com/84751550/167543665-2ec1f07e-2a74-441b-b4c2-dc67f75bc2b7.png">
<img width="941" alt="スクリーンショット 2022-05-10 11 25 26" src="https://user-images.githubusercontent.com/84751550/167543848-de4c2f1e-219d-4152-baed-8cb608d382db.png">


#### iOS向けのコード
- Xcodeを起動し、 `[プラグイン名]/example/ios/Runner.xcworkspace` を選択してプロジェクトを開きます。
- プロジェクトナビゲータから `Pods/Development Pods/hello/../../example/ios/.symlinks/plugins/hello/i
os/Classes`　配下のファイルに実装を追加していきます。

<img width="1059" alt="スクリーンショット 2022-05-10 11 28 32" src="https://user-images.githubusercontent.com/84751550/167543882-d5076e87-7ee6-4b86-beb3-d87c36565065.png">

Android Studio, Xcode上から、exampleで自動追加されたテストアプリを実行しながら、直接プラグインのコードを修正できます。


### Githubに公開して参照できるようにする
自作したPluginをGithubに公開し、そのPluginを利用したいアプリのpubspec.yamlを下記のように編集します。
リポジトリのurlとパッケージの名前を置き換えてください。今回は`flutter_sample_plugin`という名前で作成しました。

```yaml:pubspec.yaml
dependencies:
  flutter_sample_plugin:
    git:
      url: git@github.com:xxxxx/flutter_sample_plugin.git
      ref: HEAD
```

編集したら`flutter pub upgrade`しましょう。
これでpub.devに公開されたPluginと同じように利用することができます。

git管理しているPlugin側を更新した場合も同コマンドで最新のものが取得できます。



## 参考
- [Flutterプラグイン開発ことはじめ](https://qiita.com/napo/items/caee087c6b8dbe510e87)
- [Flutterの自作パッケージを作るときに見たものをまとめた](https://zenn.dev/rem/articles/644d0f4b480eb7)

## リポジトリ
プラグイン: https://github.com/maropook/flutter_sample_plugin

プラグインをテストしているプロジェクト: https://github.com/maropook/flutter_call_sample_plugin

## 補足
今回作成したプラグイン
https://github.com/maropook/flutter_sample_plugin

`flutter create --org com.example --template=plugin --platforms=android,ios -i swift -a kotlin flutter_sample_plugin`をしただけです。


今回作成したプラグインを呼び出しているサンプル
https://github.com/maropook/flutter_call_sample_plugin

`pubspec.yaml`で、作成した`flutter_sample_plugin`プラグインの場所を指定し、`flutter pub get`をして取得します。`main.dart`を以下のように編集し、`flutter_sample_plugin`プラグインを使うようにしています。

```yaml:pubspec.yaml
  flutter_sample_plugin:
    git:
      url: https://github.com/maropook/flutter_sample_plugin.git
      ref: HEAD
```
```dart:main.dart
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_sample_plugin/flutter_sample_plugin.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    String platformVersion;
    try {
      platformVersion = await FlutterSamplePlugin.platformVersion ??
          'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Text('Running on: $_platformVersion\n'),
        ),
      ),
    );
  }
}

```


