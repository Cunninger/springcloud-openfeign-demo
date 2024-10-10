package cn.yam.order;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.openfeign.EnableFeignClients;

/**
 * 功能：
 * 日期：2024/10/9 下午7:06
 */
@EnableFeignClients
//开启feign, 会扫描@FeignClient注解, 并生成代理对象
@SpringBootApplication
public class ApiServiceApplication {
    public static void main(String[] args) {
        SpringApplication.run(ApiServiceApplication.class, args);
    }
}