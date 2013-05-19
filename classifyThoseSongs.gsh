#!/usr/bin/env groovy
@Grab('javazoom:jlayer:1.0.1')
import javazoom.jl.player.Player

println '''
         .                          ,__           _______ _                             _____                            
   ___   |     ___    ____   ____ ` /  ` ,    .  '   /    /        __.    ____   ___   (        __.  , __     ___.   ____
 .'   `  |    /   `  (      (     | |__  |    `      |    |,---. .'   \\  (     .'   `   `--.  .'   \\ |'  `. .'   `  (    
 |       |   |    |  `--.   `--.  | |    |    |      |    |'   ` |    |  `--.  |----'      |  |    | |    | |    |  `--. 
  `._.' /\\__ `.__/| \\___.' \\___.' / |     `---|.     /    /    |  `._.' \\___.' `.___, \\___.'   `._.' /    |  `---| \\___.'
                                    /     \\___/                                                              \\___/       
'''


/**
 * Checks that the directories exists
 *
 * @param directoryList a list of directory names
 * @result true if everything is ok, false if it isn't
 */
Boolean checkDirectories(directoryList) {

    Boolean directoriesOkFlag = true

    directoryList.each { dirName ->

        try {
            File dir = new File(dirName)
            if (!dir.exists()) {
                println "-- The directory \"${dirName}\" doesn't exist"
                directoriesOkFlag = false
            }
        } catch (Exception e) {
            println "-- There has been an error trying to check the directory \"${dirName}\""
            directoriesOkFlag = false
        }

    }

    return directoriesOkFlag

}


// Main code
println ">> Checking arguments"
if (args.size() >= 2) {

    println ">> Checking directory status"
    if (checkDirectories(args)) {

        println ">> Don't stop the music!!"
        new File('.').eachFile { file ->

            if (file.name.endsWith('.mp3')) {

                println "++ Now playing => ${file.name}"
                def song = new File(file.name)
                new Player(song.newInputStream()).play()

            } else {

                println "-- ${file.name} is not a MP3 file"

            }

        }

    }

} else {

    println "-- USAGE: groovyplay DIRECTORIO1 DIRECTORIO2 [DIRECTORIO3] ..."

}
