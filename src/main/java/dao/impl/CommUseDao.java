package dao.impl;

import dao.ICommUseDao;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.hibernate4.HibernateCallback;
import org.springframework.orm.hibernate4.HibernateTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import pojo.po.CommUse;
import pojo.po.Images;
import pojo.po.Use;
import util.IDUtils;

import java.util.List;

@Repository
@Transactional(readOnly = false, propagation = Propagation.REQUIRES_NEW )
public class CommUseDao implements ICommUseDao {
    @Autowired
    HibernateTemplate temp;

    //向商品用途中间表中插入数据
    @Override
    public int insertCommUse(List<String> commUse, String id) {
        Session session = null;
        Transaction transaction = null;
        try {
            session = temp.getSessionFactory().openSession();
            transaction = session.beginTransaction();
            for (int i = 0; i < commUse.size(); i++) {
                CommUse commuse = new CommUse();
                commuse.setCommId(id);
                commuse.setUseId(commUse.get(i));
                session.save(commuse);
            }
            transaction.commit();
        }catch (Exception e){
            if (transaction != null) {
                transaction.rollback();
            }
        }finally {
            session.close();
        }
        return commUse.size();
    }

    //根据商品Id获取该商品用途
    @Override
    public List<Use> selectUseByCommId(String id) {
        List<Use> list = (List<Use>) temp.execute(new HibernateCallback() {
            public Object doInHibernate(Session session){
                final String hql;
                hql = "select new Map(u.id as id,u.title as title,u.status as status) " +
                        "from CommUse cu , Use u where cu.useId=u.id and u.status!=0 and cu.commId="+id;
                Query query = session.createQuery(hql);
                return query.list();
            }
        });
        return list;
    }

    @Override
    public Integer deleteByCommId(String id) {
        Integer k = (Integer)temp.execute(new HibernateCallback() {
            public Object doInHibernate(Session session) {
                final String hql;
                hql = "delete from CommUse where commId=" + id;
                Query query = session.createQuery(hql);
                Integer k = query.executeUpdate();
                return k;
            }
        });
        return k;
    }
}
