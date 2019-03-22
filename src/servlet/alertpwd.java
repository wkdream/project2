package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/alertpwd")
public class alertpwd extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
    public alertpwd() {
        super();
        // TODO Auto-generated constructor stub
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String no=request.getParameter("no");
		String password=request.getParameter("password");
		String newpassword=request.getParameter("newpassword");
		PrintWriter PrintWriter = response.getWriter();
		String jg=xiugai(no,password,newpassword);
		PrintWriter.print(jg);
	}
	private String xiugai(String no, String password, String newpassword) {
		Connection conn = null;
		PreparedStatement ps = null;
		String sql2 = "SELECT * FROM peopleinfo";
		String sql ="update peopleinfo set Password=? where No=?";
		conn = util.DBUtil.getConnection();
		try {
			ps=conn.prepareStatement(sql2);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				String no1 = rs.getString("no");
				if (no1.equals(no)) {
					String s=rs.getString("password");
					if(s.equals(password)){
						ps=conn.prepareStatement(sql);
						ps.setString(1, newpassword);
						ps.setString(2, no);
						ps.executeUpdate();
						return "success";
					}else{
						return "error";
					}
				}
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "shibai";
	}


}
