package dao;

import pojo.po.Receiver;

import java.util.List;

public interface IReceiverDao {
    List<Receiver> selectByUserId(String userId);

    Integer insert(Receiver receiver);

    Integer update(Receiver receiver);

    Receiver selectById(String id);

    boolean updateByUserId(String userId);

    boolean updateById(String id);

    boolean deleteReceiver(String id);
}
