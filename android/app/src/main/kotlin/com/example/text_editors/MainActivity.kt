package com.example.text_editors

import FileApi
import FileData
import Response
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.io.File

class MainActivity : FlutterActivity() {

    //TODO 1: Implement [FileApi] interface
    class FileApiImpl(private val filesDir: File) : FileApi {

        override fun saveTextFile(data: FileData): Response {
            return try {
                val file = File(filesDir, "${data.fileName}.txt")

                file.writeText(data.content!!)

                Response(successful = true)
            } catch (e: java.lang.Exception) {
                Response(successful = false, error = e.message)
            }
        }
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        //TODO 2: Delete method channel implementation between TODO 2 and TODO 3
        val channelName = "com.example.text_editors/action"
        val methodChannel = MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            channelName
        )

        methodChannel.setMethodCallHandler { call, result ->
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
        //TODO 3

        //TODO 4: Initialize FileApiImpl
        val fileApi = FileApiImpl(filesDir)

        //TODO 5: Setup FileApi communication
        FileApi.setUp(
            binaryMessenger = flutterEngine.dartExecutor.binaryMessenger,
            api = fileApi
        )
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
