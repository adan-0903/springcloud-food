package com.jk.lzy.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("path")
public class PathController {
    @RequestMapping("show")
    public String show(){
        return "page/show";
    }
    // 新增 页面
    @RequestMapping("addqwe")
    public String addqwe(){
        return "page/addqwe";
    }
}
