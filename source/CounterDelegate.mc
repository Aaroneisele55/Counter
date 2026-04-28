import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.Application;
import Toybox.System;
import Toybox.Graphics;
import Toybox.Attention;

class CounterDelegate extends WatchUi.BehaviorDelegate {
    // Tap zone boundaries (set during first touch, proportional to screen)
    private var c1TapYMin = 0;
    private var c1TapYMax = 0;
    private var c2TapYMin = 0;
    private var c2TapYMax = 0;
    private var totalTapYMin = 0;
    private var totalTapYMax = 0;
    private var screenHeight = 0;


    private function initializeTapZones() as Void {
        // Get real display dimensions from system
        var deviceSettings = System.getDeviceSettings();
        var displayHeight = deviceSettings.screenHeight;
        screenHeight = displayHeight;

        c1TapYMin = 0;
        c1TapYMax = (screenHeight * 0.2).toNumber();

        c2TapYMin = (screenHeight * 0.25).toNumber();
        c2TapYMax = (screenHeight * 0.55).toNumber();

        // Total zone: bottom area
        totalTapYMin = (screenHeight * 0.6).toNumber();
        totalTapYMax = screenHeight;
    }
    function initialize() {
        BehaviorDelegate.initialize();
    }

    function onMenu() as Boolean {
        // Switch which counter is active (highlighted in green)
        if ($.activeCounter == 1) {
            $.activeCounter = 2;
        } else {
            $.activeCounter = 1;
        }
        WatchUi.requestUpdate();
        return true;
    }

    function onKey(keyEvent) as Boolean {
        var key = keyEvent.getKey();

        if (key == WatchUi.KEY_ENTER) {
            var propKey = ($.activeCounter == 1) ? "c1" : "c2";
            var val = Application.Properties.getValue(propKey) as Number;
            val = val + 1;
            Application.Properties.setValue(propKey, val);
            vibrateShort();
            WatchUi.requestUpdate();
            return true;
        }

        return false;
    }
    function vibrateShort() {
        if (Attention has :vibrate and Application.Properties.getValue("vibrateEnabled") == true) {
            var vibeData = [
                new Attention.VibeProfile(100, 150), 
            ];
            Attention.vibrate(vibeData);
        }
    }
    function vibrateLong() {
        if (Attention has :vibrate and Application.Properties.getValue("vibrateEnabled") == true) {
            var vibeData = [
                new Attention.VibeProfile(100, 150), 
                new Attention.VibeProfile(0, 150), 
                new Attention.VibeProfile(100, 150), 
            ];
            Attention.vibrate(vibeData);
        }
    }
    function playTone (sound as Attention.Tone){
        if (Application.Properties.getValue("soundEnabled") == true) {
            Attention.playTone(sound);
        }

    }

    function onTap(clickEvent) as Boolean {
        var coords = clickEvent.getCoordinates() as Array;
        var y = coords[1] as Number;

        // Initialize tap zones on first touch if not set
        if (screenHeight == 0) {
            initializeTapZones();
        }

        // Check if tap is in C1 area
        if (y >= c1TapYMin && y <= c1TapYMax) {
            var c1 = Application.Properties.getValue("c1") as Number;
            c1 = c1 + 1;
            Application.Properties.setValue("c1", c1);
            WatchUi.requestUpdate();
            vibrateShort();
            playTone(Attention.TONE_LAP);
            return true;
        }

        // Check if tap is in C2 area
        if (y >= c2TapYMin && y <= c2TapYMax) {
            var c2 = Application.Properties.getValue("c2") as Number;
            c2 = c2 + 1;
            Application.Properties.setValue("c2", c2);
            WatchUi.requestUpdate();
            vibrateShort();
            playTone(Attention.TONE_LAP);
            return true;
        }

        // Check if tap is in Total area - open menu
        if (y >= totalTapYMin && y <= totalTapYMax) {
            WatchUi.pushView(
                new CounterSettingsMenu(),
                new CounterMenuDelegate(),
                WatchUi.SLIDE_UP
            );
            return true;
        }

        return false;
    }

    function onHold(clickEvent) as Boolean {
        var coords = clickEvent.getCoordinates() as Array;
        var y = coords[1] as Number;

        // Initialize tap zones on first touch if not set
        if (screenHeight == 0) {
            initializeTapZones();
        }

        // Check if long click is in C1 area
        if (y >= c1TapYMin && y <= c1TapYMax) {
            var c1 = Application.Properties.getValue("c1") as Number;
            c1 = c1 > 0 ? c1 - 1 : 0;
            Application.Properties.setValue("c1", c1);
            WatchUi.requestUpdate();
            vibrateLong();
            playTone(Attention.TONE_STOP);
            return true;
        }

        // Check if long click is in C2 area
        if (y >= c2TapYMin && y <= c2TapYMax) {
            var c2 = Application.Properties.getValue("c2") as Number;
            c2 = c2 > 0 ? c2 - 1 : 0;
            Application.Properties.setValue("c2", c2);
            WatchUi.requestUpdate();
            vibrateLong();
            playTone(Attention.TONE_STOP);
            return true;
        }

        return false;
    }

    
}
