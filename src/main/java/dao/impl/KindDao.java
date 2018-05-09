package dao.impl;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.hibernate4.HibernateCallback;
import org.springframework.orm.hibernate4.HibernateTemplate;
import org.springframework.stereotype.Repository;

import dao.IKindDao;
import pojo.dto.Page;
import pojo.po.Kind;
import pojo.po.Materials;

@Repository
public class KindDao implements IKindDao {

	//创建hibernate模板
	@Autowired
	private HibernateTemplate temp;
	
	
	@Override
	public List<Kind> selectAll() {
		List<Kind> list= (List<Kind>) temp.find("from Kind where status!=0");
		if(!list.isEmpty()){
			return list;
		}
		return null;
	}

	@Override
	public Long countItemsByCondition(Page pages, Kind kind) {
		String hql;
		if(kind.getName()!=null&&!kind.getName().equals("")){
			hql = "select count(*) from Kind k where k.name like '%"+kind.getName()+"%' and k.status!=0";;
		}else{
			hql = "select count(*) from Kind k where k.status!=0";
		}

		List<Long> list=(List<Long>) temp.find(hql);
		if(list!=null&&list.size()>0){
			return list.get(0).longValue();
		}
		return null;
	}

	@Override
	public List<Kind> listItemsByPage(Page pages, Kind kind) {
		List<Kind> list = (List<Kind>) temp.execute(new HibernateCallback() {
			public Object doInHibernate(Session session){
				final String hql;
				if(kind.getName()!=null&&!kind.getName().equals("")){
					hql = "from Kind k where k.name like '%"+kind.getName()+"%' and k.status!=0";;
				}else{
					hql = "from Kind k where k.status!=0";
				}
				Query query = session.createQuery(hql);
				query.setFirstResult(pages.getOffset());
				query.setMaxResults(pages.getRow());
				List<Kind> list = query.list();
				return list;
			}
		});
		if (list.size() > 0){
			return list;
		}
		return null;
	}

	@Override
	public boolean insert(Kind kind) {
		try {
			temp.save(kind);
			return true;
		}catch (Exception e){
			e.printStackTrace();
		}
		return false;
	}

	@Override
	public int batchUpdate(List<String> ids) {
		int i = 0;
		for (String id : ids){
			Session session = temp.getSessionFactory().openSession();
			String sql = "DELETE k.* ,m.* ,ca.*,co.* FROM kind k " +
					"LEFT JOIN materials m ON k.id = m.kind_id " +
					"LEFT JOIN category ca ON k.id = ca.kind_id " +
					"LEFT JOIN commodity co ON k.id = co.kind_id WHERE k.id = ?";
			Transaction tx = session.beginTransaction();
			i = session.createSQLQuery(sql)
					.setString(0, id)
					.executeUpdate();
			tx.commit();
			session.close();
		}
		return i;
	}

}
