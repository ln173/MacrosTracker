using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.System;
using Toybox.Lang;

class CaloriesProteinTrackerApp extends Ui.WatchUi {
    var calories = 0;
    var calorieGoal = 2000;
    var protein = 0;
    var proteinGoal = 100;

    function initialize() {
        // Load settings if any exist
        calories = System.getProperty("calories", 0);
        calorieGoal = System.getProperty("calorieGoal", 2000);
        protein = System.getProperty("protein", 0);
        proteinGoal = System.getProperty("proteinGoal", 100);
    }

    function onSettingsChanged() {
        // Update goals based on settings input
        calorieGoal = (System.getProperty("calorieGoal") ? System.getProperty("calorieGoal") : 2000).toNumber();
        proteinGoal = (System.getProperty("proteinGoal") ? System.getProperty("proteinGoal") : 100).toNumber();
    }

    function onUpdate(dc as Gfx.DrawContext) {
        dc.clear();
        
        // Display Calorie Count and Goal
        var calorieText = "Calories: " + calories + "/" + calorieGoal;
        dc.drawText(calorieText, Gfx.FONT_LARGE, 10, 30, Gfx.TEXT_JUSTIFY_LEFT);
        
        // Display Protein Count and Goal
        var proteinText = "Protein: " + protein + "g/" + proteinGoal + "g";
        dc.drawText(proteinText, Gfx.FONT_LARGE, 10, 80, Gfx.TEXT_JUSTIFY_LEFT);
    }
    
    function onEnter() {
        // Update displayed values when the widget is opened
        calories = System.getProperty("calories", 0);
        protein = System.getProperty("protein", 0);
    }
    
    function onExit() {
        // Save the current values when the widget closes
        System.setProperty("calories", calories);
        System.setProperty("protein", protein);
    }

    function addCalories(amount as Number) {
        calories += amount;
        calories = (calories > calorieGoal) ? calorieGoal : calories;  // Cap at calorieGoal
        Ui.requestUpdate();
    }

    function addProtein(amount as Number) {
        protein += amount;
        protein = (protein > proteinGoal) ? proteinGoal : protein;  // Cap at proteinGoal
        Ui.requestUpdate();
    }
}
