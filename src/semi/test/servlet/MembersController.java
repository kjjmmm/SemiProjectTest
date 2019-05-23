package semi.test.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import semi.test.dao.MemberDAO;
import semi.test.dto.MemberDTO;

@WebServlet("*.members")
public class MembersController extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String reqUri = request.getRequestURI();
		String ctxPath = request.getContextPath();
		String cmd = reqUri.substring(ctxPath.length());
		
		System.out.println(cmd);
		
		MemberDAO dao = new MemberDAO();
		
		if(cmd.equals("/Join.members")) {
			String email = request.getParameter("email");
			String pw = request.getParameter("pw");
			String name = request.getParameter("name");
			String nickname = request.getParameter("nickname");
			String phone = request.getParameter("phone");
			String zipCode = request.getParameter("zip");
			String address1 = request.getParameter("address1");
			String address2 = request.getParameter("address2");
			
			MemberDTO dto = new MemberDTO(email, pw, name, nickname, phone, zipCode, address1, address2, null, request.getRemoteAddr(), "n");
			try {
				int result = dao.insertMember(dto);
				request.setAttribute("result", result);
				request.getRequestDispatcher("join.jsp").forward(request, response);
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
		else if(cmd.equals("/Login.members")) {
			String email = request.getParameter("email");
			String pw = request.getParameter("pw");
			
			try {
				boolean result = dao.isLoginOk(email, pw);
				request.setAttribute("result", result);
				request.getRequestDispatcher("login.jsp").forward(request, response);
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
	}
protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
