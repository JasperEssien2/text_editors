package com.example.text_editors

import android.os.Build
import android.os.Environment
import android.util.Log
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.io.File
import java.io.FileWriter

class MainActivity : FlutterActivity() {

    private val channelName = "com.example.text_editors/action"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            channelName
        ).setMethodCallHandler { call, result ->

            val args = call.arguments as Map<*, *>

            when (call.method) {
                "createFile" -> {
                    createTextFile(
                        args["fileName"] as String,
                        args["content"] as String,
                        result
                    )
                }
            }

        }
    }

    private fun createTextFile(fileName: String, content: String, callback: MethodChannel.Result) {

        try {
            val file = File(filesDir, "$fileName.txt")

            file.writeText(content)

            callback.success(true)
        } catch (e: java.lang.Exception) {

            callback.error("0", e.message, e.cause)
        }
    }

}
