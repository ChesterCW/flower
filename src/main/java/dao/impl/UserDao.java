package dao.impl;

import java.util.List;


import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.hibernate4.HibernateCallback;
import org.springframework.orm.hibernate4.HibernateTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import dao.IUserDao;
import pojo.dto.Page;
import pojo.po.User;

@Repository
public class UserDao implements IUserDao{

	@Autowired
	private HibernateTemplate temp;

	@Override
	public boolean insert(User user) throws Exception {
		boolean flag = false;
		try {
			temp.save(user);
			flag = true;
		}catch (Exception e){
			e.printStackTrace();
		}
		return flag;
	}

	@Override
	public void delete(User user) throws Exception {
		temp.delete(user);
	}

	@Override
	public boolean update(User user) throws Exception {
		boolean flag = false;
		try {
			temp.update(user);
			flag = true;
		}catch (Exception e){
			e.printStackTrace();
		}
		return flag;
	}

	@Transactional(readOnly=true)
	@Override
	public User selectByUsername(User user) throws Exception {
		String hql = "from pojo.po.User u where email=? and password=?";
		List<User> list= (List<User>) temp.find(hql,new String[]{user.getEmail(),user.getPassword()});
		 if(!list.isEmpty()){
			 return list.get(0);
		 }

		return null;
	}

	//按照条件查询用户个数
	@Transactional(readOnly=true)
	@Override
	public Long countItemsByCondition(final Page page,final User user) {
		String hql;
		if(user.getUsername()!=null&&!user.getUsername().equals("")){
			hql = "select count(*) from User u where u.username like '%"+user.getUsername()+"%' and u.level!=0";;
		}else{
			hql = "select count(*) from User u where u.level!=0";
		}

		List<Long> list=(List<Long>) temp.find(hql);
		if(list!=null&&list.size()>0){
			return list.get(0).longValue();
		}
		return null;
	}

	//按照条件查询用户列表
	@Transactional(readOnly=true)
	@Override
	public List<User> listItemsByPage(final Page page,final User user) {
		List<User> list = (List<User>) temp.execute(new HibernateCallback() {
			public Object doInHibernate(Session session){
				final String hql;
				if(user.getUsername()!=null&&!user.getUsername().equals("")){
					hql = "from User u where u.username like '%"+user.getUsername()+"%' and u.level!=0";;
				}else{
					hql = "from User u where u.level!=0";
				}
				Query query = session.createQuery(hql);
				query.setFirstResult(page.getOffset());
				query.setMaxResults(page.getRow());
				List<User> list = query.list();
				return list;
			}
		});
		if (list.size() > 0){
			return list;
		}
		return null;
	}

	//根据用户id查找用户
	@Override
	public User selectUserById(String id) {
		String hql = "from User where id="+id;
		List<User> list = (List<User>) temp.find(hql);
		if (list.size() > 0){
			return list.get(0);
		}
		return null;
	}

	//批量删除用户,更新level字段
	@Override
	public void update(String id) {
		User user = temp.get(User.class,id);
		user.setLevel(0);
		temp.update(user);
	}

	@Override
	public User getUserByEmail(String email) {
		String hql = "from User where email='"+email+"'";
		List<User> list = (List<User>) temp.find(hql);
		if (list.size() > 0){
			return list.get(0);
		}
		return null;
	}


}
