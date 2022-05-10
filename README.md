# flutter_sample_plugin

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
|--template|`package` or `plugin`||
|--platforms|android / ios / web / linux / macos|,区切りで複数指定可能|
|--a|kotlin or java|defaultはkotlin|
|--i|swift or objc|defaultはswift|


### コードを実装する

- テンプレート作成時に追加されている、 `exsample` ディレクトリに移動し、AndroidとiOSをそれぞれ事前にビルドしておきます。


#### Android向けのコード
- Android Studioを起動し、 `[プラグイン名]/example/android/build.gradle` を選択してプロジェクトを開きます。
- プラグイン名のモジュールを開いて `[プラグイン名]/java/[パッケージ名]/[プラグイン名]Plugin` というファイルに実装を追加していきます。

#### iOS向けのコード
- Xcodeを起動し、 `[プラグイン名]/example/ios/Runner.xcworkspace` を選択してプロジェクトを開きます。
- プロジェクトナビゲータから `Pods/Development Pods/hello/../../example/ios/.symlinks/plugins/hello/ios/Classes`　配下のファイルに実装を追加していきます。

Android Studio, Xcode上から、exsampleで自動追加されたテストアプリを実行しながら、直接プラグインのコードを修正できます。


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
- [Flutter](https://github.com/flutter/flutter)
- [pub.dev](https://pub.dev/)
- [Flutterプラグイン開発ことはじめ](https://qiita.com/napo/items/caee087c6b8dbe510e87)
- [Flutterの自作パッケージを作るときに見たものをまとめた](https://zenn.dev/rem/articles/644d0f4b480eb7)

## リポジトリ

今回作成したプラグイン
https://github.com/maropook/flutter_sample_plugin

今回作成したプラグインを呼び出しているサンプル
https://github.com/maropook/flutter_call_sample_plugin


