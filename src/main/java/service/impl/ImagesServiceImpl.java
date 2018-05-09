package service.impl;

import dao.IImagesDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import pojo.po.Images;
import service.ImagesService;

import java.util.List;

@Service
@Transactional(isolation= Isolation.READ_COMMITTED,propagation= Propagation.REQUIRED)
public class ImagesServiceImpl implements ImagesService {
    @Autowired
    IImagesDao imagesDao;

    @Override
    public int addImages(List<String> images, String id) {
        return imagesDao.insert(images,id);
    }

    @Override
    public List<Images> loadImagesByCommId(String commId) {
        return imagesDao.getImagesByCommId(commId);
    }
}
