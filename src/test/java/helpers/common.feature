Feature: Common useful functions

  Scenario: Common functions

    * def writeToFileWithName =
    """
    function(input,filename){
    var writeToFile = Java.type('helpers.commonUtils');
    var write = new writeToFile();
    return write.writeToFile(input,filename);
    }
    """