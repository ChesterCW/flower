package service;

import pojo.po.Receiver;

import java.util.List;

public interface ReceiverService {
    List<Receiver> getReceiverByUserId(String userId);

    Integer addReceiver(Receiver receiver);

    Integer updateReceiver(Receiver receiver);

    Receiver getReceiverById(String id);

    boolean modifyStatus(String s, String userId);

    boolean deleteReceiver(String id);
}
