package com.jk.lzy.controller;

import com.jk.lzy.model.GoodBean;
import com.jk.lzy.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;

@Controller
@RequestMapping("user")
public class GoodController {
    @Autowired
    private UserService userGood;

    @RequestMapping("test")
    @ResponseBody
    public String test(){
        return userGood.test();
    }

    @RequestMapping("queryGood")
    @ResponseBody
    public HashMap<String,Object> queryGood(Integer page,Integer rows,GoodBean good){
        return userGood.queryGood(page,rows,good);
    }
    @RequestMapping("deleteGood")
    @ResponseBody
    public void deleteGood(Integer id){
        userGood.deleteGood(id);
    }
}
