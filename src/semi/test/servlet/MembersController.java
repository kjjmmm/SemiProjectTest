package semi.test.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/MembersController")
public class MembersController extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String reqUri = request.getRequestURI();
		String ctxPath = request.getContextPath();
		String cmd = reqUri.substring(ctxPath.length());
		
		System.out.println(cmd);
		
		
		
		if(cmd.equals("/Join.members")) {
			String name = request.getParameter("name");
			String email = request.getParameter("email");
			String pw = request.getParameter("pw");
			String phone = request.getParameter("phone");
			String zipcode = request.getParameter("zip");
			String address1 = request.getParameter("address1");
			String address2 = request.getParameter("address2");
			
			
			
		}
	}
protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
