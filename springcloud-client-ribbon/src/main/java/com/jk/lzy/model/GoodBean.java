package com.jk.lzy.model;

import lombok.Data;

import java.io.Serializable;

@Data
public class GoodBean implements Serializable {
    private Integer id;
    private String goodname;
    private Integer goodprice;
    private Integer goodtype;
    private String goodtime;
    private Integer status;

    private Integer page;
    private Integer rows;
}
