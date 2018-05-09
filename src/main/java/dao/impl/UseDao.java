package dao.impl;

import dao.IUseDao;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.hibernate4.HibernateCallback;
import org.springframework.orm.hibernate4.HibernateTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import pojo.dto.Page;
import pojo.po.Materials;
import pojo.po.Use;

import java.util.List;
import java.util.Map;

@Repository
@Transactional(readOnly = false, propagation = Propagation.REQUIRES_NEW )
public class UseDao implements IUseDao {

    @Autowired
    HibernateTemplate temp;

    @Override
    public List<Use> getAllUse() {
        return (List<Use>) temp.find("from Use where status!=0");
    }

    @Override
    public Long countItemsByCondition(Page pages, Use use) {
        String hql;
        if(use.getTitle()!=null&&!use.getTitle().equals("")){
            hql = "select count(*) from Use u where u.title like '%"+use.getTitle()+"%' and u.status!=0";;
        }else{
            hql = "select count(*) from Use u where u.status!=0";
        }

        List<Long> list=(List<Long>) temp.find(hql);
        if(list!=null&&list.size()>0){
            return list.get(0).longValue();
        }
        return null;
    }

    @Override
    public List<Use> listItemsByPage(Page pages, Use use) {
        List<Use> list = (List<Use>) temp.execute(new HibernateCallback() {
            public Object doInHibernate(Session session){
                final String hql;
                if(use.getTitle()!=null&&!use.getTitle().equals("")){
                    hql = "from Use u where u.title like '%"+use.getTitle()+"%' and u.status!=0";;
                }else{
                    hql = "from Use u where u.status!=0";
                }
                Query query = session.createQuery(hql);
                query.setFirstResult(pages.getOffset());
                query.setMaxResults(pages.getRow());
                List<Use> list = query.list();
                return list;
            }
        });
        if (list.size() > 0){
            return list;
        }
        return null;
    }

    @Override
    public Use selectUseById(String id) {
        return temp.get(Use.class,id);
    }

    @Override
    public int update(Use use) {
        try {
            temp.update(use);
        }catch (Exception e){
            e.printStackTrace();
        }
        return 0;
    }

    @Override
    public int batchUpdate(List<String> ids) {
        for (String id : ids){
            String sql = "update purpose set status=0 where id=?";
            Session session = temp.getSessionFactory().openSession();
            Transaction tx = session.beginTransaction();

            session.createSQLQuery( sql )
                    .setString( 0, id )
                    .executeUpdate();
            tx.commit();
            session.close();
        }
        return ids.size();
    }

    @Override
    public boolean insert(Use use) {
        try {
            temp.save(use);
            return true;
        }catch (Exception e){
            e.printStackTrace();
        }
        return false;
    }

    //根据useId查询商品总数
    @Override
    public Long countItemsByUseId(Map<String, Object> map) {
        String useId = (String) map.get("useId");

        String hql="select count(cu.useId) from CommUse cu,Commodity co where co.status!=0 and cu.commId=co.id";
        if(!(useId == null)){
            hql+=" and cu.useId ="+useId;
        }
        List<Long> list=(List<Long>) temp.find(hql);
        if(list!=null&&list.size()>0){
            return list.get(0).longValue();
        }
        return 0L;
    }

    //根据useId查询商品列表
    @Override
    public List<Map<String, Object>> listItemsByUseId(Map<String, Object> map) {
        Page page = (Page) map.get("page");
        String useId = (String) map.get("useId");
        List<Map<String,Object>> list = (List<Map<String,Object>>) temp.execute(new HibernateCallback() {
            public Object doInHibernate(Session session){
                final String hql;
                hql = "select new Map(c.id as id,c.title as title,c.status as status,c.wishes as wishes,c.marketprice as marketprice,c.vipprice as vipprice," +
                        "img.images as images) from CommUse cu, Images img , Commodity c where c.id=img.commId and c.status!=0" +
                        " and cu.useId="+useId+" and cu.commId=c.id group by img.commId";
                Query query = session.createQuery(hql);
                query.setFirstResult(page.getOffset());
                query.setMaxResults(page.getRow());
                return query.list();
            }
        });

        return list;
    }
}
