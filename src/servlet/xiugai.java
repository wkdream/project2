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


@WebServlet("/xiugai")
public class xiugai extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public xiugai() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String flag=request.getParameter("flag");
		String newmealname=request.getParameter("newmealname");
		String oldmealname=request.getParameter("oldmealname");
		String newprice=request.getParameter("newprice");
		String newwindow=request.getParameter("newwindow");
		String newtroduction=request.getParameter("newtroduction");
		String newfile=request.getParameter("newfile");
		PrintWriter PrintWriter = response.getWriter();
		String jg="";
		if(flag.equals("xiugaimeal")){
			jg=xiugaimeal(newmealname,newprice,newwindow,newtroduction,oldmealname);
		}else if(flag.equals("addmeal")){
			jg=addmeal(newmealname,newprice,newwindow,newtroduction,newfile);
		}else if(flag.equals("delectmeal")){
			jg=delectmeal(newmealname);
		}
		
		PrintWriter.print(jg);
	}
	private String xiugaimeal(String newmealname, String newprice, String newwindow,String newtroduction,String oldmealname) {
		Connection conn = null;
		PreparedStatement ps = null;
		String sql ="update menu set Mealname=?,Window=?,Price=?,Mealtroduction=? where Mealname=?";
		conn = util.DBUtil.getConnection();
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, newmealname);
			ps.setString(2, newwindow);
			ps.setString(3, newprice);
			ps.setString(4, newtroduction);
			ps.setString(5, oldmealname);
			ps.executeUpdate();
			util.DBUtil.closeConnection(conn, ps, null);
			return "alertsuccess";
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "shibai";
	}
	private String addmeal(String newmealname, String newprice, String newwindow,String newtroduction,String newfile) {
		Connection conn = null;
		PreparedStatement ps = null;
		String sql ="insert into menu(Mealname,Window,Price,Mealtroduction,Tupian) values(?,?,?,?,?)";
		conn = util.DBUtil.getConnection();
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, newmealname);
			ps.setString(2, newwindow);
			ps.setString(3, newprice);
			ps.setString(4, newtroduction);
			ps.setString(5, newfile);
			ps.executeUpdate();
			util.DBUtil.closeConnection(conn, ps, null);
			return "addsuccess";
		} catch (Exception e) {
			// TODO Auto-generated catch block
			
		}
		return "shibai";
	}
	private String delectmeal(String newmealname) {
		Connection conn = null;
		PreparedStatement ps = null;
		String sql ="DELETE from  menu where Mealname=?";
		conn = util.DBUtil.getConnection();
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, newmealname);
			ps.executeUpdate();
			util.DBUtil.closeConnection(conn, ps, null);
			return "delectsuccess";
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "shibai";
	}
}