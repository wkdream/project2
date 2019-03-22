package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;




@WebServlet("/alertinfo")
public class alertinfo extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
    public alertinfo() {
        super();
        // TODO Auto-generated constructor stub
    }
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String no=request.getParameter("newno");
		String name=request.getParameter("newname");
		String identity=request.getParameter("newidentity");
		String phoneno=request.getParameter("newphoneno");
		String location=request.getParameter("newlocation");
		PrintWriter PrintWriter = response.getWriter();
		String jg=xiugai(no,name,identity,phoneno,location);
		PrintWriter.print(jg);
	}
	private String xiugai(String no, String name, String identity,String phoneno,String location) {
		Connection conn = null;
		PreparedStatement ps = null;
		String sql ="update peopleinfo set Name=?,Identity=?,Phoneno=?,Location=? where No=?";
		conn = util.DBUtil.getConnection();
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, name);
			ps.setString(2, identity);
			ps.setString(3, phoneno);
			ps.setString(4, location);
			ps.setString(5, no);
			ps.executeUpdate();
			util.DBUtil.closeConnection(conn, ps, null);
			return "alertsuccess";
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "shibai";
	}

}
