package com.madlonkay.flutter_charset_detector

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.StandardMethodCodec
import org.mozilla.universalchardet.UniversalDetector
import java.nio.ByteBuffer
import java.nio.charset.Charset
import java.nio.charset.IllegalCharsetNameException
import java.nio.charset.UnsupportedCharsetException
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.MainScope
import kotlinx.coroutines.launch

/** FlutterCharsetDetectorPlugin */
class FlutterCharsetDetectorPlugin : FlutterPlugin, MethodCallHandler, CoroutineScope by MainScope() {
    private lateinit var channel: MethodChannel

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        val taskQueue = flutterPluginBinding.binaryMessenger.makeBackgroundTaskQueue()
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "flutter_charset_detector", StandardMethodCodec.INSTANCE, taskQueue)
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        val mainThreadResult = object : Result {
            override fun error(errorCode: String, errorMessage: String?, errorDetails: Any?) {
                launch(Dispatchers.Main) { result.error(errorCode, errorMessage, errorDetails) }
            }
            override fun success(resultArg: Any?) {
                launch(Dispatchers.Main) { result.success(resultArg) }
            }
            override fun notImplemented() {
                launch(Dispatchers.Main) { result.notImplemented() }
            }
        }
        launch(Dispatchers.Default) {
            when (call.method) {
                "autoDecode" -> handleAutoDecode(call, mainThreadResult)
                "detect" -> handleDetect(call, mainThreadResult)
                else -> mainThreadResult.notImplemented()
            }
        }
    }

    private fun handleAutoDecode(call: MethodCall, result: Result) {
        val data = call.argument<ByteArray>("data")
        if (data == null) {
            result.error("MissingArg", "Required argument missing", "${call.method} requires 'data'")
            return
        }
        val charsetName = data.inputStream().use(UniversalDetector::detectCharset)
        if (charsetName == null) {
            result.error("DetectionFailed", "The charset could not be detected", null)
            return
        }
        val charset: Charset = try {
            Charset.forName(charsetName)
        } catch (e: Exception) {
            when (e) {
                is IllegalCharsetNameException,
                is UnsupportedCharsetException -> {
                    result.error("UnsupportedCharset", "The detected charset $charsetName is not supported.", null)
                    return
                }
                else -> throw e
            }
        }
        val string = charset.decode(ByteBuffer.wrap(data)).toString()
        result.success(
            mapOf(
                "charset" to charsetName,
                "string" to string
            )
        )
    }

    private fun handleDetect(call: MethodCall, result: Result) {
        val data = call.argument<ByteArray>("data")
        if (data == null) {
            result.error("MissingArg", "Required argument missing", "${call.method} requires 'data'")
            return
        }
        val charsetName = data.inputStream().use(UniversalDetector::detectCharset)
        if (charsetName == null) {
            result.error("DetectionFailed", "The charset could not be detected", null)
            return
        }
        result.success(charsetName)
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }
}
