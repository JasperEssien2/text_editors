package com.example.text_editors

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.io.File

class MainActivity : FlutterActivity() {

    private val channelName = "com.example.text_editors/action"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        //TODO 1: Set a corresponding method channel

        //TODO 2: Set up method channel call handler
        }
    }

    private fun createTextFile(fileName: String, content: String, result: MethodChannel.Result) {

        try {
            val file = File(filesDir, "$fileName.txt")

            file.writeText(content)

            //TODO 3: Send back a success result
        } catch (e: java.lang.Exception) {

            //TODO 3: Send back an error result if creating file failed
        }
    }
}
