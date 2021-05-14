package com.jk.lzy.controller;

import com.jk.lzy.model.GoodBean;
import com.jk.lzy.service.GoodService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;

/**
 * @Author: 梁展艺
 * @Description:
 * @Date: 2021/5/12 17:56
 * @param null
 * @Return:
 **/
@Controller
@RequestMapping("good")
public class GoodController {

    @Autowired
    private GoodService goodService;

    @RequestMapping("test")
    @ResponseBody
    public String test(){
        return "hello world";
    }

    @RequestMapping("queryGood")
    @ResponseBody
    public HashMap<String,Object> queryGood(Integer page, Integer rows, GoodBean good){
        return goodService.queryGood(page,rows,good);
    }

    @RequestMapping("deleteGood")
    @ResponseBody
    public void deleteGood(Integer id){
        goodService.deleteGood(id);
    }

    @RequestMapping("insertGood")
    @ResponseBody()
    public void  insertGood(@RequestBody GoodBean good){
        goodService.insertGood(good);
    }
}
