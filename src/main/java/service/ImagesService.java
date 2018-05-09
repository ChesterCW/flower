package service;

import pojo.po.Images;

import java.util.List;

public interface ImagesService {
    int addImages(List<String> images, String id);

    List<Images> loadImagesByCommId(String commId);
}
