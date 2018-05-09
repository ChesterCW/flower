package dao.impl;

import dao.IImagesDao;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.hibernate4.HibernateTemplate;
import org.springframework.stereotype.Repository;
import pojo.po.Images;
import util.IDUtils;

import java.util.List;
@Repository
public class ImagesDao implements IImagesDao {
    @Autowired
    HibernateTemplate temp;

    @Override
    public int insert(List<String> images, String id) {
        Session session = null;
        Transaction transaction = null;
        try {
            session = temp.getSessionFactory().openSession();
            transaction = session.beginTransaction();
            for (int i = 0; i < images.size(); i++) {
                Images image = new Images();
                image.setId(IDUtils.getItemId()+"");
                image.setCommId(id);
                image.setImages(images.get(i));
                image.setStatus(1);
                session.save(image);
            }
            transaction.commit();
        }catch (Exception e){
            if (transaction != null) {
                transaction.rollback();
            }
        }finally {
            session.close();
        }
        return images.size();
    }

    @Override
    public List<Images> getImagesByCommId(String commId) {
        return (List<Images>) temp.find("from Images where status!=0 and commId="+commId);
    }
}
