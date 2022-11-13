package com.example.text_editors

import FileApi
import FileData
import Response
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.io.File

class MainActivity : FlutterActivity() {

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

        val fileApi = FileApiImpl(filesDir)

        FileApi.setUp(
            binaryMessenger = flutterEngine.dartExecutor.binaryMessenger,
            api = fileApi
        )
    }
}
