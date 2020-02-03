//open("H:/docs/Misc/test images/pizza plaques.tif");

#@ File (label = "Input file", style = "file") input
open(input);
start = lastIndexOf(input, "\\");
end = lastIndexOf(input, "f");
title = substring(input, start+1, end+1);
run("Split Channels");
selectWindow(title + " (blue)");
close();
setAutoThreshold("Default dark");
setOption("BlackBackground", true);
run("Convert to Mask");
selectWindow(title + " (red)");
run("Convert to Mask");
imageCalculator("Multiply create", title + " (red)", title + " (green)");
selectWindow("Result of " + title + " (red)");
open(input);
selectWindow(title + " (red)");
selectWindow("Result of " + title + " (red)");
imageCalculator("Add create", title, "Result of " + title + " (red)");