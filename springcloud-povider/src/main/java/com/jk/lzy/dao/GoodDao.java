package com.jk.lzy.dao;

import com.jk.lzy.model.GoodBean;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;

@Repository
public interface GoodDao {

    Integer findGoodCount(@Param("good")GoodBean good);

    List<GoodBean> queryGood(@Param("start") Integer start, @Param("rows")Integer rows,@Param("good") GoodBean good);

    void deleteGood(Integer id);

    void insertGood(GoodBean good);
}
