package dao.impl;

import dao.IOrderCommodityDao;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.hibernate4.HibernateCallback;
import org.springframework.orm.hibernate4.HibernateTemplate;
import org.springframework.stereotype.Repository;
import pojo.po.CommUse;
import pojo.po.OrderCommodity;
import pojo.vo.CartCommodity;
import util.IDUtils;

import java.util.List;
import java.util.Map;

@Repository
public class OrderCommodityDao implements IOrderCommodityDao {
    @Autowired
    HibernateTemplate temp;
    @Override
    public Integer addCommodity(List<Map<String,Object>> list, String orderId) {
        Session session = null;
        Transaction transaction = null;
        try {
            session = temp.getSessionFactory().openSession();
            transaction = session.beginTransaction();
            for (int i = 0; i < list.size(); i++) {
                OrderCommodity orderCommodity = new OrderCommodity();
                orderCommodity.setId(IDUtils.getItemId()+"");
                orderCommodity.setOrderId(orderId);
                orderCommodity.setCommId((String) list.get(i).get("id"));
                orderCommodity.setNum((Integer) list.get(i).get("count"));

                session.save(orderCommodity);
            }
            transaction.commit();
        }catch (Exception e){
            if (transaction != null) {
                transaction.rollback();
            }
        }finally {
            session.close();
        }
        return null;
    }

    @Override
    public List<Map<String, Object>> selectCommodityByOrderId(String id) {
        List<Map<String,Object>> list = (List<Map<String,Object>>) temp.execute(new HibernateCallback() {
        public Object doInHibernate(Session session){
            String hql;
            hql = "select new Map(co.id as commId,co.title as title,co.vipprice as vipPrice,oc.num as num ) " +
                    "from Commodity co , OrderCommodity oc where co.id=oc.commId and" +
                    " oc.orderId="+id;
            Query query = session.createQuery(hql);
            return query.list();
        }
        });
        return list;
    }
}
