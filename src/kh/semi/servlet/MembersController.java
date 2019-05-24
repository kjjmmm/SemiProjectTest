package kh.semi.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kh.semi.dao.MemberDAO;
import kh.semi.dto.MemberDTO;

@WebServlet("*.members")
public class MembersController extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setCharacterEncoding("UTF-8");
		request.setCharacterEncoding("UTF-8");

		PrintWriter printWriter = response.getWriter();

		String reqUri = request.getRequestURI();
		String ctxPath = request.getContextPath();
		String cmd = reqUri.substring(ctxPath.length());

		System.out.println(cmd);

		MemberDAO dao = new MemberDAO();

		if(cmd.equals("/Main.members")) {
			request.getRequestDispatcher("main.jsp").forward(request, response);
		}
		else if(cmd.equals("/JoinForm.members")) {
			request.getRequestDispatcher("/WEB-INF/basics/joinForm.jsp").forward(request, response);
		}
		else if(cmd.equals("/EmailDuplCheck.members")) {
			String email = request.getParameter("email");
			try {
				boolean result = dao.emailDuplCheck(email);
				printWriter.print(result);
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
		else if(cmd.equals("/SendMail.members")) {
			String email = request.getParameter("email");
			try {
				int ranNum = dao.sendMail(email);
				printWriter.print(ranNum);
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
		else if(cmd.equals("/Join.members")) {
			String email = request.getParameter("email");
			String pw = request.getParameter("pw");
			String name = request.getParameter("name");
			String phone = request.getParameter("phone");
			String zipCode = request.getParameter("zip");
			String address1 = request.getParameter("address1");
			String address2 = request.getParameter("address2");

			MemberDTO dto = new MemberDTO(email, pw, name, phone, zipCode, address1, address2, null, request.getRemoteAddr(), "n");
			try {
				int result = dao.insertMember(dto);
				request.setAttribute("result", result);
				request.getRequestDispatcher("/WEB-INF/basics/alertJoin.jsp").forward(request, response);
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
		else if(cmd.equals("/LoginForm.members")) {
			request.getRequestDispatcher("/WEB-INF/basics/loginForm.jsp").forward(request, response);
		}
		else if(cmd.equals("/Login.members")) {
			String email = request.getParameter("email");
			String pw = request.getParameter("pw");

			try {
				boolean result = dao.isLoginOk(email, pw);
				if(result) {
					request.getSession().setAttribute("loginEmail", email);
				}
				request.setAttribute("result", result);
				request.getRequestDispatcher("/WEB-INF/basics/alertLogin.jsp").forward(request, response);
			}catch(Exception e) {
				e.printStackTrace();
			}
		}else if(cmd.equals("/LoginForm.members")) {
			request.getRequestDispatcher("/WEB-INF/basics/loginForm.jsp");
		}
		else if(cmd.equals("/Logout.members")) {
			request.getSession().invalidate();
			request.getRequestDispatcher("/WEB-INF/basics/alertLogout.jsp").forward(request, response);

		}
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
