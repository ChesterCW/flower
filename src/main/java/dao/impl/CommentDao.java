package dao.impl;

import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.hibernate4.HibernateCallback;
import org.springframework.orm.hibernate4.HibernateTemplate;
import org.springframework.stereotype.Repository;
import pojo.dto.Page;
import pojo.po.Comment;
import dao.ICommentDao;

import java.util.List;
import java.util.Map;

@Repository
public class CommentDao implements ICommentDao {
    @Autowired
    HibernateTemplate temp;

    @Override
    public Long countItemsByCondition(Map<String, Object> map) {
        String commId = (String) map.get("commId");
        String hql="select count(*) from Comment co where co.commId="+commId;
        List<Long> list=(List<Long>) temp.find(hql);
        if(list!=null&&list.size()>0){
            return list.get(0).longValue();
        }
        return 0L;
    }

    @Override
    public List<Comment> listItemsByPage(Map<String, Object> map) {
        Page page = (Page) map.get("page");
        String commId = (String) map.get("commId");
        List<Comment> list = (List<Comment>) temp.execute(new HibernateCallback() {
            public Object doInHibernate(Session session){
                String hql;
                if (commId != null){
                    hql = "from Comment co where co.commId="+commId;
                }else{
                    hql = "from Comment co";
                }
                Query query = session.createQuery(hql);
                query.setFirstResult(page.getOffset());
                query.setMaxResults(page.getRow());
                List<Comment> list = query.list();
                return list;
            }
        });
        if (list.size() > 0){
            return list;
        }
        return null;
    }

    @Override
    public Integer insert(Comment comment) {
        temp.save(comment);
        return null;
    }
}
