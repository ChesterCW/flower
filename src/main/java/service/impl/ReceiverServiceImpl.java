package service.impl;

import dao.IReceiverDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import pojo.po.Receiver;
import service.ReceiverService;
import util.IDUtils;

import java.util.List;


@Service
@Transactional(isolation= Isolation.READ_COMMITTED,propagation= Propagation.REQUIRED)
public class ReceiverServiceImpl implements ReceiverService {
    @Autowired
    IReceiverDao receiverDao;

    @Override
    public List<Receiver> getReceiverByUserId(String userId) {
        return receiverDao.selectByUserId(userId);
    }

    @Override
    public Integer addReceiver(Receiver receiver) {
        receiver.setId(IDUtils.getItemId()+"");
        receiver.setStatus(2);
        receiverDao.insert(receiver);
        return null;
    }

    @Override
    public Integer updateReceiver(Receiver receiver) {
        receiver.setStatus(2);
        receiverDao.update(receiver);
        return null;
    }

    @Override
    public Receiver getReceiverById(String id) {
        return receiverDao.selectById(id);
    }

    @Override
    public boolean modifyStatus(String id, String userId) {
        //先设置用户收货地址都不是默认
        receiverDao.updateByUserId(userId);
        //设置指定id地址为默认
        receiverDao.updateById(id);
        return true;
    }

    @Override
    public boolean deleteReceiver(String id) {
        receiverDao.deleteReceiver(id);
        return true;
    }
}
