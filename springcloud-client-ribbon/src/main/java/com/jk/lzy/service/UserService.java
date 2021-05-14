package com.jk.lzy.service;

import com.jk.lzy.model.GoodBean;

import java.util.HashMap;

public interface UserService {
    String test();

    HashMap<String, Object> queryGood(Integer page,Integer rows,GoodBean good);

    void deleteGood(Integer id);
}
