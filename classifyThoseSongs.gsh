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


/**
 * Reads the root directory contents and processes its files
 *
 * @param directoryList the list of directories where the user can move the songs
 */
void classifyDirectory(directoryList) {

    new File('.').eachFile { file ->

        if (file.name.endsWith('.mp3')) {

            println "++ Now playing => ${file.name}"
            processSong(file, directoryList)

        } else {

            println "-- ${file.name} is not a MP3 file"

        }

    }

}


/**
 * Shows the directory list in the screen
 *
 * @param directoryList the directory list
 */
void printDirectoryList(directoryList) {

    println ">> Great! where you want to move this song?"
    directoryList.eachWithIndex { dirName, i ->
        println "    [${i}] ${dirName}"
    }

}


/**
 * Shows the directory list and classifies a MP3 file
 *
 * @param song the MP3 song to classify
 * @param directoryList the list of directories where the user can move the songs
 */
void classifySong(song, directoryList) {

    Integer choice = -1

    while(choice == -1) {

        printDirectoryList(directoryList)

        try {

            choice = System.console().readLine('> Choose wisely: ').toInteger()

            if (choice in [0..directoryList.size()]) {

                moveSong(song, directoryList[choice])

            } else {

                println "-- Invalid choice"

            }

        } catch (Exception e) {

            println "-- Please, choose one of the following directories using its number"

        }

    }

}

}


/**
 * Plays and classifies a MP3 file
 *
 * @param song the song
 * @param directoryList the list of directories where the user can move the songs
 * @return void
 */
void processSong(song, directoryList) {

    new Player(song.newInputStream()).play()

    classifySong(song, directoryList)

}


// Main code
println ">> Checking arguments"
if (args.size() >= 2) {

    println ">> Checking directory status"
    if (checkDirectories(args)) {

        println ">> Don't stop the music!!"
        classifyDirectory(args)

    }

} else {

    println "-- USAGE: groovyplay DIRECTORIO1 DIRECTORIO2 [DIRECTORIO3] ..."

}
