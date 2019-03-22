package servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/register")
public class register extends HttpServlet {
	private static final long serialVersionUID = 1L;
 
    public register() {
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
		String name=request.getParameter("name");
		String identity=request.getParameter("identity");
		String phoneno=request.getParameter("phoneno");
		String location=request.getParameter("location");
		String error=null;
		if(no==""){
			error="账号不能为空";
		}else if(password==""){
			error="密码不能为空";
		}else if(name==""){
			error="姓名不能为空";
		}else if(identity.equals("请选择身份")){
			error="请选择身份";
		}else if(phoneno==""){
			error="联系方式不能为空";
		}else if(location==""){
			error="地址不能为空";
		}else{
			Connection con=null;
			PreparedStatement pst=null;
			ResultSet rs=null;
			con=util.DBUtil.getConnection();
			String sql="select No from peopleinfo where No=?";
			try {
				pst=con.prepareStatement(sql);
				pst.setString(1, no);
				rs=pst.executeQuery();
				if(!rs.next()){
					util.DBUtil.closeConnection(con, pst, rs);
					Connection con1=null;
					PreparedStatement pst1=null;
					con1=util.DBUtil.getConnection();
					String sql1="insert into peopleinfo(No,Password,Name,Identity,Phoneno,Location) values(?,?,?,?,?,?)";
					pst1=con1.prepareStatement(sql1);
					pst1.setString(1, no);
					pst1.setString(2, password);
					pst1.setString(3, name);
					pst1.setString(4, identity);
					pst1.setString(5, phoneno);
					pst1.setString(6, location);
					pst1.executeUpdate();
					util.DBUtil.closeConnection(con1, pst1, null);
					request.getRequestDispatcher("login.jsp").forward(request, response);
				}else{
					error="该账号已存在，请重新输入";
				}	
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				error="系统异常！请稍后再试！！！";
			}
	
		}if(error!=null){
			request.setAttribute("error", error);
			request.getRequestDispatcher("register.jsp").forward(request, response);
			
		}
	}

}
