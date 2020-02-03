/*
 * Macro template to process multiple images in a folder
 */

#@ File (label = "Input directory", style = "directory") input
#@ String (label = "File suffix", value = ".tif") suffix

// See also Process_Folder.py for a version of this code
// in the Python scripting language.
run("Set Measurements...", "area_fraction display redirect=None decimal=9");
processFolder(input);

// function to scan folders/subfolders/files to find files with correct suffix
function processFolder(input) {
	print(input);
	list = getFileList(input);
	list = Array.sort(list);
	for (i = 0; i < list.length; i++) {
		if(File.isDirectory(input + File.separator + list[i]))
			processFolder(input + File.separator + list[i]);
		if(endsWith(list[i], suffix))
			processFile(input, list[i]);
	}
}

function processFile(input, file) {
	// Do the processing here by adding your own code.
	// Leave the print statements until things work, then remove them.
	print("Processing: " + input + File.separator + file);
	print(file);
	open(file);
	last = lastIndexOf(file, ".");
	print(last);
	title = substring(file, 0, last) + ".tif";
	//title = substring(input, start+1, end+1);
	run("Split Channels");
	selectWindow(title + " (blue)");
	close();
	setAutoThreshold("Default dark");
	setOption("BlackBackground", true);
	run("Convert to Mask");
	run("Measure");
	selectWindow(title + " (red)");
	run("Convert to Mask");
	run("Measure");
	imageCalculator("Multiply create", title + " (red)", title + " (green)");
	selectWindow("Result of " + title + " (red)");
	run("Measure");
	run("Close All");
}
