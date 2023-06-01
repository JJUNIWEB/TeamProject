package com.earth.service;

import com.earth.domain.ImageDto;
import com.earth.mapper.ImageMapper;

public interface ImageService {
    //개 프로필
    //                values (#{pt_adres},#{pt_category},#{user_email})
    public ImageDto inputDogProf(String id, String address, String category);
    public ImageDto callDogProf(String id, String category);

    // dangcomu post 이미지
    public ImageDto inputComuPost(String user_id, int post_id, String address, String category);
    public ImageDto callComuPost(String user_id,int post_id, String address, String category);
}
