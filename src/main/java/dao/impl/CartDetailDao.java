package dao.impl;

import dao.ICartDetailDao;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.hibernate4.HibernateCallback;
import org.springframework.orm.hibernate4.HibernateTemplate;
import org.springframework.stereotype.Repository;
import pojo.po.CartDetail;
import pojo.vo.CartCommodity;

import java.util.List;
import java.util.Map;

@Repository
public class CartDetailDao implements ICartDetailDao {
    @Autowired
    HibernateTemplate temp;
    @Override
    public CartDetail selectByCartIdAndCommId(String cartId,String commId) {
        List<CartDetail> cartDetails = (List<CartDetail>) temp.find("from CartDetail where cartId=" + cartId+ " and commId=" + commId);
        if (cartDetails.isEmpty()){
            return null;
        }
        return cartDetails.get(0);
    }

    @Override
    public void insert(CartDetail cartDetail) {
        temp.save(cartDetail);
    }

    @Override
    public boolean update(CartDetail cartDetail) {
        temp.update(cartDetail);
        return true;
    }

    @Override
    public List<CartCommodity> selectByCartId(String cartId) {

        List<CartCommodity> list = (List<CartCommodity>) temp.execute(new HibernateCallback() {
            public Object doInHibernate(Session session){
                final String hql;
                hql = "select new Map(c.id as id,c.title as title,c.marketprice as marketprice,c.vipprice as vipprice,ca.count as count) " +
                        "from CartDetail ca , Commodity c where c.id=ca.commId and ca.cartId="+cartId;
                Query query = session.createQuery(hql);
                return query.list();
            }
        });
        return list;
    }

    @Override
    public Integer updateCount(String cartId, String commId, Integer count) {

        try {
            String sql = "update cartdetail set count=? where cart_id=? and comm_id=?";
            Session session = temp.getSessionFactory().openSession();
            Transaction tx = session.beginTransaction();

            session.createSQLQuery( sql ).setInteger( 0, count ).setString(1,cartId).setString(2,commId)
                    .executeUpdate();
            tx.commit();
            session.close();
            return count;
        }catch (Exception e){
            e.printStackTrace();
        }
        return 0;
    }

    @Override
    public Integer deleteCommodity(String cartId, String commId) {
        try {
            String sql = "delete from cartdetail where cart_id=? and comm_id=?";
            Session session = temp.getSessionFactory().openSession();
            Transaction tx = session.beginTransaction();

            session.createSQLQuery( sql ).setString( 0, cartId ).setString(1,commId)
                    .executeUpdate();
            tx.commit();
            session.close();
            return 0;
        }catch (Exception e){
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public Integer updateCartId(String id, String cartId) {
        try {
            String sql = "update cartdetail set cart_id=? where cart_id=?";
            Session session = temp.getSessionFactory().openSession();
            Transaction tx = session.beginTransaction();

            session.createSQLQuery( sql ).setString( 0, id ).setString(1,cartId)
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
    public List<Map<String,Object>> selectBuyCommodity(String cartId) {
        List<Map<String,Object>> list = (List<Map<String,Object>>) temp.execute(new HibernateCallback() {
            public Object doInHibernate(Session session){
                final String hql;
                hql = "select new Map(c.id as id,c.title as title,c.marketprice as marketprice,c.vipprice as vipprice,ca.count as count) " +
                        "from CartDetail ca , Commodity c where ca.status=1 and" +
                        " c.id=ca.commId and ca.cartId="+cartId;
                Query query = session.createQuery(hql);
                return query.list();
            }
        });
        return list;
    }

    @Override
    public Integer deleteByCartId(String cartId) {
        try {
            String sql = "delete from cartdetail where cart_id=?";
            Session session = temp.getSessionFactory().openSession();
            Transaction tx = session.beginTransaction();

            session.createSQLQuery( sql ).setString( 0, cartId )
                    .executeUpdate();
            tx.commit();
            session.close();
            return 0;
        }catch (Exception e){
            e.printStackTrace();
        }
        return 0;
    }
}
