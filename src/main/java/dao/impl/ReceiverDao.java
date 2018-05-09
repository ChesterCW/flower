package dao.impl;

import dao.IReceiverDao;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.hibernate4.HibernateTemplate;
import org.springframework.stereotype.Repository;
import pojo.po.Receiver;

import java.util.List;
@Repository
public class ReceiverDao implements IReceiverDao {
    @Autowired
    HibernateTemplate temp;
    @Override
    public List<Receiver> selectByUserId(String userId) {
        List list = (List<Receiver>) temp.find("from Receiver where status!=0 and userId="+userId);
        if (list.size() > 0){
            return list;
        }
        return null;
    }

    @Override
    public Integer insert(Receiver receiver) {
        temp.save(receiver);
        return 0;
    }

    @Override
    public Integer update(Receiver receiver) {
        temp.update(receiver);
        return null;
    }

    @Override
    public Receiver selectById(String id) {
        return temp.get(Receiver.class,id);
    }

    @Override
    public boolean updateByUserId(String userId) {
        try {
            String sql = "update receiver set status=? where user_id=?";
            Session session = temp.getSessionFactory().openSession();
            Transaction tx = session.beginTransaction();

            session.createSQLQuery( sql ).setInteger( 0, 2 ).setString(1,userId)
                    .executeUpdate();
            tx.commit();
            session.close();
            return true;
        }catch (Exception e){
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean updateById(String id) {
        try {
            String sql = "update receiver set status=? where id=?";
            Session session = temp.getSessionFactory().openSession();
            Transaction tx = session.beginTransaction();

            session.createSQLQuery( sql ).setInteger( 0, 1 ).setString(1,id)
                    .executeUpdate();
            tx.commit();
            session.close();
            return true;
        }catch (Exception e){
            e.printStackTrace();
        }
        return false;
    }

    //逻辑删除收货人地址
    @Override
    public boolean deleteReceiver(String id) {
        try {
            String sql = "update receiver set status=? where id=?";
            Session session = temp.getSessionFactory().openSession();
            Transaction tx = session.beginTransaction();

            session.createSQLQuery( sql ).setInteger( 0, 0 ).setString(1,id)
                    .executeUpdate();
            tx.commit();
            session.close();
            return true;
        }catch (Exception e){
            e.printStackTrace();
        }
        return false;
    }
}
