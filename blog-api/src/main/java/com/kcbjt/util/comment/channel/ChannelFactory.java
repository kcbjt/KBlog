package com.kcbjt.util.comment.channel;

import com.kcbjt.constant.CommentConstants;
import com.kcbjt.util.common.SpringContextUtils;

/**
 * 评论提醒方式
 *
 * @Author: kcbjt
 * @Date: 2026-04-15
 */
public class ChannelFactory {
	/**
	 * 创建评论提醒方式
	 *
	 * @param channelName 方式名称
	 * @return
	 */
	public static CommentNotifyChannel getChannel(String channelName) {
		if (CommentConstants.TELEGRAM.equalsIgnoreCase(channelName)) {
			return SpringContextUtils.getBean("telegramChannel", CommentNotifyChannel.class);
		} else if (CommentConstants.MAIL.equalsIgnoreCase(channelName)) {
			return SpringContextUtils.getBean("mailChannel", CommentNotifyChannel.class);
		}
		throw new RuntimeException("Unsupported value in [application.properties]: [comment.notify.channel]");
	}
}
