package service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import dao.IMaterialsDao;
import pojo.dto.Page;
import pojo.dto.Result;
import pojo.po.Materials;
import pojo.po.User;
import service.MateService;
import util.IDUtils;

@Service
@Transactional(isolation=Isolation.READ_COMMITTED,propagation=Propagation.REQUIRED)
public class MateServiceImpl implements MateService {

	@Autowired
	IMaterialsDao materialsDao;
	
	@Override
	public List<Materials> findMateByKindId(String kindId) {
		return materialsDao.selectMateByKindId(kindId);
	}

	@Override
	public Result<Materials> listByPages(Page pages, Materials materials) {
		Result<Materials> result = new Result<>();
		try {
			//构建一个Map用来传递参数给DAO
			Long total = materialsDao.countItemsByCondition(pages,materials);
			List<Materials> list = materialsDao.listItemsByPage(pages,materials);
			//商品总数
			result.setTotal(total);
			//指定页码的商品集合
			result.setRows(list);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public Materials getMaterialById(String id) {
		return materialsDao.selectMaterialById(id);
	}

	@Override
	public int modifyMaterials(Materials materials) {
		materials.setStatus(1);
		return materialsDao.update(materials);
	}

	@Override
	public int deleteMaterial(List<String> ids) {
		return materialsDao.batchUpdate(ids);
	}

	@Override
	public boolean addMaterial(Materials materials) {
		materials.setId(IDUtils.getItemId()+"");
		materials.setStatus(1);
		return materialsDao.insert(materials);
	}

	@Override
	public List<Materials> getAllUse() {
		return materialsDao.selectAll();
	}

	//根据材料Id查询商品
	@Override
	public Result<Map<String, Object>> getCommodityByMateId(String mateId, Page page) {
		Result<Map<String, Object>> result = new Result<>();
		try {
			//构建一个Map用来传递参数给DAO
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("page", page);
			map.put("mateId", mateId);

			Long total = materialsDao.countItemsByMateId(map);
			List<Map<String, Object>> list = materialsDao.listItemsByMateId(map);
			//商品总数
			result.setTotal(total);
			//指定页码的商品集合
			result.setRows(list);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

}
