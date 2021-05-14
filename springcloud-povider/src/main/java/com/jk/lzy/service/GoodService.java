package com.jk.lzy.service;

import com.jk.lzy.model.GoodBean;

import java.util.HashMap;

public interface GoodService {

    HashMap<String, Object> queryGood(Integer page, Integer rows, GoodBean good);

    void deleteGood(Integer id);

    void insertGood(GoodBean good);
}
