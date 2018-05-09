package service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import dao.ICategoryDao;
import dao.ICommodityDao;
import pojo.po.Category;
import service.CateService;
import util.IDUtils;

@Service
@Transactional(isolation=Isolation.READ_COMMITTED,propagation=Propagation.REQUIRED)
public class CateServiceImpl implements CateService {

	@Autowired
	ICategoryDao categoryDao;

	@Override
	public List<Category> findCateByKindId(String id) {
		return categoryDao.selectCateByKindId(id);
	}

	@Override
	public boolean addCategory(Category category) {
		category.setId(IDUtils.getItemId()+"");
		category.setStatus(1);
		categoryDao.insert(category);
		return false;
	}

	@Override
	public Category getCategoryById(String id) {
		return categoryDao.selectCateById(id);
	}

	@Override
	public int modifyCategory(Category category) {
		category.setStatus(1);
		return categoryDao.update(category);
	}

	@Override
	public int deleteCategory(List<String> ids) {
		return categoryDao.batchUpdate(ids);
	}

	@Override
	public List<Category> getAllUse() {
		return categoryDao.selectAll();
	}

}
