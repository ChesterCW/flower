package dao.impl;

import java.util.List;
import java.util.Map;

import org.hibernate.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.hibernate4.HibernateCallback;
import org.springframework.orm.hibernate4.HibernateTemplate;
import org.springframework.stereotype.Repository;

import dao.IMaterialsDao;
import pojo.dto.Page;
import pojo.po.Materials;
import pojo.po.User;

@Repository
public class MaterialsDao implements IMaterialsDao {

	@Autowired
	private HibernateTemplate temp;

	
	@Override
	public List<Materials> selectMateByKindId(String kindId) {
		List<Materials> list = (List<Materials>) temp.find("from Materials where status!=0 and kind_id=" + kindId);
		if(!list.isEmpty()){
			return list;
		}
		return null;
	}

	@Override
	public Long countItemsByCondition(Page pages, Materials materials) {
		String hql;
		if(materials.getName()!=null&&!materials.getName().equals("")){
			hql = "select count(*) from Materials m where m.name like '%"+materials.getName()+"%' and m.status!=0";;
		}else{
			hql = "select count(*) from Materials m where m.status!=0";
		}

		List<Long> list=(List<Long>) temp.find(hql);
		if(list!=null&&list.size()>0){
			return list.get(0).longValue();
		}
		return null;
	}

	@Override
	public List<Materials> listItemsByPage(Page pages, Materials materials) {
		List<Materials> list = (List<Materials>) temp.execute(new HibernateCallback() {
			public Object doInHibernate(Session session){
				final String hql;
				if(materials.getName()!=null&&!materials.getName().equals("")){
					hql = "from Materials m where m.name like '%"+materials.getName()+"%' and m.status!=0";;
				}else{
					hql = "from Materials m where m.status!=0";
				}
				Query query = session.createQuery(hql);
				query.setFirstResult(pages.getOffset());
				query.setMaxResults(pages.getRow());
				List<Materials> list = query.list();
				return list;
			}
		});
		if (list.size() > 0){
			return list;
		}
		return null;
	}

	@Override
	public Materials selectMaterialById(String id) {
		List<Materials> list = (List<Materials>) temp.execute(new HibernateCallback() {
			public Object doInHibernate(Session session){
				final String hql;
				hql = "from Materials m where m.status!=0 and m.id="+id;
				Query query = session.createQuery(hql);
				List<Materials> list = query.list();
				return list;
			}
		});
		return list.get(0);
	}

	@Override
	public int update(Materials materials) {
		temp.update(materials);
		return 0;
	}

	@Override
	public int batchUpdate(List<String> ids) {
		for (String id : ids){
			String sql = "update materials set status=0 where id=?";
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
	public boolean insert(Materials materials) {
		boolean flag = false;
		try{
			temp.save(materials);
			flag = true;
		}catch (Exception e){
			e.printStackTrace();
		}
		return flag;
	}

	@Override
	public List<Materials> selectAll() {
		return (List<Materials>) temp.find("from Materials where status!=0");
	}

	//根据材料Id查询商品总数
	@Override
	public Long countItemsByMateId(Map<String, Object> map) {
		Page page = (Page) map.get("page");
		String mateId = (String) map.get("mateId");

		String hql="select count(*) from Commodity co where co.status!=0";
		if(!(mateId == null)){
			hql+=" and co.mateId ="+mateId;
		}
		List<Long> list=(List<Long>) temp.find(hql);
		if(list!=null&&list.size()>0){
			return list.get(0).longValue();
		}
		return 0L;
	}

	//根据材料Id查询商品列表
	@Override
	public List<Map<String, Object>> listItemsByMateId(Map<String, Object> map) {
		Page page = (Page) map.get("page");
		String mateId = (String) map.get("mateId");
		List<Map<String,Object>> list = (List<Map<String,Object>>) temp.execute(new HibernateCallback() {
			public Object doInHibernate(Session session){
				final String hql;
				hql = "select new Map(c.id as id,c.title as title,c.status as status,c.wishes as wishes,c.marketprice as marketprice,c.vipprice as vipprice," +
						"img.images as images) from Images img , Commodity c where c.id=img.commId and c.status!=0 and c.mateId="+mateId+" group by img.commId";
				Query query = session.createQuery(hql);
				query.setFirstResult(page.getOffset());
				query.setMaxResults(page.getRow());
				return query.list();
			}
		});

		return list;
	}

}
