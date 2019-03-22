package servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/zhuxiao")
public class zhuxiao extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public zhuxiao() {
        super();
        // TODO Auto-generated constructor stub
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String flag = request.getParameter("flag");
		PrintWriter PrintWriter = response.getWriter();
		if(flag.equals("zhuxiao")){//注销账号
			HttpSession se1 = request.getSession();
			se1.invalidate();
			PrintWriter.print("success");
		}
	}

}
