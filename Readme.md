# RealClock

[![ModHub Download](https://img.shields.io/badge/%5BFS17%5D%20ModHub-2.0.1.0-green.svg?style=flat-square)](https://farming-simulator.com/mod.php?lang=de&country=ch&mod_id=51459&title=fs2017)
[![ModHub Download](https://img.shields.io/badge/%5BFS19%5D%20ModHub-1.1.1.0-blue.svg?style=flat-square)](https://farming-simulator.com/mod.php?lang=de&country=ch&mod_id=117935&title=fs2019)

A small script, which shows the actual time in the upper right corner.

## Features
* Show time on ui
* Customize in xml found in your mod dir after first start 
    * Position <position isDynamic="bool" x="[0,1]" y="[0,1]"/>
        * isDynamic
            * true: automatically position the text in the upper right corner considering his dimensions, ignore x and y
            * false: Use x and y ignoring text dimension
        * x, y: the position on the screen, see small illustration below for details
        ```
        1,0 .. 1,1
        0,0 .. 1,0
        ```
    * Color and size of text <rendering color="black|white|r,g,b,a" fontSize="[0,1]"/>
        * color: supports the following text values: black, white and all rgba colors seperated by comma in the range [0..1] example king blue "0.25,0.41,0.88,1"
        * fontSize: the size of the font to display, a value in the range [0..1], default 0.015. UI Scale is used for calculating the font size to display
    * datetime format (placeholders like here in os.date -> https://www.lua.org/pil/22.1.html)

## Credits
* Grisu118
* Slivicon (config file)

# LICENSE
Copyright (c) 2017-2018 VertexDezign All rights reserved.  
Copyright (c) 2017-2018 Benjamin Leber All rights reserved.

This copyright does not impugn any trademarks or copyrights owned by Giants

Warranty disclaimer. You agree that you are using the software solely at your own risk.
VertexDezign provides the software “as is” and without warranty of any kind, and VertexDezign
for itself and its publishers and licensors hereby disclaims all express or implied warranties,
including without limitation warranties of merchantability, fitness for a particular purpose,
performance, accuracy, reliability, and non-infringement.

The [Terms and Conditions of GIANTS Software GmbH](https://www.farming-simulator.com/termsModHub.php) also apply.

## Informal explanation

An informal explanation of what this all means (this part is not legalese and can't be treated as such)

VertexDezign (we) wrote the Mod and we have the copyright on this Mod. That means the code is ours and we can
do with it what we want. It also means you can't just copy our code and use it for your own projects. 
Only we can distribute the Mod to others. We allow you to make small changes for your own gameplay or with your friends.
But you are not allowed to publish these changes openly. When you make a contribution (translations, code changes) you
give that code to us. Otherwise we would not be able to publish this Mod anymore.
If you lose your savegame or if your computer crashes due to our Mod, you can tell us and we will attempt to fix the
mod but we will not be paying for a new computer nor getting your savegame back. (Make backups!)