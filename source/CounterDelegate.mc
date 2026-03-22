import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.Application;
import Toybox.System;
import Toybox.Graphics;

class CounterDelegate extends WatchUi.BehaviorDelegate {
    // Tap zone boundaries (set during first touch, proportional to screen)
    private var c1TapYMin = 0;
    private var c1TapYMax = 0;
    private var c2TapYMin = 0;
    private var c2TapYMax = 0;
    private var totalTapYMin = 0;
    private var totalTapYMax = 0;
    private var screenHeight = 0;

    function initialize() {
        BehaviorDelegate.initialize();
    }

    function onMenu() as Boolean {
        WatchUi.pushView(
            new Rez.Menus.MainMenu(),
            new CounterMenuDelegate(),
            WatchUi.SLIDE_UP
        );
        return true;
    }

    function onKey(keyEvent) as Boolean {
        var key = keyEvent.getKey();
        System.println("DEBUG: onKey pressed - key=" + key);

        if (key == WatchUi.KEY_ENTER) {
            System.println("DEBUG: ENTER key pressed");
            var c1 = Application.Properties.getValue("c1") as Number;
            c1 = c1 + 1;
            Application.Properties.setValue("c1", c1);
            WatchUi.requestUpdate();
            return true;
        }

        if (key == WatchUi.KEY_ESC) {
            System.println("DEBUG: ESC key pressed");
            var c2 = Application.Properties.getValue("c2") as Number;
            c2 = c2 + 1;
            Application.Properties.setValue("c2", c2);
            WatchUi.requestUpdate();
            return true;
        }

        return false;
    }
    function vibrateShort() {
        if (Attention has :vibrate) {
            var vibeData = [
                new Attention.VibeProfile(50, 150), 
            ];
            Attention.vibrate(vibeData);
        }
    }
    function vibrateLong() {
        if (Attention has :vibrate) {
            var vibeData = [
                new Attention.VibeProfile(50, 150), 
                new Attention.VibeProfile(0, 500), 
                new Attention.VibeProfile(50, 150), 
            ];
            Attention.vibrate(vibeData);
        }
    }

    function onTap(clickEvent) as Boolean {
        System.println("DEBUG: onTap detected");
        var coords = clickEvent.getCoordinates() as Array;
        var y = coords[1] as Number;
        System.println("DEBUG: tap at y=" + y);

        // Initialize tap zones on first touch if not set
        if (screenHeight == 0) {
            initializeTapZones();
        }

        // Check if tap is in C1 area
        if (y >= c1TapYMin && y <= c1TapYMax) {
            System.println("DEBUG: tap in C1 zone");
            var c1 = Application.Properties.getValue("c1") as Number;
            c1 = c1 + 1;
            Application.Properties.setValue("c1", c1);
            WatchUi.requestUpdate();
            vibrateShort();
            return true;
        }

        // Check if tap is in C2 area
        if (y >= c2TapYMin && y <= c2TapYMax) {
            System.println("DEBUG: tap in C2 zone");
            var c2 = Application.Properties.getValue("c2") as Number;
            c2 = c2 + 1;
            Application.Properties.setValue("c2", c2);
            WatchUi.requestUpdate();
            vibrateShort();
            return true;
        }

        // Check if tap is in Total area - open menu
        if (y >= totalTapYMin && y <= totalTapYMax) {
            System.println("DEBUG: tap in Total zone - opening menu");
            WatchUi.pushView(
                new Rez.Menus.MainMenu(),
                new CounterMenuDelegate(),
                WatchUi.SLIDE_UP
            );
            return true;
        }

        return false;
    }

    function onHold(clickEvent) as Boolean {
        System.println("DEBUG: onLongClick detected");
        var coords = clickEvent.getCoordinates() as Array;
        var y = coords[1] as Number;
        System.println("DEBUG: long click at y=" + y);

        // Initialize tap zones on first touch if not set
        if (screenHeight == 0) {
            initializeTapZones();
        }

        // Check if long click is in C1 area
        if (y >= c1TapYMin && y <= c1TapYMax) {
            System.println("DEBUG: long click in C1 zone - decreasing");
            var c1 = Application.Properties.getValue("c1") as Number;
            c1 = c1 > 0 ? c1 - 1 : 0;
            Application.Properties.setValue("c1", c1);
            WatchUi.requestUpdate();
            vibrateLong();
            return true;
        }

        // Check if long click is in C2 area
        if (y >= c2TapYMin && y <= c2TapYMax) {
            System.println("DEBUG: long click in C2 zone - decreasing");
            var c2 = Application.Properties.getValue("c2") as Number;
            c2 = c2 > 0 ? c2 - 1 : 0;
            Application.Properties.setValue("c2", c2);
            WatchUi.requestUpdate();
            vibrateLong();
            return true;
        }

        return false;
    }

    private function initializeTapZones() as Void {
        // Get real display dimensions from system
        var deviceSettings = System.getDeviceSettings();
        var displayWidth = deviceSettings.screenWidth;
        var displayHeight = deviceSettings.screenHeight;
        screenHeight = displayHeight;

        System.println(
            "DEBUG: Display dimensions = " + displayWidth + "x" + displayHeight
        );

        c1TapYMin = 0;
        c1TapYMax = (screenHeight * 0.3).toNumber();

        c2TapYMin = (screenHeight * 0.35).toNumber();
        c2TapYMax = (screenHeight * 0.55).toNumber();

        // Total zone: bottom area
        totalTapYMin = (screenHeight * 0.6).toNumber();
        totalTapYMax = screenHeight;

        System.println(
            "DEBUG: Tap zones initialized - C1: " +
                c1TapYMin +
                "-" +
                c1TapYMax +
                ", C2: " +
                c2TapYMin +
                "-" +
                c2TapYMax +
                ", Total: " +
                totalTapYMin +
                "-" +
                totalTapYMax
        );
    }
}
