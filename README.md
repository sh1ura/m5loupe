# m5loupe
External pixel loupe display for MacOS on M5stack ATOM Matrix.

Video : https://youtu.be/RgkL3v5337U

## You need
* [M5stack ATOM Matrix](https://docs.m5stack.com/en/core/atom_matrix)
* Mac

## How to
* Setup Arduino IDE for your M5Stack ATOM Matrix (please check sample program runs on your ATOM).
* Flash the code "m5loupe.ino" to your ATOM.
* Memorize the name of serial port (ex. `/dev/cu.usbserial-XXXXXXXXXX`) of your ATOM. 
* Modify the code for your mac named "loupe.m". At line 11, set the serial port device name.
* Compile the sender program on the terminal of your Mac by entering the command `cc -o loupe -framework Cocoa loupe.m` . (If it is your first time to use C compiler, Mac asks to confirm the installation of command line tools)
* Run the sender program by the command `./loupe` or double click of compiled binary (loupe).

## Trouble shooting
* If the program on MacOS can not connect to ATOM Matrix, shut down the Arduino IDE. If serial monitor is running, the port is exclusive　for IDE.
* Please edit the code for 4 way postures of ATOM Matrix.

<hr>

# m5loupe
M5stack ATOM Matrix を用いた MacOS 用の　外付けルーペ（画素拡大表示）です．

ビデオ https://youtu.be/RgkL3v5337U

## 必要なもの
* [M5stack ATOM Matrix](https://docs.m5stack.com/en/core/atom_matrix)
* Mac

## 使い方
* Arduino IDE を M5Stack ATOM Matrix が使えるように設定してください．(ATOM で何らかのサンプルプログラムが動作するのを確認してください）
* プログラム "m5loupe.ino" を ATOM に書き込んでください．
* Arduino IDE で ATOM への書き込みに用いたシリアルポートの名前（例： `/dev/cu.usbserial-XXXXXXXXXX`)をメモしてください．
* Mac 用のプログラム "loupe.m" の11行目を編集して，上記のシリアルポートのデバイス名を記入してください．
* この送出用プログラムをコンパイルします．コンパイルには，ターミナルで次のコマンドを入力してください．　`cc -o loupe -framework Cocoa loupe.m`  (もしあなたのMacではじめてCコンパイラを使用するときであれば，コマンドラインツールをインストールするかどうか聞いてくるので，インストールしてください）
* コンパイルで出来た創出用プログラムを以下のコマンド `./loupe` で実行するか，実行ファイル "loupe" をダブルクリックして実行してください．

## 問題解決
* Mac が ATOM Matrix に接続できないときは， Arduino IDE を終了してください．もし「シリアルモニタ」が動いている場合はシリアルポートが専有されています．
* ATOM Matrix の姿勢は４種類（USBポートの向きが上下左右）に変えられます．プログラムを変更してください．
