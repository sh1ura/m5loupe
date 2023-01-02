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
