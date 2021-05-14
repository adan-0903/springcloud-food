package com.jk.lzy.service.Impl;

import com.jk.lzy.dao.GoodDao;
import com.jk.lzy.model.GoodBean;
import com.jk.lzy.service.GoodService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;

@Service
public class GoodServiceImpl implements GoodService {
    @Autowired
    private GoodDao goodDao;
    // 查询
    @Override
    public HashMap<String, Object> queryGood(Integer page, Integer rows, GoodBean good) {
        Integer start = (page-1) * rows;
        Integer count =  goodDao.findGoodCount(good);
        List<GoodBean> list =  goodDao.queryGood(start,rows,good);
        HashMap<String, Object> map =  new HashMap<>();
        map.put("total",count);
        map.put("rows",list);
        return map;
    }
    // 删除
    @Override
    public void deleteGood(Integer id) {
        goodDao.deleteGood(id);
    }
    // 新增
    @Override
    public void insertGood(GoodBean good) {
        goodDao.insertGood(good);
    }
}
