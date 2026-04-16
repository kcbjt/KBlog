package com.kcbjt.service;

import com.kcbjt.model.dto.Friend;
import com.kcbjt.model.vo.FriendInfo;

import java.util.List;

public interface FriendService {
	List<com.kcbjt.entity.Friend> getFriendList();

	List<com.kcbjt.model.vo.Friend> getFriendVOList();

	void updateFriendPublishedById(Long friendId, Boolean published);

	void saveFriend(com.kcbjt.entity.Friend friend);

	void updateFriend(Friend friend);

	void deleteFriend(Long id);

	void updateViewsByNickname(String nickname);

	FriendInfo getFriendInfo(boolean cache, boolean md);

	void updateFriendInfoContent(String content);

	void updateFriendInfoCommentEnabled(Boolean commentEnabled);
}
