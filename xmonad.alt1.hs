-- 另一种写法，区别于M1-x  形式主要是 additionalKeys 和 additionalKeysP 的区别
--
-- Configuration file for XMonad + MATE
--
--  Usage:
--      * Copy this file to ~/.xmonad/
--      * Run:    $ xmonad --recompile
--      * Launch: $ xmonad --replace
--      [Optional] Create an autostart to command with "xmonad --replace"
--
--  Author: Arturo Fernandez <arturo at bsnux dot com>
--  Inspired by:
--      Spencer Janssen <spencerjanssen@gmail.com>
--      rfc <reuben.fletchercostin@gmail.com>
--  License: BSD
--
import XMonad
import XMonad.Config.Desktop
import XMonad.Util.Run (spawnPipe)
import qualified Data.Map as M
import System.Environment (getEnvironment)
import XMonad.Util.EZConfig
import XMonad.Hooks.SetWMName
import XMonad.Hooks.ManageHelpers
import qualified XMonad.StackSet as W

mateConfig = desktopConfig
    { terminal = "mate-terminal"
    , keys     = mateKeys <+> keys desktopConfig
    , startupHook = setWMName "LG3D"
    , focusFollowsMouse = False
    }

mateKeys (XConfig {modMask = modm}) = M.fromList $
    [ ((modm, xK_p), mateRun)
    , ((modm .|. shiftMask, xK_q), spawn "mate-session-save --kill") ]

mateRun :: X ()
mateRun = withDisplay $ \dpy -> do
    rw <- asks theRoot
    mate_panel <- getAtom "_MATE_PANEL_ACTION"
    panel_run   <- getAtom "_MATE_PANEL_ACTION_RUN_DIALOG"

    io $ allocaXEvent $ \e -> do
        setEventType e clientMessage
        setClientMessageEvent e rw mate_panel 32 panel_run 0
        sendEvent dpy rw False structureNotifyMask e
        sync dpy False

main = do
    panel <- spawnPipe "/usr/bin/xmobar"
    xmonad $ mateConfig
                { modMask = mod1Mask
                 , borderWidth = 4
                 , focusedBorderColor = "#FF0000"
                } `additionalKeys`
         [  ((mod1Mask, xK_f), spawn "firefox")
           ,((mod1Mask, xK_p), spawn "dmenu_run")
           ,((mod1Mask, xK_c), spawn "google-chrome-stable")
	   ,((mod1Mask, xK_h), windows $ W.swapDown . W.focusUp)
           ,((mod1Mask, xK_z) kill)
         ] ++
          [((m .|. mod1Mask, k), windows $ f i) -- Replace 'mod1Mask' with your mod key of choice.
               | (i, k) <- zip myWorkspaces [xK_1 .. xK_9]
               , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]

myDoFullFloat :: ManageHook
myDoFullFloat = doF W.focusDown <+> doFullFloat
