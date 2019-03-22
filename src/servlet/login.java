package servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import entiy.people;

@WebServlet("/login")
public class login extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public login() {
		super();
		// TODO Auto-generated constructor stub
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String no = request.getParameter("no");
		String password = request.getParameter("password");
		String identity = request.getParameter("identity");
		String remember = request.getParameter("remember");
		if (remember == null) {
			remember = "未记住密码";
		}
		if (remember.equals("记住密码")) {
			Cookie cookie_no = new Cookie("no", no);
			Cookie cookie_password = new Cookie("password", password);
			cookie_no.setMaxAge(60 * 60);
			cookie_password.setMaxAge(60 * 60);
			response.addCookie(cookie_no);
			response.addCookie(cookie_password);
		} else {
			Cookie[] cook = request.getCookies();
			for (int i = 0; i < cook.length; i++) {
				if (cook[i].getName().equals("no")) {
					System.out.println("no");
					cook[i].setMaxAge(0);
					response.addCookie(cook[i]);
				}
				if (cook[i].getName().equals("password") ) {
					System.out.println("password");
					cook[i].setMaxAge(0);
					response.addCookie(cook[i]);
				}
			}
		}
		String error = null;
		if (no == "") {
			error = "账号不能为空";
		} else if (password == "") {
			error = "密码不能为空";
		} else if (identity.equals("请选择身份")) {
			error = "请选择身份";
		} else {
			Connection con = null;
			PreparedStatement pst = null;
			ResultSet rs = null;
			con = util.DBUtil.getConnection();
			String sql = "select * from peopleinfo where No=?";
			try {
				pst = con.prepareStatement(sql);
				pst.setString(1, no);
				rs = pst.executeQuery();
				while (rs.next()) {
					if (password.equals(rs.getString("Password"))) {
						people p=new people();
						p.setNo(no);
						p.setName(rs.getString("name"));
						p.setLocation(rs.getString("location"));
						p.setIdentity(identity);
						if (identity.equals(rs.getString("Identity"))) {
							if (identity.equals("学生")) {
								
								
								request.getSession().setAttribute("people", p);
								request.getRequestDispatcher("student.jsp").forward(request, response);
								break;
							} else if (identity.equals("餐厅人员")) {
								request.getSession().setAttribute("people", p);
								request.getRequestDispatcher("mealpeople.jsp").forward(request, response);
								break;
							}
						}
						error = "身份选择错误！";
						break;
					}
					error = "密码不正确！";

				}
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		if (error != null) {
			request.setAttribute("error", error);
			request.getRequestDispatcher("login.jsp").forward(request, response);

		}
	}
}
