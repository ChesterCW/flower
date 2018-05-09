package dao.impl;

import dao.IHotDao;
import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.hibernate4.HibernateCallback;
import org.springframework.orm.hibernate4.HibernateTemplate;
import org.springframework.stereotype.Repository;
import pojo.po.Hot;

import java.util.List;
import java.util.Map;

@Repository
public class HotDao implements IHotDao {
    @Autowired
    HibernateTemplate temp;

    @Override
    public Integer addHotCommodity(Hot hot) {
        temp.save(hot);
        return null;
    }

    @Override
    public Hot selectByCommId(String id) {
        List<Hot> list = (List<Hot>) temp.find("from Hot where commId="+id);
        if (list.size() > 0){
            return list.get(0);
        }
        return null;
    }

    @Override
    public void update(Hot hot) {
        temp.update(hot);
    }

    @Override
    public List<Map<String, Object>> selectAll() {
        List<Map<String, Object>> list;
        list = (List<Map<String,Object>>) temp.execute(new HibernateCallback() {
            public Object doInHibernate(Session session){
                String hql;
                hql = "select new Map(im.images as images,h.commId as commId,co.title as title,co.vipprice as vipPrice,co.marketprice as marketPrice) " +
                        "from Hot h ,Commodity co,Images im where h.commId=co.id and im.commId=h.commId" +
                        " group by h.commId order by h.count";

                Query query = session.createQuery(hql);
                query.setMaxResults(6);
                return query.list();
            }
        });
        return list;
    }
}
