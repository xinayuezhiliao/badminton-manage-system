package com.badminton.service;

import com.badminton.entity.Huiyuan;
import java.util.List;

public interface HuiyuanService {
    List<Huiyuan> list();
    int add(Huiyuan huiyuan);
    int update(Huiyuan huiyuan);
    int delete(Integer id);
    Huiyuan getById(Integer id);
}