package service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import dao.IUserDao;
import pojo.dto.Order;
import pojo.dto.Page;
import pojo.dto.Result;
import pojo.po.User;

public interface UserService {

	int batchUpdate(List<String> ids);

	User getById(String id);

	User login(User user);

	Boolean addUser(User user);

    Result<User> listItemsByPage(Page page,User user);

    boolean modifyUser(User user);

    boolean getUserByEmail(String email);
}