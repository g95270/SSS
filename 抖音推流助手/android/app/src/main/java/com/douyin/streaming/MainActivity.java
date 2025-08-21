package com.douyin.streaming;

import android.Manifest;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.os.Bundle;
import android.os.Handler;
import android.os.Looper;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;
import android.widget.Toast;

import androidx.appcompat.app.AppCompatActivity;
import androidx.core.app.ActivityCompat;
import androidx.core.content.ContextCompat;

public class MainActivity extends AppCompatActivity {
    
    private static final int PERMISSION_REQUEST_CODE = 100;
    private static final String[] REQUIRED_PERMISSIONS = {
        Manifest.permission.CAMERA,
        Manifest.permission.RECORD_AUDIO,
        Manifest.permission.WRITE_EXTERNAL_STORAGE
    };
    
    private Button btnLogin;
    private Button btnGetStreamKey;
    private Button btnStartStream;
    private Button btnStopStream;
    private TextView tvStatus;
    private TextView tvStreamInfo;
    
    private boolean isLoggedIn = false;
    private boolean isStreaming = false;
    private String streamKey = "";
    private Handler handler = new Handler(Looper.getMainLooper());

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        
        initViews();
        checkPermissions();
        setupClickListeners();
    }
    
    private void initViews() {
        btnLogin = findViewById(R.id.btn_login);
        btnGetStreamKey = findViewById(R.id.btn_get_stream_key);
        btnStartStream = findViewById(R.id.btn_start_stream);
        btnStopStream = findViewById(R.id.btn_stop_stream);
        tvStatus = findViewById(R.id.tv_status);
        tvStreamInfo = findViewById(R.id.tv_stream_info);
        
        // 初始状态
        btnGetStreamKey.setEnabled(false);
        btnStartStream.setEnabled(false);
        btnStopStream.setEnabled(false);
        tvStatus.setText("请先登录抖音账号");
    }
    
    private void setupClickListeners() {
        btnLogin.setOnClickListener(v -> performLogin());
        btnGetStreamKey.setOnClickListener(v -> getStreamKey());
        btnStartStream.setOnClickListener(v -> startStreaming());
        btnStopStream.setOnClickListener(v -> stopStreaming());
    }
    
    private void performLogin() {
        tvStatus.setText("正在登录抖音账号...");
        btnLogin.setEnabled(false);
        
        // 模拟登录过程
        handler.postDelayed(() -> {
            isLoggedIn = true;
            tvStatus.setText("✅ 登录成功！欢迎使用抖音推流助手");
            btnLogin.setText("已登录");
            btnGetStreamKey.setEnabled(true);
            Toast.makeText(MainActivity.this, "登录成功！", Toast.LENGTH_SHORT).show();
        }, 2000);
    }
    
    private void getStreamKey() {
        tvStatus.setText("正在获取推流码...");
        btnGetStreamKey.setEnabled(false);
        
        // 模拟获取推流码
        handler.postDelayed(() -> {
            streamKey = "rtmp://live-push.douyin.com/live/stream_" + System.currentTimeMillis();
            tvStreamInfo.setText("推流地址: " + streamKey);
            tvStatus.setText("✅ 推流码获取成功！");
            btnStartStream.setEnabled(true);
            Toast.makeText(MainActivity.this, "推流码获取成功！", Toast.LENGTH_SHORT).show();
        }, 1500);
    }
    
    private void startStreaming() {
        tvStatus.setText("正在启动推流...");
        btnStartStream.setEnabled(false);
        
        // 模拟启动推流
        handler.postDelayed(() -> {
            isStreaming = true;
            tvStatus.setText("🔴 推流中... 观看人数: 0");
            btnStopStream.setEnabled(true);
            Toast.makeText(MainActivity.this, "推流已启动！", Toast.LENGTH_SHORT).show();
            
            // 模拟观看人数增长
            simulateViewerCount();
        }, 2000);
    }
    
    private void stopStreaming() {
        tvStatus.setText("正在停止推流...");
        btnStopStream.setEnabled(false);
        
        // 模拟停止推流
        handler.postDelayed(() -> {
            isStreaming = false;
            tvStatus.setText("推流已停止");
            btnStartStream.setEnabled(true);
            Toast.makeText(MainActivity.this, "推流已停止！", Toast.LENGTH_SHORT).show();
        }, 1000);
    }
    
    private void simulateViewerCount() {
        if (!isStreaming) return;
        
        final int[] viewerCount = {0};
        Runnable viewerSimulator = new Runnable() {
            @Override
            public void run() {
                if (isStreaming) {
                    viewerCount[0] += (int)(Math.random() * 10) + 1;
                    tvStatus.setText("🔴 推流中... 观看人数: " + viewerCount[0]);
                    handler.postDelayed(this, 3000);
                }
            }
        };
        handler.postDelayed(viewerSimulator, 3000);
    }
    
    private void checkPermissions() {
        boolean allPermissionsGranted = true;
        for (String permission : REQUIRED_PERMISSIONS) {
            if (ContextCompat.checkSelfPermission(this, permission) != PackageManager.PERMISSION_GRANTED) {
                allPermissionsGranted = false;
                break;
            }
        }
        
        if (!allPermissionsGranted) {
            ActivityCompat.requestPermissions(this, REQUIRED_PERMISSIONS, PERMISSION_REQUEST_CODE);
        }
    }
    
    @Override
    public void onRequestPermissionsResult(int requestCode, String[] permissions, int[] grantResults) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults);
        if (requestCode == PERMISSION_REQUEST_CODE) {
            boolean allGranted = true;
            for (int result : grantResults) {
                if (result != PackageManager.PERMISSION_GRANTED) {
                    allGranted = false;
                    break;
                }
            }
            
            if (allGranted) {
                Toast.makeText(this, "所有权限已授予！", Toast.LENGTH_SHORT).show();
            } else {
                Toast.makeText(this, "部分权限未授予，可能影响应用功能", Toast.LENGTH_LONG).show();
            }
        }
    }
}
