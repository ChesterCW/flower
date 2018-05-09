package service.impl;

import dao.IColorDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import pojo.dto.Page;
import pojo.dto.Result;
import pojo.po.Color;
import pojo.po.Materials;
import service.ColorService;
import util.IDUtils;

import java.util.List;
@Service
@Transactional(isolation= Isolation.READ_COMMITTED,propagation= Propagation.REQUIRED)
public class ColorServiceImpl implements ColorService {
    @Autowired
    IColorDao colorDao;

    @Override
    public List<Color> getAll() {
        return colorDao.selectAll();
    }

    @Override
    public Result<Color> listByPages(Page pages, Color color) {
        Result<Color> result = new Result<>();
        try {
            //构建一个Map用来传递参数给DAO
            Long total = colorDao.countItemsByCondition(pages,color);
            List<Color> list = colorDao.listItemsByPage(pages,color);
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
    public boolean addColor(Color color) {
        color.setId(IDUtils.getItemId()+"");
        color.setStatus(1);
        return colorDao.insert(color);
    }

    @Override
    public int deleteColor(List<String> ids) {
        return colorDao.batchUpdate(ids);
    }
}
