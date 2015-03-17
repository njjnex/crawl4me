package by.njjnex.logic;

import java.io.File;

public class FileUtils {

	public static void deleteDir(String path) {
		File dir = new File(path);
		File[] filelist = dir.listFiles();
		if (filelist != null) {
			for (File file : filelist) {
				if (file.isFile()) {
					file.delete();
				} else {
					deleteDir(file.toString());
				}
			}
		}
		dir.delete();
	}

}