import Toybox.Graphics;
import Toybox.WatchUi;
import Toybox.Lang;
import Toybox.Application;
import Toybox.System;

class CounterView extends WatchUi.View {

    function initialize() {
        View.initialize();
        // Initialize counters if not already set
        if (Application.Properties.getValue("c1") == null) {
            Application.Properties.setValue("c1", 0);
        }
        if (Application.Properties.getValue("c2") == null) {
            Application.Properties.setValue("c2", 0);
        }
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.MainLayout(dc));
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {
        System.println("DEBUG: onUpdate called");
        var height = dc.getHeight();
        var width = dc.getWidth();
        System.println("DEBUG: screen size = " + width + "x" + height);
        
        // Get counter values
        var c1Val = Application.Properties.getValue("c1");
        var c2Val = Application.Properties.getValue("c2");
        var total = (c1Val as Lang.Number) + (c2Val as Lang.Number);
        System.println("DEBUG: c1 = " + c1Val + ", c2 = " + c2Val + ", total = " + total);
        
        // Calculate adaptive positions - tighter spacing
        var yOffset = -40;
        var c1Y = (height * 0.03).toNumber() + yOffset;
        var c2Y = (height * 0.27).toNumber() + yOffset;
        var totalY = (height * 0.55).toNumber() + yOffset;
        var hintY = (height * 0.82).toNumber() + yOffset;
        
        var line1Y = (height * 0.32).toNumber() + yOffset;
        var line2Y = (height * 0.58).toNumber() + yOffset;
        var line3Y = (height * 0.60).toNumber() + yOffset;
        
        var left = (width * 0.08).toNumber();
        var right = (width * 0.92).toNumber();
        var centerX = width / 2;
        
        // Clear background
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK);
        dc.clear();
        
        // Draw numbers
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        dc.drawText(centerX, c1Y, Graphics.FONT_NUMBER_HOT, "" + c1Val, Graphics.TEXT_JUSTIFY_CENTER);
        dc.drawText(centerX, c2Y, Graphics.FONT_NUMBER_HOT, "" + c2Val, Graphics.TEXT_JUSTIFY_CENTER);
        dc.drawText(centerX, totalY, Graphics.FONT_NUMBER_HOT, "" + total, Graphics.TEXT_JUSTIFY_CENTER);
        
        // Draw hint label below total
        var promptText = WatchUi.loadResource(Rez.Strings.prompt) as String;
        dc.drawText(centerX, hintY, Graphics.FONT_XTINY, promptText, Graphics.TEXT_JUSTIFY_CENTER);
        
        // Draw separator lines
        dc.drawLine(left, line1Y, right, line1Y);
        dc.drawLine(left, line2Y, right, line2Y);
        dc.drawLine(left, line3Y, right, line3Y);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {
    }

}
