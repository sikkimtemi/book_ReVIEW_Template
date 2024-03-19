# Kindle-ReVIEW-Template

## 概要

Kindle Direct Publishing (KDP)向けに調整したRe:VIEW テンプレートです。デフォルト設定では、以下の使用方法を想定しています。

- Markdown記法で執筆し、pandocでRe:VIEW記法に変換する
- KDP向けのEPUB出力（表紙あり）
- ダウンロードで頒布する場合のPDF出力（表紙あり、トンボなし）
- Amazonペーパーバック向けのPDF出力（表紙なし、トンボなし）
- 印刷会社向けのPDF出力（表紙なし、トンボあり）

## 使い方

### 執筆方法

`articles`ディレクトリ直下にMarkdownファイルを配置してください。catalog.ymlに、Markdownファイルの拡張子を`.re`に変更した名前で登録してください。たとえば、`articles/aaa.md`を本文に登録するには以下のように記述します。

```yml:catalog.yml
PREDEF:
  - maegaki.re

CHAPS:
  - aaa.re

APPENDIX:

POSTDEF:
  - atogaki.re
  - contributor.re
```

`.re`ファイルは、`articles/_refiles`ディレクトリに出力されます。このディレクトリのファイルは、直接編集しないでください。

### EPUB出力する

表紙付きのEPUBを出力したい場合、次のように入力します。この形式は、Kindle Direct Publishing (KDP)に入稿するのに適しています。

```zsh
REVIEW_CONFIG_FILE=config-ebook.yml ./build-in-docker-epub.sh
```

### PDF出力する

表紙あり、トンボなしのPDFを出力したい場合、次のように入力します。技術書典やBOOTHなどで、ダウンロード形式で頒布するのに適しています。

```zsh
REVIEW_CONFIG_FILE=config-ebook.yml ./build-in-docker-pdf.sh
```

表紙なし、トンボなしのPDFを出力したい場合、次のように入力します。この形式は、Amazonペーパーバックを作成するのに適しています。

```zsh
REVIEW_CONFIG_FILE=config-paperback.yml ./build-in-docker-pdf.sh
```

表紙なし、トンボありのPDFを出力したい場合、次のように入力します。この形式は、印刷会社に入稿するのに適しています。

```zsh
./build-in-docker-pdf.sh
```
