package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.Statement;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.menudao;
import entiy.menu;

@WebServlet("/order")
public class order extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
  
    public order() {
        super();
        // TODO Auto-generated constructor stub
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String check = request.getParameter("check");
		String mealname = request.getParameter("mealname");
		String peoplename = request.getParameter("peoplename");
		String totalprice=request.getParameter("totalprice");
		String caozuo="reduce";
		if(request.getParameter("caozuo")!=null){
			caozuo = request.getParameter("caozuo");
		}
		String quantity = request.getParameter("quantity");
		String price = request.getParameter("price");
		String time = request.getParameter("time");
		PrintWriter PrintWriter = response.getWriter();
		String jg="";
		if(check.equals("xz")&& (! price.equals("0"))){
			jg=xz(mealname,peoplename,time,price);
			PrintWriter.print(jg);
		}else if(check.equals("not")){
			jg=notxz(mealname,peoplename);
			PrintWriter.print(jg);
		}else if(check.equals("queren")){
			jg=queren(totalprice,peoplename);
			PrintWriter.print(jg);
		}else if(check.equals("wancheng")){
			jg=wancheng(peoplename);
			
			PrintWriter.print(jg);
		}else{
			if(caozuo.equals("add")){
				quantity=String.valueOf(Integer.parseInt(quantity)+1);
				price=String.valueOf(Integer.parseInt(price)/(Integer.parseInt(quantity)-1)*Integer.parseInt(quantity));
			}else{
				quantity=String.valueOf(Integer.parseInt(quantity)-1);
				price=String.valueOf(Integer.parseInt(price)/(Integer.parseInt(quantity)+1)*Integer.parseInt(quantity));
				if(price.equals("0")){
					jg=notxz(mealname,peoplename);
					PrintWriter.print(jg);
				}
			}
			jg=caozuo(mealname,peoplename,price,time,quantity);
			PrintWriter.print(jg);
		}
		
	}
	private String wancheng(String peopelname) {
		// TODO Auto-generated method stub
		List<menu>	list=new menudao().getallbystuname(peopelname);
		for(int i=0;i<list.size();i++){
			menu m=list.get(i);
			String window=new menudao().getwindowbymealname(m.getMealname());
			String totalprice=m.getPrice();
			String mealname=m.getMealname();
			String quantity=m.getQuantity();
			Connection conn = null;
			PreparedStatement ps = null;
			String sql ="insert into t_bill (Window,Mealname,Quantity,Totalprice) values(?,?,?,?)";
			conn = util.DBUtil.getConnection();
			try {
				ps = conn.prepareStatement(sql);
				ps.setString(1, window);
				ps.setString(2, mealname);
				ps.setString(3, quantity);
				ps.setString(4, totalprice);
				ps.executeUpdate();
				zhizuowancheng(peopelname);
				util.DBUtil.closeConnection(conn, ps, null);
				
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				return "shibai";
			}
		}
		return "success";
	}


	private String queren(String totalprice, String peoplename) {
		Connection conn = null;
		PreparedStatement ps = null;
		String sql ="update t_order set Stutotalprice=? where Stuname=?";
		conn = util.DBUtil.getConnection();
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, totalprice);
			ps.setString(2, peoplename);
			ps.executeUpdate();
			util.DBUtil.closeConnection(conn, ps, null);
			return "success";
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "shibai";
	}


	private String xz(String mealname, String peoplename, String time,String price) {
		Connection conn = null;
		PreparedStatement ps = null;
		String sql ="insert into t_order (Mealname,Stuname,Time,Price,Quantity) values(?,?,?,?,?)";
		conn = util.DBUtil.getConnection();
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, mealname);
			ps.setString(2, peoplename);
			ps.setString(3, time);
			ps.setString(4, price);
			ps.setString(5, "1");
			ps.executeUpdate();
			util.DBUtil.closeConnection(conn, ps, null);
			return "insertsuccess";
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "shibai";
	}
	private String notxz(String mealname, String peoplename) {
		Connection conn = null;
		PreparedStatement ps = null;
		String sql = "DELETE from t_order WHERE Mealname=? and Stuname=?";
		conn = util.DBUtil.getConnection();
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, mealname);
			ps.setString(2, peoplename);
			ps.executeUpdate();
			util.DBUtil.closeConnection(conn, ps, null);
			return "delectsuccess";
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "shibai";
	}
	private String caozuo(String mealname, String peoplename, String price,String time,String quantity) {
		Connection conn = null;
		PreparedStatement ps = null;
		String sql ="update t_order set Time=?,Price=?,Quantity=? where Mealname=? and Stuname=?";
		conn = util.DBUtil.getConnection();
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, time);
			ps.setString(2, price);
			ps.setString(3, quantity);
			ps.setString(4, mealname);
			ps.setString(5, peoplename);
			ps.executeUpdate();
			util.DBUtil.closeConnection(conn, ps, null);
			return "success";
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "shibai";
	}
	private void zhizuowancheng(String peoplename) {
		Connection conn = null;
		PreparedStatement ps = null;
		String sql = "DELETE from t_order WHERE Stuname=?";
		conn = util.DBUtil.getConnection();
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, peoplename);
			ps.executeUpdate();
			util.DBUtil.closeConnection(conn, ps, null);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
}
