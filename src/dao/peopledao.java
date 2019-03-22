package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import entiy.people;

public class peopledao {
	public List<people> getallbyno(String no) {
		List<people> list=new ArrayList<>();
		Connection conn=null;
		PreparedStatement ps=null;
		ResultSet rs=null;
		String sql="select * from peopleinfo where No=?";
		try {
			conn=util.DBUtil.getConnection();
			ps=conn.prepareStatement(sql);
			ps.setString(1, no);
			rs=ps.executeQuery();
			while(rs.next()){
				people p=new people();
				p.setNo(no);
				p.setPassword(rs.getString("Password"));
				p.setName(rs.getString("Name"));
				p.setLocation(rs.getString("Location"));
				p.setPhoneno(rs.getString("Phoneno"));
				p.setIdentity(rs.getString("Identity"));
				list.add(p);
			}
			util.DBUtil.closeConnection(conn, ps, rs);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}
	public String getnobyname(String name) {
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs=null;
		String sql = "select * from peopleinfo where Name=?";
		conn = util.DBUtil.getConnection();
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, name);
			rs=ps.executeQuery();
			while(rs.next()){
				return rs.getString("No");
			}
			util.DBUtil.closeConnection(conn, ps, null);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "not";
	}
}
