package com.base;

import java.io.InputStream;
import java.util.Properties;


/**
 * 读取system.properties配置文件中的参数
 * */
public class WeChatProperties {
	private static Properties wechatProperties;

	//加载system.properties配置文件
    private static synchronized void loadProperties() {
        if (null == wechatProperties) {
            try {
                Properties properties = new Properties();
                InputStream inputStream = WeChatProperties.class.getClassLoader().getResourceAsStream("system.properties");
                properties.load(inputStream);
                wechatProperties = properties;
            } catch (Exception e) {
                throw new RuntimeException("未找到配置文件.");
            }
        }
    }

    //读取配置文件中的参数的值
    public static String get(String key) {
        loadProperties();
        return wechatProperties.getProperty(key);
    }
}
