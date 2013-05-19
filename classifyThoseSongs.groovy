#!/usr/bin/env groovy
@Grab('javazoom:jlayer:1.0.1')
import javazoom.jl.player.Player

if (args) {

    def song = new File('08 - Get lucky.mp3')
    new Player(song.newInputStream()).play()

} else {

    println "groovyplay DIRECTORIO1 DIRECTORIO2 [DIRECTORIO3] ..."

}
