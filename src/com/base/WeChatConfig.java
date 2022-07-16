package com.base;

public class WeChatConfig {
	
    public static final String SECRETID = WeChatProperties.get("secretId");
    public static final String SECRETKEY = WeChatProperties.get("secretKey");
    public static final String SERVERIP = WeChatProperties.get("serverIp");
    public static final String AREA = WeChatProperties.get("area");
}
