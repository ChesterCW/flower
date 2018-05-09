package dao;

import java.util.List;

import pojo.dto.Page;
import pojo.po.User;
public interface IUserDao {
	boolean insert(User user) throws Exception;
	
	void delete(User user) throws Exception;
	
	boolean update(User user) throws Exception;

	User selectByUsername(User user) throws Exception;

	Long countItemsByCondition(Page page,User user);

	List<User> listItemsByPage(Page page,User user);

    User selectUserById(String id);

    void update(String s);

    User getUserByEmail(String email);
}
