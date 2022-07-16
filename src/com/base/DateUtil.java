package com.base;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.core.convert.converter.Converter;
import org.springframework.util.StringUtils;
/*
 * 处理整个系统中日期类型的转换
 * 1.实现Converter接口
 * 2.实现抽象方法convert，进行处理
 * 3.要在spring-web.xml文件里面配置该类，为整个系统服务
 * <bean id="dateUtil" class="org.springframework.format.support.FormattingConversionServiceFactoryBean" >
        <property name="converters" >
            <list>
                <bean class="com.ht.base.DateUtil"></bean>
            </list>
        </property>
    </bean>
    4.在spring-web.xml里面配置如下代码
    <mvc:annotation-driven conversion-service="dateUtil"></mvc:annotation-driven>
 * */
public class DateUtil  implements Converter<String, Date> {

    @Override
    public Date convert(String source) {
    	
    	System.out.println("source="+source);
        //实现将字符串转成日期类型(格式是yyyy-MM-dd HH:mm:ss)
        SimpleDateFormat dateFormat = null;
        if(!StringUtils.isEmpty(source)){
        	//判断日期字符串是否包含了时间部分
        	int pos1 = source.indexOf(":");//从左往右查找字符串中第一个冒号的位置
        	int pos2 = source.lastIndexOf(":");//从右往左查找字符串中第一个冒号的位置
        	source = source.replace("T", " ");//把字符串中的T替换为空格
            if(pos1>0 && pos1 != pos2){
                dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            }else if(pos1>0 && pos1==pos2){
            	source = source +":00";
            	dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            }else{
                dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            }
        }
        try {
            return dateFormat.parse(source);
        } catch (Exception e) {
            e.printStackTrace();
        }
        //如果参数绑定失败返回null
        return null;
    }

}
