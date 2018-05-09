package service.impl;

import dao.ICommUseDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import pojo.po.CommUse;
import pojo.po.Use;
import service.CommUseService;

import java.util.ArrayList;
import java.util.List;

@Service
public class CommUseServiceImpl implements CommUseService {
    @Autowired
    ICommUseDao commUseDao;

    @Override
    public boolean addCommUse(List<String> commUse, String id) {
        commUseDao.insertCommUse(commUse,id);
        return true;
    }

    @Override
    public List<Use> getUseByCommId(String id) {
        return commUseDao.selectUseByCommId(id);
    }

    @Override
    public Integer deleteByCommId(List<String> ids) {
        for (String id : ids){
            commUseDao.deleteByCommId(id);
        }
        return 0;
    }
}
