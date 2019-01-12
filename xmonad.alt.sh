#!/usr/bin/env bash
cp ~.xmonad/xmonad.alt.hs ~.xmonad/xmonad.hs && xmonad --recompile && xmonad --restart
