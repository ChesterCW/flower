package service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import dao.ICommodityDao;
import dao.IKindDao;
import pojo.dto.Page;
import pojo.dto.Result;
import pojo.po.Commodity;
import pojo.po.Kind;
import pojo.po.Materials;
import service.KindService;
import util.IDUtils;

@Service
@Transactional(isolation=Isolation.READ_COMMITTED,propagation=Propagation.REQUIRED)
public class KindServiceImpl implements KindService {
	@Autowired
	IKindDao kindDao;

	@Override
	public List<Kind> getAll() {
		try{
			return kindDao.selectAll();
		}catch(Exception e){
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public Result<Kind> listByPages(Page pages, Kind kind) {
		Result<Kind> result = new Result<>();
		try {
			//构建一个Map用来传递参数给DAO
			Long total = kindDao.countItemsByCondition(pages,kind);
			List<Kind> list = kindDao.listItemsByPage(pages,kind);
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
	public boolean addKind(Kind kind) {
		kind.setId(IDUtils.getItemId()+"");
		kind.setStatus(1);
		return kindDao.insert(kind);
	}

	@Override
	public int deleteKind(List<String> ids) {
		return kindDao.batchUpdate(ids);
	}

}
