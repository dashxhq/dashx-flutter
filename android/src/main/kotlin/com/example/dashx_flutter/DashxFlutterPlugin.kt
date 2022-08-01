package com.example.dashx_flutter

import android.content.Context
import androidx.annotation.NonNull
import android.util.Log

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import com.dashx.sdk.DashXClient

/** DashxFlutterPlugin */
class DashxFlutterPlugin : FlutterPlugin, MethodCallHandler {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel
    private var applicationContext: Context? = null
    var dashXClient: DashXClient? = null
    var dxConfig: HashMap<String, String?>? = null
    var baseUri: String? = null
    var publicKey: String? = null
    var targetEnvironment: String? = null
    var uid: String? = null
    var targetInstallation: String? = null

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "dashx_flutter")
        applicationContext = flutterPluginBinding.applicationContext
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        if (call.method == "setConfig") {
            dxConfig = call.arguments as HashMap<String, String?>
// set configuration related values
            publicKey = dxConfig!!["publicKey"] as String?
            baseUri = dxConfig!!["baseUrl"] as String?
            targetEnvironment = dxConfig!!["targetEnviroment"] as String?
            uid = dxConfig!!["uid"] as String?
            targetInstallation = dxConfig!!["targetInstallation"] as String?
// passing it to client
            dashXClient = DashXClient(applicationContext!!,
                publicKey!!,
                baseUri,
                targetEnvironment,
                targetInstallation)


try{

     dashXClient!!.track("button click", hashMapOf("Clicked Button" to "gameName"))
} catch(e : Exception){
    print(e.stackTrace)
}
             result.success("track sent")
        } else {
            result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }
}
