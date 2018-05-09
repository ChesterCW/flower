package service.impl;

import dao.IHotDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import pojo.po.Hot;
import service.HotService;
import util.IDUtils;

import java.util.List;
import java.util.Map;

@Service
@Transactional(isolation= Isolation.READ_COMMITTED,propagation= Propagation.REQUIRED)
public class HotServiceImpl implements HotService {
    @Autowired
    IHotDao hotDao;
    @Override
    public Integer addHotCommodity(List<Map<String, Object>> list) {
        for (int i = 0; i < list.size(); i++){
            Hot hot;
            hot = hotDao.selectByCommId((String)list.get(i).get("id"));
            if (hot != null){
                Object object = list.get(i).get("count");
                Long count = Long.parseLong(object.toString()) + hot.getCount();
                hot.setCount(count);
                hotDao.update(hot);
            }else {
                hot = new Hot();
                String id = (String) list.get(i).get("id");

                Long count = Long.parseLong(list.get(i).get("count").toString());
                hot.setId(IDUtils.getItemId()+"");
                hot.setCommId(id);
                hot.setCount(count);
                hotDao.addHotCommodity(hot);
            }
        }
        return 0;
    }

    @Override
    public List<Map<String, Object>> getHotList() {
        return hotDao.selectAll();
    }
}
