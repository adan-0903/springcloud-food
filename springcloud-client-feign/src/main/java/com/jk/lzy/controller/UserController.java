package com.jk.lzy.controller;

import com.jk.lzy.model.GoodBean;
import com.jk.lzy.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;

/**
 * @Author: 梁展艺
 * @Description:
 * @Date: 2021/5/13 11:25
 * @param null
 * @Return:
 **/
@Controller
@RequestMapping("user")
public class UserController {
    @Autowired
    private UserService userService;

    @RequestMapping("queryGood")
    @ResponseBody
    public HashMap<String,Object> queryGood(Integer page, Integer rows, GoodBean good){
        return userService.queryGood(page,rows,good);
    }

    @RequestMapping("deleteGood")
    @ResponseBody
    public void deleteGood(Integer id){
        userService.deleteGood(id);
    }

    @RequestMapping("insertGood")
    @ResponseBody
    public void insertGood(GoodBean good){
        userService.insertGood(good);
    }
}
