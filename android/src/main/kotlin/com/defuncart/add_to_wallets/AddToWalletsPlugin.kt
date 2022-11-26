package com.defuncart.add_to_wallets

import androidx.annotation.NonNull

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import android.util.Log
import com.google.android.gms.pay.Pay
import com.google.android.gms.pay.PayApiAvailabilityStatus
import com.google.android.gms.pay.PayClient

/** AddToWalletsPlugin */
class AddToWalletsPlugin: FlutterPlugin, MethodCallHandler, ActivityAware {
  private lateinit var channel : MethodChannel
  private lateinit var activity: FlutterActivity
  private lateinit var walletClient: PayClient

  private val addToGoogleWalletRequestCode = 1000

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "add_to_wallets")
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    if (call.method == "addToGoogleWallet") {
      val pass = call.argument<String>("pass")
      savePass(pass!!)
      result.success(true)
    } else {
      result.notImplemented()
    }
  }

  private fun savePass(@NonNull pass: String) {
     walletClient.savePasses(pass, activity, addToGoogleWalletRequestCode)
  }

  // private fun fetchCanUseGoogleWalletApi() {
  //   walletClient
  //           .getPayApiAvailabilityStatus(PayClient.RequestType.SAVE_PASSES)
  //           .addOnSuccessListener { status ->
  //               if (status == PayApiAvailabilityStatus.AVAILABLE)
  //                   layout.passContainer.visibility = View.VISIBLE
  //           }
  //           .addOnFailureListener {
  //               // Hide the button and optionally show an error message
  //           }
  //   }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  override fun onDetachedFromActivity() {}

  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {}

  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    activity = binding.activity as FlutterActivity
    walletClient = Pay.getClient(activity)
  }

  override fun onDetachedFromActivityForConfigChanges() {}
}
