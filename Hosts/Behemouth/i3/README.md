# Running i3WM with XFCE4

## Installation

Install i3 and the official Qubes-specific i3 settings in dom0 from the official Qubes repositories:

`$ sudo qubes-dom0-update i3 i3-settings-qubes`

Next, we modify Xfce4 settings to replace xfwm with i3wm. 

Under Qubes Menu > Gear > System Settings > Session & Startup:

* Go to the Application Autostart tab and add an entry for i3:
  * Name: `i3wm`
  * Description: `i3 Window Manager`
  * Command: `i3`
  * Trigger: `on login`
  * [OK]
* On the Current Session tab:
  * Change the `Restart Style` column for `xfwm4` to `Never`
  * Change the `Restart Style` column for `xfdesktop` to `Never`

Click "Save Session" before closing the dialog. 

In Qubes Menu > Gear > System Settings > Keyboard:

* Go to the Application Shortcuts tab, highlight all shortcuts and click Remove. Just use i3's config file to manage your keyboard shortcuts from now on, to avoid the risk of a conflict.

Now you should be able to log out and log back in, and XFWM should have been replaced by i3wm, with the rest of XFCE4 still in place.

When you log in for the first time, you'll notice that the auto-generated i3 config will be set to load the i3-bar loading at the bottom of the screen in addition to the Xfce menu at the top. From dom0, you can optionally edit the config file to remove the i3-bar:

Use $mod+Return to open a terminal in dom0

Use your favorite editor to edit the i3 config file (if you don't know what vim is, substitute "nano" for "vim"):

`sudo vim ~/.config/i3.config`

Comment out (add `#` to the beginning of each line) the section at the bottom that starts with `bar {` until the matching closing bracket `}`:

```
#bar {
#    position top
#
#    < etcetera... >
#
#}
```

Save and exit, then the next time you log out/back in the i3-bar should be gone. 

## ToDos:

[ ] Document the best way (Qubes/dom0-safe) to change the background image. *Note that initial investigation suggests that it should be pretty trivially easy to change each workspace to a different image. 

## Issues

* The workspaces are a little wonky the way that they work, but I've grown to love them as is. The only piece missing in this configuration is potentially visually numbering/labeling the workspaces, but I haven't found this to be an issue for me, because in my workflow, I always know where everything is. There is a package i3-workspaces that is designed to fix this issue, but I don't believe it's available for dom0 update in Qubes, which means that it should be considered insecure by default. You can optionally leave in the i3-bar if you wish, but that's up to you. 
* There may be a way to properly set up a background image changer/separate compositor in Qubes under this configuration, but I haven't had a need. Someone asked on the forum, so I put it in ToDos.

References:
* https://wwwtest.qubes-os.org/fr/doc/i3/
* https://www.youtube.com/watch?v=nZTBxJ_gr8w
