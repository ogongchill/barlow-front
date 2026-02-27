package com.barlow.front

import io.flutter.embedding.android.FlutterActivity
import android.webkit.CookieManager
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val CHANNEL = "barlow.front/cookie"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
            .setMethodCallHandler { call, result ->
                if (call.method == "clearCookies") {
                    val cookieManager = CookieManager.getInstance()
                    cookieManager.removeAllCookies { success ->
                        cookieManager.flush()
                        // 콜백 안에서 result.success 호출해야 Flutter await가 완료 인식
                        result.success(success)
                    }
                }
            }
    }
}
