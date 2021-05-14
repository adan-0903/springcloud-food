package com.jk.lzy;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.netflix.eureka.EnableEurekaClient;
import org.springframework.cloud.openfeign.EnableFeignClients;

@SpringBootApplication
@EnableEurekaClient //开启eureka客户端
@EnableFeignClients //开启feign可用
public class SpringcloudClientFeignApplication {

    public static void main(String[] args) {
        SpringApplication.run(SpringcloudClientFeignApplication.class, args);
    }

}
