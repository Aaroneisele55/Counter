import Toybox.Graphics;
import Toybox.WatchUi;
import Toybox.Lang;
import Toybox.Application;

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
        var height = dc.getHeight();
        var width = dc.getWidth();
        
        // Get counter values
        var c1Val = Application.Properties.getValue("c1");
        var c2Val = Application.Properties.getValue("c2");
        var total = (c1Val as Lang.Number) + (c2Val as Lang.Number);

        // Lift values and side hints by Venu3-equivalent 30px on all screens
        var valueShiftY = (height * (30.0 / 416.0)).toNumber();
        
        // Calculate fully relative positions for consistent layout across devices
        var c1Y = (height * 0.08).toNumber() - valueShiftY;
        var c2Y = (height * 0.34).toNumber() - valueShiftY;
        var totalY = (height * 0.60).toNumber() - valueShiftY;
        var hintY = (height * 0.8).toNumber();

        var line1Y = (height * 0.30).toNumber();
        var line2Y = (height * 0.56).toNumber();
        var line3Y = (height * 0.58).toNumber();

        var menuHintY = totalY + (height * 0.10).toNumber();
        var c1HintY = c1Y + (height * 0.2).toNumber();
        var c2HintY = c2Y + (height * 0.19).toNumber();
        var hintOffsetX = (width * 0.24).toNumber();
        
        var left = (width * 0.08).toNumber();
        var right = (width * 0.92).toNumber();
        var centerX = width / 2;
        
        // Clear background
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK);
        dc.clear();
        
        // Draw numbers (active counter in green, inactive in white)
        dc.setColor($.activeCounter == 1 ? Graphics.COLOR_GREEN : Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        dc.drawText(centerX, c1Y, Graphics.FONT_NUMBER_HOT, "" + c1Val, Graphics.TEXT_JUSTIFY_CENTER);
        dc.setColor($.activeCounter == 2 ? Graphics.COLOR_GREEN : Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        dc.drawText(centerX, c2Y, Graphics.FONT_NUMBER_HOT, "" + c2Val, Graphics.TEXT_JUSTIFY_CENTER);
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        dc.drawText(centerX, totalY, Graphics.FONT_NUMBER_HOT, "" + total, Graphics.TEXT_JUSTIFY_CENTER);
        
        // Draw hint label below total
        var promptText = WatchUi.loadResource(Rez.Strings.prompt) as String;
        dc.drawText(centerX, hintY, Graphics.FONT_XTINY, promptText, Graphics.TEXT_JUSTIFY_CENTER);
        dc.setColor(Graphics.COLOR_LT_GRAY, Graphics.COLOR_TRANSPARENT);
        var menuHintText = WatchUi.loadResource(Rez.Strings.menuHint) as String;
        dc.drawText(centerX + hintOffsetX, menuHintY, Graphics.FONT_XTINY, menuHintText, Graphics.TEXT_JUSTIFY_CENTER);
        var increaseHintText = WatchUi.loadResource(Rez.Strings.increaseHint) as String;
        dc.drawText(centerX + hintOffsetX, c1HintY, Graphics.FONT_XTINY, increaseHintText, Graphics.TEXT_JUSTIFY_CENTER);
        dc.drawText(centerX + hintOffsetX, c2HintY, Graphics.FONT_XTINY, increaseHintText, Graphics.TEXT_JUSTIFY_CENTER);
        var decreaseHintText = WatchUi.loadResource(Rez.Strings.decreaseHint) as String;
        dc.drawText(centerX - hintOffsetX, c1HintY, Graphics.FONT_XTINY, decreaseHintText, Graphics.TEXT_JUSTIFY_CENTER);
        dc.drawText(centerX - hintOffsetX, c2HintY, Graphics.FONT_XTINY, decreaseHintText, Graphics.TEXT_JUSTIFY_CENTER);




        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
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
