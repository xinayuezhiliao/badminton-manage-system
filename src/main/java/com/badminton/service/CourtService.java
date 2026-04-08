package com.badminton.service;

import com.badminton.entity.Court;
import java.util.List;

public interface CourtService {
    List<Court> list();
    int add(Court court);
    int update(Court court);
    int delete(Integer id);
    Court getById(Integer id);
}