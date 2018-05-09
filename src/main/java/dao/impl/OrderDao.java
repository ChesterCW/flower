package dao.impl;

import dao.IOrderDao;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.hibernate4.HibernateCallback;
import org.springframework.orm.hibernate4.HibernateTemplate;
import org.springframework.stereotype.Repository;
import pojo.dto.Page;
import pojo.po.Orders;
import pojo.vo.CommodityQuery;

import java.util.Date;
import java.util.List;
import java.util.Map;

@Repository
public class OrderDao implements IOrderDao {
    @Autowired
    HibernateTemplate temp;
    @Override
    public Integer insert(Orders order) {
        temp.save(order);
        return 0;
    }

    @Override
    public List<Map<String, Object>> selectByUserId(Integer orderStatus, String userId) {

        List<Map<String,Object>> list = (List<Map<String,Object>>) temp.execute(new HibernateCallback() {
            public Object doInHibernate(Session session){
                String hql;
                hql = "select new Map(o.id as id,o.createTime as createTime,o.payment as payment,o.orderStatus as orderStatus,re.name as name) " +
                        "from Orders o , Receiver re where o.status=1 and" +
                        " o.receiverId=re.id and re.userId="+userId;
                if (orderStatus != 0){
                    hql += "and o.orderStatus="+orderStatus;
                }
                Query query = session.createQuery(hql);
                return query.list();
            }
        });
        return list;
    }

    @Override
    public Map<String, Object> selectById(String id) {
        List<Map<String,Object>> list = (List<Map<String,Object>>) temp.execute(new HibernateCallback() {
            public Object doInHibernate(Session session){
                String hql;
                hql = "select new Map(o.id as id,o.createTime as createTime,o.payment as payment,o.orderStatus as orderStatus,re.name as name," +
                        "re.address as address,re.phone as phone ) " +
                        "from Orders o , Receiver re where o.status=1 and" +
                        " o.receiverId=re.id and o.id="+id;
                Query query = session.createQuery(hql);
                return query.list();
            }
        });
        if (list.size() > 0){
            return list.get(0);
        }
        return null;
    }

    @Override
    public Integer updateStatus(String id) {
        try {
            String sql = "update orders set o_orderstatus=?,o_updatetime=?,o_endtime=?,o_paymenttime=? where o_id=?";
            Session session = temp.getSessionFactory().openSession();
            Transaction tx = session.beginTransaction();

            Date date = new Date();
            session.createSQLQuery( sql ).setInteger( 0, 2 ).setDate(1,date).setDate(2,date).setDate(3,date).setString(4,id)
                    .executeUpdate();
            tx.commit();
            session.close();
            return 0;
        }catch (Exception e){
            e.printStackTrace();
        }
        return 0;
    }
    //根据状态值修改订单
    @Override
    public Integer updateStatus(String id,Integer orderStatus) {
        try {
            String sql = "update orders set o_orderstatus=? where o_id=?";
            Session session = temp.getSessionFactory().openSession();
            Transaction tx = session.beginTransaction();

            session.createSQLQuery( sql ).setInteger( 0, orderStatus ).setString(1,id)
                    .executeUpdate();
            tx.commit();
            session.close();
            return 0;
        }catch (Exception e){
            e.printStackTrace();
        }
        return 0;
    }

    @Override
    public Long countOrderByCondition(Map<String, Object> map) {
        Orders orders = (Orders) map.get("query");
        String id = orders.getId();

        List<Long> list = (List<Long>) temp.execute(new HibernateCallback() {
            public Object doInHibernate(Session session){
                String hql="select count(*) from Orders o where o.status!=0";
                if(!(orders.getOrderStatus() == null)){
                    hql+=" and o.orderStatus ="+orders.getOrderStatus();
                }

                if(!(id == null)){
                    hql+=" and o.id like :id";
                }

                Query query = session.createQuery(hql);
                if(!(id == null)) {
                    query.setString("id", "%" + id + "%");
                }
                return query.list();
            }
        });

        if(list!=null&&list.size()>0){
            return list.get(0);
        }
        return 0L;
    }

    @Override
    public List<Map<String, Object>> listOrderByPage(Map<String, Object> map) {
        Page page = (Page) map.get("page");
        Orders orders = (Orders) map.get("query");

        List<Map<String,Object>> list = (List<Map<String,Object>>) temp.execute(new HibernateCallback() {
            public Object doInHibernate(Session session){
                String hql;
                hql = "select new Map(o.id as id,o.createTime as createTime,o.payment as payment,o.orderStatus as orderStatus)" +
                        " from Orders o where o.status!=0 ";
                if(!(orders.getOrderStatus() == null)){
                    hql+=" and o.orderStatus ="+orders.getOrderStatus();
                }
                if(!(orders.getId() == null)){
                    hql+=" and o.id like :id";
                }

                Query query = session.createQuery(hql);
                if(!(orders.getId() == null)) {
                    query.setString("id", "%" + orders.getId() + "%");
                }
                query.setFirstResult(page.getOffset());
                query.setMaxResults(page.getRow());
                return query.list();
            }
        });
        if (list.size() > 0){
            return list;
        }
        return null;
    }
}
