package service.impl;

import dao.IUseDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import pojo.dto.Page;
import pojo.dto.Result;
import pojo.po.Materials;
import pojo.po.Use;
import service.UseService;
import util.IDUtils;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class UseServiceImpl implements UseService {
    @Autowired
    IUseDao useDao;

    @Override
    public List<Use> getAllUse() {
        return useDao.getAllUse();
    }

    @Override
    public Result<Use> listByPages(Page pages, Use use) {
        Result<Use> result = new Result<>();
        try {
            //构建一个Map用来传递参数给DAO
            Long total = useDao.countItemsByCondition(pages,use);
            List<Use> list = useDao.listItemsByPage(pages,use);
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
    public Use getUseById(String id) {
        return useDao.selectUseById(id);
    }

    @Override
    public int modifyUse(Use use) {
        use.setStatus(1);
        return useDao.update(use);
    }

    @Override
    public int deleteUse(List<String> ids) {
        return useDao.batchUpdate(ids);
    }

    @Override
    public boolean addUse(Use use) {
        use.setStatus(1);
        use.setId(IDUtils.getItemId()+"");

        return useDao.insert(use);
    }

    //根据用途Id查询商品
    @Override
    public Result<Map<String, Object>> getCommodityByUseId(String useId, Page page) {
        Result<Map<String, Object>> result = new Result<>();
        try {
            //构建一个Map用来传递参数给DAO
            Map<String, Object> map = new HashMap<String, Object>();
            map.put("page", page);
            map.put("useId", useId);

            Long total = useDao.countItemsByUseId(map);
            List<Map<String, Object>> list = useDao.listItemsByUseId(map);
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
