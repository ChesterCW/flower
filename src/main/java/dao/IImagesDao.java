package dao;

import pojo.po.Images;

import java.util.List;

public interface IImagesDao {
    int insert(List<String> images, String id);

    List<Images> getImagesByCommId(String commId);
}
