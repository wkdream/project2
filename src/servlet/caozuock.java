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


@WebServlet("/caozuock")
public class caozuock extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public caozuock() {
        super();
        // TODO Auto-generated constructor stub
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	String newck=	request.getParameter("newck");
	String flag=	request.getParameter("flag");
	PrintWriter PrintWriter = response.getWriter();
	if(flag.equals("addck")){
		String jg=addack(newck);
		PrintWriter.print(jg);
	}else if(flag.equals("delete")){
		String jg=deleteck(newck);
		PrintWriter.print(jg);
	}
	
}
	private String addack(String newck) {
		Connection conn = null;
		PreparedStatement ps = null;
		int ck=Integer.parseInt(newck);
		String nck="窗口"+String.valueOf(ck);
		System.out.println(nck);
		String sql ="insert into ck (Window) values(?)";
		conn = util.DBUtil.getConnection();
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, nck);
			ps.executeUpdate();
			util.DBUtil.closeConnection(conn, ps, null);
			return "success";
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "shibai";
	}
	private String deleteck(String newck) {
		Connection conn = null;
		PreparedStatement ps = null;
		String sql ="delete from ck where Window=?";
		conn = util.DBUtil.getConnection();
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, newck);
			ps.executeUpdate();
			util.DBUtil.closeConnection(conn, ps, null);
			return "success";
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "shibai";
	}

}
