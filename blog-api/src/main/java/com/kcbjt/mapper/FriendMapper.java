package com.kcbjt.mapper;

import com.kcbjt.model.dto.Friend;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @Description: 友链持久层接口
 * @Author: kcbjt
 * @Date: 2026-04-15
 */
@Mapper
@Repository
public interface FriendMapper {
	List<com.kcbjt.entity.Friend> getFriendList();

	List<com.kcbjt.model.vo.Friend> getFriendVOList();

	int updateFriendPublishedById(Long id, Boolean published);

	int saveFriend(com.kcbjt.entity.Friend friend);

	int updateFriend(Friend friend);

	int deleteFriend(Long id);

	int updateViewsByNickname(String nickname);
}
