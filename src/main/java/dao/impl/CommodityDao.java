package dao.impl;

import java.util.List;
import java.util.Map;


import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.orm.hibernate4.HibernateCallback;
import org.springframework.orm.hibernate4.HibernateTemplate;
import org.springframework.stereotype.Repository;

import dao.ICommodityDao;
import pojo.dto.Page;
import pojo.po.Commodity;
import pojo.po.User;
import pojo.vo.CommodityLink;
import pojo.vo.CommodityQuery;
@Repository
public class CommodityDao implements ICommodityDao{
	//创建hibernate模板
	@Autowired
	private HibernateTemplate temp;

	//根据条件查询总记录数
	@Override
	public Long countItemsByCondition(Map<String, Object> map) {
		CommodityQuery query = (CommodityQuery) map.get("query");
		String title = query.getTitle();

		List<Long> list = (List<Long>) temp.execute(new HibernateCallback() {
			public Object doInHibernate(Session session){
				String hql="select count(*) from Commodity co where co.status!=0";
				if(!(title == null)){
					hql+=" and co.title like :title";
				}

				Query query = session.createQuery(hql);
				if(!(title == null)) {
					query.setString("title", "%" + title + "%");
				}
				return query.list();
			}
		});

        if(list!=null&&list.size()>0){
            return list.get(0);
        }
        return 0L;
	}


	//根据条件查询商品
	@Override
	public List<Map<String,Object>> listItemsByPage(Map<String, Object> map) {

		Page page = (Page) map.get("page");
		CommodityQuery query = (CommodityQuery) map.get("query");

		List<Map<String,Object>> list = (List<Map<String,Object>>) temp.execute(new HibernateCallback() {
			public Object doInHibernate(Session session){
				String hql;
				hql = "select new Map(c.id as id,c.title as title,c.count as count,c.description as description,c.status as status," +
						"c.wishes as wishes,c.marketprice as marketprice,c.vipprice as vipprice," +
						"img.images as images) from Images img , Commodity c where c.id=img.commId and c.status!=0 ";
				if(page.getTitle() != null&& !page.getTitle().equals("")){
					hql += "and c.title like :title";
				}
				if (query.getKindId() != null && !query.getKindId().equals("")){
					hql += "and c.kindId="+query.getKindId();
				}
				if (query.getMateId() != null && !query.getMateId().equals("")){
					hql += "and c.mateId="+query.getMateId();
				}
				hql += " group by img.commId";

				Query query = session.createQuery(hql);
				if(page.getTitle() != null&& !page.getTitle().equals("")) {
					query.setString("title", "%" + page.getTitle() + "%");
				}
				query.setFirstResult(page.getOffset());
				query.setMaxResults(page.getRow());
				return query.list();
			}
		});


//		List<Commodity> list = (List<Commodity>) temp.execute(new HibernateCallback() {
//			public Object doInHibernate(Session session){
//				String hql = "from Commodity co where co.status!=0";
//
//				Query query = session.createQuery(hql);
//				query.setFirstResult(page.getOffset());
//				query.setMaxResults(page.getRow());
//				List<Commodity> list = query.list();
//				return list;
//			}
//		});
		if (list.size() > 0){
			return list;
		}

		return null;
	}

	@Override
	public int update(Commodity commodity) {
		Integer i = 0;
		try{
			temp.update(commodity);
			i = 1;
		}catch (Exception e){
			e.printStackTrace();
		}
		return i;
	}

	@Override
	public void updateById(String id) {
		Commodity commodity = temp.get(Commodity.class, id);
		commodity.setStatus(0);
		temp.update(commodity);
	}

	@Override
	public int insert(Commodity commodity) {
		try {
			temp.save(commodity);
			return 1;
		}catch (Exception e){
			e.printStackTrace();
		}
		return 0;
	}

	//根据种类Id查询商品总数
	@Override
	public Long countItemsByKindId(Map<String, Object> map) {
		String kindId = (String) map.get("kindId");

		String hql="select count(*) from Commodity co where co.status!=0";
		if(!(kindId == null)){
			hql+=" and co.kindId ="+kindId;
		}
		List<Long> list=(List<Long>) temp.find(hql);
		if(list!=null&&list.size()>0){
			return list.get(0).longValue();
		}
		return 0L;
	}

	//根据种类Id查询商品
	@Override
	public List<Map<String, Object>> listItemsByKindId(Map<String, Object> map) {
		Page page = (Page) map.get("page");
		String kindId = (String) map.get("kindId");
		List<Map<String,Object>> list = (List<Map<String,Object>>) temp.execute(new HibernateCallback() {
			public Object doInHibernate(Session session){
				final String hql;
				hql = "select new Map(c.id as id,c.title as title,c.status as status,c.wishes as wishes,c.marketprice as marketprice,c.vipprice as vipprice," +
						"img.images as images) from Images img , Commodity c where c.id=img.commId and c.status!=0 and c.kindId="+kindId+" group by img.commId";
				Query query = session.createQuery(hql);
				query.setFirstResult(page.getOffset());
				query.setMaxResults(page.getRow());
				return query.list();
			}
		});

		return list;
	}

	//查询单个商品
	@Override
	public Map<String,Object> selectCommodityById(String id) {
		List<Map<String,Object>> list = (List<Map<String,Object>>) temp.execute(new HibernateCallback() {
			public Object doInHibernate(Session session){
				final String hql;
				hql = "select new Map(c.id as id,c.attache as attache,c.description as description,c.title as title,c.status as status,c.wishes as wishes," +
						"c.marketprice as marketprice,c.vipprice as vipprice,ca.name as cateName,m.name as mateName" +
						") from Commodity c,Category ca,Materials m where c.cateId=ca.id and c.status!=0 and c.mateId=m.id and c.id="+id;
				Query query = session.createQuery(hql);
				return query.list();
			}
		});
		if (list.size() > 0){
			return list.get(0);
		}
		return null;
	}

}
