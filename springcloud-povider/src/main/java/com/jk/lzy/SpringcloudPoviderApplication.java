package com.jk.lzy;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.netflix.eureka.EnableEurekaClient;

@SpringBootApplication
@EnableEurekaClient
@MapperScan("com.jk.lzy.dao")
public class SpringcloudPoviderApplication {

    public static void main(String[] args) {
        SpringApplication.run(SpringcloudPoviderApplication.class, args);
    }

}
