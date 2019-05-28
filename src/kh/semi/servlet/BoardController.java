package kh.semi.servlet;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.FileExistsException;

import kh.semi.dao.BoardDAO;
import kh.semi.dto.UfileDTO;


@WebServlet("*.board")
public class BoardController extends HttpServlet {	
	private int fileIdNo = 1;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter pw = response.getWriter();
		String requestURI = request.getRequestURI(); 
		String contextPath = request.getContextPath();

		String cmd = requestURI.substring(contextPath.length());
		BoardDAO dao = new BoardDAO();
		try {
			if(cmd.contentEquals("/write.board")) {
				request.getRequestDispatcher("/WEB-INF/boards/writer.jsp").forward(request, response);
			}else if(cmd.contentEquals("/supportMe.board")) {

				//				String title = request.getParameter("title");
				//				title.replaceAll("<.?script>", "");
				//				int goal_amount = Integer.parseInt(request.getParameter("goal_amount"));
				//				String end = request.getParameter("end_period");
				//				String bank = request.getParameter("bank");
				//				bank.replaceAll("<.?script>", "");
				//				String account = request.getParameter("account");
				//				account.replaceAll("<.?script>", "");

				//----------- receiving main photo attached. multipart/form-data		
				String rootPath = this.getServletContext().getRealPath("/");	
				String filePath = rootPath + "files";	

				File uploadPath = new File(filePath);
				if(!uploadPath.exists()) {
					uploadPath.mkdir();	
				}

				System.out.println(rootPath);

				DiskFileItemFactory diskFactory = new DiskFileItemFactory();		
				diskFactory.setRepository(new File(rootPath + "/WEB-INF/temp"));   

				ServletFileUpload sfu = new ServletFileUpload(diskFactory);
				sfu.setSizeMax(10 * 1024 * 1024); 

				try {
					List<FileItem> items = sfu.parseRequest(request);		
					for(FileItem fi : items) {
						if(fi.getSize()==0) {continue;}

						if(fi.isFormField()) {
							System.out.println(fi.getName());
						
						}else {	
							//	
							UfileDTO dto = new UfileDTO();
							dto.setOriFileName(fi.getName());
							//					dto.setFileName(tempFileName);
							dto.setFileSize(fi.getSize());
							dto.setFilePath(filePath);

							String tempFileName = null;
							while(true) {
								try {
									long tempTime = System.currentTimeMillis();
									tempFileName = tempTime+"_"+fi.getName();
									fi.write(new File(filePath+"/"+tempFileName));
									dto.setFileName(tempFileName);
									break;
								}catch(Exception e) {
									System.out.println("rename file");
								}
							}
							response.setCharacterEncoding("UTF-8");
							response.getWriter().append("files/"+dto.getFileName());
							//							int result = dao.insert(dto);		

							try {
								fi.write(new File(filePath+"/"+tempFileName)); 
							}catch(FileExistsException f) {
								fi.write(new File(filePath+"/"+fileIdNo++ +"_"+tempFileName));
							}
						}
					}
				}catch(Exception e) {
					e.printStackTrace();
					response.sendRedirect("error.jsp");
				}

			}
		}catch(Exception e) {
			e.printStackTrace();
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
