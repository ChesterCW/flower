package dao.impl;

import dao.IColorDao;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.hibernate4.HibernateCallback;
import org.springframework.orm.hibernate4.HibernateTemplate;
import org.springframework.stereotype.Repository;
import pojo.dto.Page;
import pojo.po.Color;
import pojo.po.Materials;

import java.util.List;
@Repository
public class ColorDao implements IColorDao {
    @Autowired
    HibernateTemplate temp;
    @Override
    public List<Color> selectAll() {
        return (List<Color>) temp.find("from Color where status!=0");
    }

    @Override
    public Long countItemsByCondition(Page pages, Color color) {
        String hql;
        if(color.getColor()!=null&&!color.getColor().equals("")){
            hql = "select count(*) from Color c where c.color like '%"+color.getColor()+"%' and c.status!=0";;
        }else{
            hql = "select count(*) from Color c where c.status!=0";
        }

        List<Long> list=(List<Long>) temp.find(hql);
        if(list!=null&&list.size()>0){
            return list.get(0).longValue();
        }
        return null;
    }

    @Override
    public List<Color> listItemsByPage(Page pages, Color color) {
        List<Color> list = (List<Color>) temp.execute(new HibernateCallback() {
            public Object doInHibernate(Session session){
                final String hql;
                if(color.getColor()!=null&&!color.getColor().equals("")){
                    hql = "from Color c where c.color like '%"+color.getColor()+"%' and c.status!=0";;
                }else{
                    hql = "from Color c where c.status!=0";
                }
                Query query = session.createQuery(hql);
                query.setFirstResult(pages.getOffset());
                query.setMaxResults(pages.getRow());
                List<Color> list = query.list();
                return list;
            }
        });
        if (list.size() > 0){
            return list;
        }
        return null;
    }

    @Override
    public boolean insert(Color color) {
        try {
            temp.save(color);
            return true;
        }catch (Exception e){
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public int batchUpdate(List<String> ids) {
        for (String id : ids){
            String sql = "update color set status=0 where id=?";
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
}
