#!/usr/bin/env bash
cp ~.xmonad/xmonad.super.hs ~.xmonad/xmonad.hs && xmonad --recompile && --restart
