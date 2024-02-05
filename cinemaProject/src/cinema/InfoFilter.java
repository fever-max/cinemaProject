package cinema;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@WebFilter("/*")
public class InfoFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpSession session = httpRequest.getSession();
        CustomInfo customInfo = (CustomInfo) session.getAttribute("customInfo");

        if (customInfo == null) {
            request.setAttribute("me", "�α���");
        } else {
            request.setAttribute("me", "�α׾ƿ�");
        }

        chain.doFilter(request, response);
    }

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // �ʿ��� ��� �ʱ�ȭ �ڵ� �ۼ�
    }

    @Override
    public void destroy() {
        // ���Ͱ� �Ҹ�� �� ȣ��Ǵ� �޼���
    }
}
