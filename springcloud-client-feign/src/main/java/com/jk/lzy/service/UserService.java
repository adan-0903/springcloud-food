package com.jk.lzy.service;

import com.jk.lzy.model.GoodBean;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.HashMap;

//定义一个feign接口，通过@ FeignClient（“服务名”），来指定调用哪个服务
// 2 //value ‐‐‐>指定调用哪个服务
@FeignClient(value = "provider")
public interface UserService {
    // 查询
    @RequestMapping("/good/queryGood")
    HashMap<String, Object> queryGood(@RequestParam Integer page, @RequestParam Integer rows, @RequestParam GoodBean good);
    // 删除
    @RequestMapping("/good/deleteGood")
    void deleteGood(@RequestParam Integer id);
    // 新增
    @PostMapping("good/insertGood")
    void insertGood(GoodBean good);
}
