package com.jk.lzy.service.Impl;

import com.jk.lzy.model.GoodBean;
import com.jk.lzy.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import java.util.HashMap;


@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private RestTemplate restTemplate;
    @Override
    public String test() {
        return restTemplate.getForObject("http://provider/good/test",String.class);
    }
    // 分页 查询
    @Override
    public HashMap<String, Object> queryGood(Integer page,Integer rows,GoodBean good) {
        HashMap<String, Object> map =  new HashMap<>();
        map.put("page",page);
        map.put("rows",rows);
        String url = "http://provider/good/queryGood?page="+page+"&rows="+rows+"";
        HashMap forObject = restTemplate.getForObject(url, HashMap.class,map);
        return forObject;
    }
    // 删除
    @Override
    public void deleteGood(Integer id) {
        String url = "http://provider/good/deleteGood?id="+id+"";
        restTemplate.delete(url,id);
    }
}
