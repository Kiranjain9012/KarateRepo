package helpers;

import java.io.File;
import java.io.FileOutputStream;

public class commonUtils {

    public void writeToFile(Object input, String filename) throws Exception{

        String filepath = "target/surefire-reports/"+ filename +".txt";
        byte[] bytes = input.toString().getBytes();
        File file = new File(filepath);

        if(file.exists()) file.delete();
        boolean b = file.createNewFile();
        if(b) System.out.println("File created: "+ filepath);

        //Wrtie to File
        FileOutputStream out = new FileOutputStream(file);
        out.write(bytes);
        out.close();
    }
}
