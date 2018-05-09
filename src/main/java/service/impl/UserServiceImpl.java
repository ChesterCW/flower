package service.impl;

import dao.IUserDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import pojo.dto.Order;
import pojo.dto.Page;
import pojo.dto.Result;
import pojo.po.User;
import service.UserService;
import util.IDUtils;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@Transactional
public class UserServiceImpl implements UserService {

    @Autowired
    IUserDao userDao;

    @Override
    public int batchUpdate(List<String> ids) {
        int record = 0;
        try {
            for (int i = 0; i < ids.size(); i++) {
                userDao.update(ids.get(i));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return record;
    }

    @Override
    public User getById(String id) {
        return userDao.selectUserById(id);
    }

    //查询用户，存在则可以登录
    @Override
    public User login(User user) {
        try {
            User resultUser = userDao.selectByUsername(user);
            if (resultUser != null){
                return resultUser;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public Boolean addUser(User user) {
        boolean flag = false;
        try {
            user.setId(IDUtils.getItemId()+"");
            flag = userDao.insert(user);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return flag;
    }

    //按照条件查询用户列表
    @Override
    public Result<User> listItemsByPage(Page page, User user) {
        Result<User> result = new Result<>();
        try {
            //构建一个Map用来传递参数给DAO
            Long total = userDao.countItemsByCondition(page,user);
            List<User> list = userDao.listItemsByPage(page,user);
            //商品总数
            result.setTotal(total);
            //指定页码的商品集合
            result.setRows(list);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    //修改单个用户
    @Override
    public boolean modifyUser(User user) {
        boolean flag = false;
        try {
            flag = userDao.update(user);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return flag;
    }

    @Override
    public boolean getUserByEmail(String email) {
        User user = userDao.getUserByEmail(email);
        if (user != null){
            return true;
        }
        return false;
    }
}
