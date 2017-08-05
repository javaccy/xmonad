# xmonad
xmonad.hs ~/.xmonad
.xmobarrc  ~/.xmobarrc

xmonad --recompile


#设置中文显示
export LANG=zh_CN.UTF-8
export LANGUAGE=zh_CN:en_US

#设置中文输入
export LC_CTYPE=zh_CN.UTF-8
export LC_ALL=zh_CN.UTF-8

export GTK_IM_MODULE="@im=fcitx"
#exec mate-session &
exec openbox
exec fcitx &
