package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import entiy.menu;

public class menudao {
	public List<menu> getallbywindow(String window) {
		List<menu> list=new ArrayList<>();
		Connection conn=null;
		PreparedStatement ps=null;
		ResultSet rs=null;
		String sql="select * from menu where Window=?";
		try {
			conn=util.DBUtil.getConnection();
			ps=conn.prepareStatement(sql);
			ps.setString(1, window);
			rs=ps.executeQuery();
			while(rs.next()){
				menu m=new menu();
				m.setMealname(rs.getString("Mealname"));
				m.setWindow(window);
				m.setPrice(rs.getString("Price"));
				m.setMealtroduction(rs.getString("Mealtroduction"));
				list.add(m);
			}
			util.DBUtil.closeConnection(conn, ps, rs);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}
	public String getwindowbymealname(String mealname) {
		List<menu> list=new ArrayList<>();
		Connection conn=null;
		PreparedStatement ps=null;
		ResultSet rs=null;
		String window="";
		String sql="select Window from menu where Mealname=?";
		try {
			conn=util.DBUtil.getConnection();
			ps=conn.prepareStatement(sql);
			ps.setString(1, mealname);
			rs=ps.executeQuery();
			while(rs.next()){
				window=rs.getString("Window");
			}
			util.DBUtil.closeConnection(conn, ps, rs);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return window;
	}
	public List<menu> getallbystuname(String name) {
		List<menu> list=new ArrayList<>();
		Connection conn=null;
		PreparedStatement ps=null;
		ResultSet rs=null;
		String sql="select * from t_order where StuName=?";
		try {
			conn=util.DBUtil.getConnection();
			ps=conn.prepareStatement(sql);
			ps.setString(1, name);
			rs=ps.executeQuery();
			while(rs.next()){
				menu m=new menu();
				m.setMealname(rs.getString("Mealname"));
				m.setPrice(rs.getString("Price"));
				m.setQuantity(rs.getString("Quantity"));
				list.add(m);
			}
			util.DBUtil.closeConnection(conn, ps, rs);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}
	public List<menu> getallbymealname(String name) {
		List<menu> list=new ArrayList<>();
		Connection conn=null;
		PreparedStatement ps=null;
		ResultSet rs=null;
		String sql="select * from menu where Mealname=?";
		try {
			conn=util.DBUtil.getConnection();
			ps=conn.prepareStatement(sql);
			ps.setString(1, name);
			rs=ps.executeQuery();
			while(rs.next()){
				menu m=new menu();
				m.setMealname(rs.getString("Mealname"));
				m.setPrice(rs.getString("Price"));
				m.setMealtroduction(rs.getNString("Mealtroduction"));
				m.setWindow(rs.getString("Window"));
				m.setTupian(rs.getString("Tupian"));
				list.add(m);
			}
			util.DBUtil.closeConnection(conn, ps, rs);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}

	public String exist(String mealname, String peoplename) {
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs=null;
		String sql = "select * from t_order WHERE Mealname=? and Stuname=?";
		conn = util.DBUtil.getConnection();
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, mealname);
			ps.setString(2, peoplename);
			rs=ps.executeQuery();
			while(rs.next()){
				return "checked";
			}
			util.DBUtil.closeConnection(conn, ps, null);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "not";
	}
	
	public List<menu> getall() {
		List<menu> list=new ArrayList<>();
		Connection conn=null;
		PreparedStatement ps=null;
		ResultSet rs=null;
		String sql="select * from t_order order by Stuname";
		try {
			conn=util.DBUtil.getConnection();
			ps=conn.prepareStatement(sql);
			rs=ps.executeQuery();
			while(rs.next()){
				menu m=new menu();
				m.setStuname(rs.getString("Stuname"));
				m.setMealname(rs.getString("Mealname"));
				m.setPrice(rs.getString("Price"));
				m.setQuantity(rs.getString("Quantity"));
				m.setStutotalprice(rs.getString("Stutotalprice"));
				list.add(m);
			}
			util.DBUtil.closeConnection(conn, ps, rs);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}
	public List<menu> getallbillbywindow() {
		List<menu> list=new ArrayList<>();
		Connection conn=null;
		PreparedStatement ps=null;
		ResultSet rs=null;
		String sql="select Window,sum(Totalprice) from t_bill group by Window";
		try {
			conn=util.DBUtil.getConnection();
			ps=conn.prepareStatement(sql);
			rs=ps.executeQuery();
			while(rs.next()){
				menu m=new menu();
				m.setWindow(rs.getString("window"));
				m.setPrice(rs.getString("sum(Totalprice)"));
				list.add(m);
			}
			util.DBUtil.closeConnection(conn, ps, rs);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}
	public List<menu> getallbillbymealname() {
		List<menu> list=new ArrayList<>();
		Connection conn=null;
		PreparedStatement ps=null;
		ResultSet rs=null;
		String sql="select Mealname,sum(Quantity),sum(Totalprice) from t_bill group by Mealname";
		try {
			conn=util.DBUtil.getConnection();
			ps=conn.prepareStatement(sql);
			rs=ps.executeQuery();
			while(rs.next()){
				menu m=new menu();
				m.setMealname(rs.getString("Mealname"));
				m.setQuantity(rs.getString("sum(Quantity)"));
				m.setPrice(rs.getString("sum(Totalprice)"));
				list.add(m);
			}
			util.DBUtil.closeConnection(conn, ps, rs);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}
}
