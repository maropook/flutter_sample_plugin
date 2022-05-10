# flutter_sample_plugin


`flutter create --org com.example --template=plugin --platforms=android,ios -i swift -a kotlin flutter_sample_plugin`

Android向けのコード
Android Studioを起動し、 [プラグイン名]/example/android/build.gradle を選択してプロジェクトを開きます。
プラグイン名のモジュールが存在していると思いますので、そちらを開いて、 [プラグイン名]/java/[パッケージ名]/[プラグイン名]Plugin というファイルに実装を追加していけばOKです。
iOS向けのコード
Xcodeを起動し、 [プラグイン名]/example/ios/Runner.xcworkspace を選択してプロジェクトを開きます。
プロジェクトナビゲータから Pods/Development Pods/hello/../../example/ios/.symlinks/plugins/hello/ios/Classes　配下のファイルに実装を追加していけばOKです。
つまり、Android Studio, Xcode上から、exsampleで自動追加されたテストアプリを実行しながら、直接プラグインのコードを修正できるということですね！
本当に作りやすく考えられていて、感動します。

主に変更するファイルたちは下記になります。

/lib/[プラグイン名].dart ファイル : パブリックAPIとなるメソッドを定義する
/android/配下 : Androidプラットフォーム向けのコード
/ios/配下 : iOSプラットフォーム向けのコード
テンプレート作成時に追加されている、 exsample ディレクトリに移動し、AndroidとiOSをそれぞれ事前にビルドしておきます。


## 参考
https://qiita.com/napo/items/caee087c6b8dbe510e87




### ②pluginのテンプレートを作成する
- `flutter create` コマンドを利用して、任意のディレクトリでpluginのテンプレートを作成する
- 今回は下記のように `jp.co.hoge.fuga` というパッケージ名で、 `plugin` をAndroid,iOS向けに作成することにしました！

```shell:terminal.app
$ flutter create --org jp.co.hoge.fuga --template=plugin --platforms=android,ios FlPluginSample
```

flutter createコマンドのオプションは下記になります。

|オプション|指定できる値|補足|
|---|---|---|
|--org|任意の文字列||
|--template|`package` or `plugin`||
|--platforms|android / ios / web / linux / macos|,区切りで複数指定可能|
|--a|kotlin or java|defaultはkotlin|
|--i|swift or objc|defaultはswift|

### ③コードを実装する
- 主に変更するファイルたちは下記になります。
 - `/lib/[プラグイン名].dart` ファイル : パブリックAPIとなるメソッドを定義する
 - `/android/配下` : Androidプラットフォーム向けのコード
 - `/ios/配下` : iOSプラットフォーム向けのコード

- テンプレート作成時に追加されている、 `exsample` ディレクトリに移動し、AndroidとiOSをそれぞれ事前にビルドしておきます。


#### Android向けのコード
- Android Studioを起動し、 `[プラグイン名]/example/android/build.gradle` を選択してプロジェクトを開きます。
- プラグイン名のモジュールが存在していると思いますので、そちらを開いて、 `[プラグイン名]/java/[パッケージ名]/[プラグイン名]Plugin` というファイルに実装を追加していけばOKです。

#### iOS向けのコード
- Xcodeを起動し、 `[プラグイン名]/example/ios/Runner.xcworkspace` を選択してプロジェクトを開きます。
- プロジェクトナビゲータから `Pods/Development Pods/hello/../../example/ios/.symlinks/plugins/hello/ios/Classes`　配下のファイルに実装を追加していけばOKです。

つまり、Android Studio, Xcode上から、exsampleで自動追加されたテストアプリを実行しながら、直接プラグインのコードを修正できるということですね！
本当に作りやすく考えられていて、感動します。

#### パブリックAPIと各プラットフォームのコードを接続する
パブリックAPIを定義している、.dartと、Android, iOS向けにそれぞれ記述したコードを、
[platform-channels](https://flutter.dev/docs/development/platform-integration/platform-channels) を用いて実装をおこなう


## 公開する場合
### ドキュメントを記載する
- プラグインの挙動とは直接関係はないのですが、外部への公開を考えている場合、下記の4点が必要となります！
 - `README.md` そのプラグインの解説を記載したファイル
 - `CHANGELOG.md` 各バージョンでの変更を文書化したファイル
 - `LICENSE` そのプラグインの[ライセンスを記述](https://flutter.dev/docs/development/packages-and-plugins/developing-packages#adding-licenses-to-the-license-file)する
 - パブリックにしているAPIに対して、[コメントを記述](https://dart.dev/guides/language/effective-dart/documentation)する(コメントを基に自動でdartdocが生成されAPIドキュメントとなる)

### プラグインを公開する
Flutterでは、 公式で[pub.dev](https://pub.dev/) というDartパッケージを一覧できるサイトがあります。
他の開発者にも使ってもらえるよう、公開したい場合は下記をおこなってください。

- 公開するプラグインが問題ないかを事前に --dry-run をおこなってチェックする

```shell:terminal.app
$ flutter pub publish --dry-run
```

- 問題なければ、下記コマンドで、プラグインを公開できます！ ※一度公開してしまうと、削除はできないので慎重に！

```shell:terminal.app
$ flutter pub publish
```


- 公開したプラグインは④で準備したドキュメントを基にしてスコアリングされます。

(下記は公式のパッケージ `provider` のスコアです)


プラグインに対するスコアが視覚的にわかりやすいので、
ドキュメントを充実させたくなるモチベーションがあがるので楽しいですね！



## 参考
- [Flutter](https://github.com/flutter/flutter)
- [pub.dev](https://pub.dev/)
- [Flutterプラグイン開発ことはじめ](https://qiita.com/napo/items/caee087c6b8dbe510e87)

