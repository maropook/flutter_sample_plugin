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

A new flutter plugin project.

## Getting Started

This project is a starting point for a Flutter
[plug-in package](https://flutter.dev/developing-packages/),
a specialized package that includes platform-specific implementation code for
Android and/or iOS.

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
