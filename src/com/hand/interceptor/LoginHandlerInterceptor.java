package com.hand.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import com.hand.entity.system.User;
import com.hand.util.Const;
import com.hand.util.Jurisdiction;

/**
 * 
 * 类名称：登录过滤，权限验证 类描述： 创建人：HAND 赵帮恩 创建时间：2017年6月15日
 * 
 * @version 1.6
 */
public class LoginHandlerInterceptor extends HandlerInterceptorAdapter {

	@Override
	public boolean preHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler) throws Exception {
		String path = request.getServletPath();
		if (path.matches(Const.NO_INTERCEPTOR_PATH)) {
			return true;
		} else {
			User user = (User) Jurisdiction.getSession().getAttribute(
					Const.SESSION_USER);
			if (user != null) {
				path = path.substring(1, path.length());
				boolean b = Jurisdiction.hasJurisdiction(path); // 访问权限校验
				if (!b) {
					response.sendRedirect(request.getContextPath()
							+ Const.LOGIN);
				}
				return b;
			} else {
				// 登陆过滤
				response.sendRedirect(request.getContextPath() + Const.LOGIN);
				return false;
			}
		}
	}

}
