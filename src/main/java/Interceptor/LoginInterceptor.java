package Interceptor;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;
import pojo.po.User;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.List;

public class LoginInterceptor implements HandlerInterceptor {


    public List<String> getIncludeUrl() {
        return includeUrl;
    }

    public void setIncludeUrl(List<String> includeUrl) {
        this.includeUrl = includeUrl;
    }

    private List<String> includeUrl;

    @Override
    public void afterCompletion(HttpServletRequest request,
                                HttpServletResponse response, Object obj, Exception ex)
            throws Exception {
    }

    @Override
    public void postHandle(HttpServletRequest request,
                           HttpServletResponse response, Object obj, ModelAndView modelAndView)
            throws Exception {
    }


    @Override
    public boolean preHandle(HttpServletRequest request,
                             HttpServletResponse response, Object handler) throws Exception {
        String requestUri = request.getRequestURI();
        for (String url : includeUrl) {
            if (requestUri.contains(url)) {
                HttpSession session = request.getSession();
                User userInfo = (User) session.getAttribute("userInfo");
                if (null == userInfo) {
                    response.sendRedirect(request.getContextPath() + "/ManagerLogin");
                    return false;
                }
            }
        }

//        HttpSession session = request.getSession();
//        User userInfo = (User) session.getAttribute("userInfo");
//        if (null == userInfo) {
//            response.sendRedirect(request.getContextPath() + "/login");
//            return false;
//        }
        return true;
    }
}
