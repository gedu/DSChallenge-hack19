package com.hack19.dschallenge;

import android.content.Intent;
import android.os.Bundle;
import android.util.Log;

import com.pinterest.android.pdk.PDKCallback;
import com.pinterest.android.pdk.PDKClient;
import com.pinterest.android.pdk.PDKException;
import com.pinterest.android.pdk.PDKResponse;

import org.json.JSONObject;

import java.util.ArrayList;
import java.util.List;

import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {

  private static final String PINTEREST_CHANNEL = "pinterest.pdf/auth";

  private PDKClient pdkClient;
  private MethodChannel.Result pinterestResult;

  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);

    pdkClient = PDKClient.configureInstance(this, "5036150980299769550");
    pdkClient.onConnect(this);
    PDKClient.setDebugMode(true);

    setPdfMethodChannel();
  }

  @Override
  protected void onActivityResult(int requestCode, int resultCode, Intent data) {
    super.onActivityResult(requestCode, resultCode, data);
    Log.d(getClass().getName(), "On activity result");
    pdkClient.onOauthResponse(requestCode, resultCode, data);
  }

  @Override
  protected void onNewIntent(Intent intent) {
    super.onNewIntent(intent);
    String pinterestAK = intent.getData().getQueryParameter("access_token");
    if (pinterestAK != null) {
      pinterestResult.success(pinterestAK);
    }
  }

  private void setPdfMethodChannel() {
    new MethodChannel(getFlutterView(), PINTEREST_CHANNEL).setMethodCallHandler((methodCall, result) -> {
      Log.d(getClass().getName(), "Method called with "+methodCall.method);
      if (methodCall.method.equals("startAuth")) {
        pinterestResult = result;
        pdkLogin(result);
      } else {
        result.notImplemented();
      }
    });
  }

  private void pdkLogin(MethodChannel.Result result) {
    List<String> scopes = new ArrayList<>();
    scopes.add(PDKClient.PDKCLIENT_PERMISSION_READ_PUBLIC);

    Log.d(getClass().getName(), "Login");
    pdkClient.login(this, scopes, new PDKCallback() {
      @Override
      public void onSuccess(PDKResponse response) {
        Log.d(getClass().getName(), response.getData().toString());
        result.success("Hello PDK");
      }

      @Override
      public void onFailure(PDKException exception) {
        Log.e(getClass().getName(), exception.toString());
      }
    });
  }
}
