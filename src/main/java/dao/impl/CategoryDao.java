package dao.impl;


import dao.ICategoryDao;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.hibernate4.HibernateTemplate;
import org.springframework.stereotype.Repository;
import pojo.po.Category;

import java.util.List;

@Repository
public class CategoryDao implements ICategoryDao {
	//创建hibernate模板
	@Autowired
	HibernateTemplate temp;
	
	@Override
	public List<Category> selectCateByKindId(String id) {
		List<Category> list= (List<Category>) temp.find("from Category where status!=0 and kind_id="+id);
		if(!list.isEmpty()){
			return list;
		}
		return null;
	}

	@Override
	public boolean insert(Category category) {
		try {
			temp.save(category);
			return true;
		}catch (Exception e){
			e.printStackTrace();
		}
		return false;
	}

	@Override
	public Category selectCateById(String id) {
		return temp.get(Category.class,id);
	}

	@Override
	public int update(Category category) {
		try {
			temp.update(category);
			return 1;
		}catch (Exception e){
			e.printStackTrace();
		}
		return 0;
	}

	@Override
	public int batchUpdate(List<String> ids) {
		for (String id : ids){
			String sql = "update category set status=0 where id=?";
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
	public List<Category> selectAll() {
		return (List<Category>) temp.find("from Category where status!=0");
	}

}
