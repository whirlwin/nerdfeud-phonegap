# Nerdfeud
Nerdfeud is a pet project and a game.

## Prerequisites
- Ruby interpreter
- Android SDK

## Setup
Clone this repository
>     git clone git@github.com:whirlwin/nerdfeud.git

Navigate into the project's directory, configure and start the application.
>     cd nerdfeud
>     ./config && ./start

## Known issues
When trying to build the project, a NullPointerException may occur.
This is most likely due to Ant, and you will have to run:
>     rm -rf bin/ gen/
