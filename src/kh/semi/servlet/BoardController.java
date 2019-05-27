package kh.semi.servlet;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
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
import kh.semi.dto.BoardDTO;
import kh.semi.dto.UfileDTO;


@WebServlet("*.board")
public class BoardController extends HttpServlet {	
	private static int fileIdNo = 1;
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter pw = response.getWriter();
		String requestURI = request.getRequestURI(); 
		String contextPath = request.getContextPath();

		String cmd = requestURI.substring(contextPath.length());
		BoardDAO dao = new BoardDAO();
		try {
			if(cmd.contentEquals("/to_write.board")){
				request.getRequestDispatcher("/WEB-INF/boards/write_supportme.jsp").forward(request, response);
				
			}else if(cmd.equals("/newArticle.board")) {
				String currentPage = request.getParameter("currentPage");
				request.setAttribute("currentPage", currentPage);
				request.getRequestDispatcher("/WEB-INF/boards/writer.jsp").forward(request, response);
				
			}else if(cmd.contentEquals("/supportme.board")) {
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
							System.out.println(fi.getFieldName());
							
							
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
				
			}else if(cmd.equals("/insertArticle.board")) { 
				request.getSession().setAttribute("flag", "true");
				BoardDTO dto = new BoardDTO();
				String title = request.getParameter("mytitle");
				title.replaceAll("<.?script>", "");
				dto.setTitle(title);
				String content = request.getParameter("mycontent");
				content.replaceAll("<.?script>", "");
				dto.setContents(content);
				dto.setWriter((String)request.getSession().getAttribute("loginId"));
				dto.setIpAddr(request.getLocalAddr());
				int result = dao.insertArticle(dto);
				request.setAttribute("result", result);
				request.getRequestDispatcher("/WEB-INF/boards/insertArticle.jsp").forward(request, response);

			}else if(cmd.equals("/uploadImage.board")) { //
				SimpleDateFormat sdf = new SimpleDateFormat("yy-MM-dd");
				Long currentTime = System.currentTimeMillis();
				String newDate = sdf.format(currentTime);
				
				String rootPath = this.getServletContext().getRealPath("/"); // this ���떊 request�씪怨� �빐�룄 �삊媛숈쓬.
				String id = (String)request.getSession().getAttribute("loginId");
				String filePath = rootPath + id + "/" + newDate;
				// UUID uuid = UUID.randomUUID(); // �쑀�씪�븳 �떇蹂꾩옄瑜� �깮�꽦�빐二쇰뒗 �겢�옒�뒪 UUID
				System.out.println(rootPath);

				File uploadPath = new File(filePath);
				if(!uploadPath.exists()) {
					uploadPath.mkdir(); // make directory �뤃�뜑瑜� 留뚮뱾�뼱�씪.
				}

				DiskFileItemFactory diskFactory = new DiskFileItemFactory();
				diskFactory.setRepository(new File(rootPath + "/WEB-INF/imgs"));
				ServletFileUpload sfu = new ServletFileUpload(diskFactory);
				sfu.setSizeMax(10 * 1024 * 1024);

				try { 
					List<FileItem> items = sfu.parseRequest( request); 
					for(FileItem fi : items) {
						if(fi.getSize() == 0) {continue;} 
						UfileDTO dto = new UfileDTO();
						dto.setOriFileName(fi.getName());
						dto.setFileSize(fi.getSize());
						dto.setFilePath(filePath);

						String tempFileName = null;
						while(true) {
							try {
								long tempTime = System.currentTimeMillis();
								tempFileName = tempTime+"_"+fi.getName();
								fi.write(new File(filePath+"/"+tempFileName)); // �엫�떆 �뤃�뜑�뿉 �엳�뒗 �뙆�씪�쓣 �슦由ш� �썝�븯�뒗 寃쎈줈濡� �떎�떆 蹂듭궗�빐二쇰뒗 肄붾뱶
								dto.setFileName(tempFileName);
								break;
							}catch(Exception e) {
								System.out.println("�뙆�씪 �씠由� �옱�꽕�젙.");
							}
						}
						pw.append(id + "/" + newDate + "/"+ dto.getFileName());
					}
				}catch(Exception e) {
					e.printStackTrace();
					response.sendRedirect("error.jsp");
				}
				
			}else if(cmd.equals("/deleteImage.board")) {
				Thread.sleep(500);
				String test = (String)request.getSession().getAttribute("flag");
				System.out.println(test);
				if(test.equals("false")) {
					String rootPath = this.getServletContext().getRealPath("/");
					String fileUrl = request.getParameter("src");
					System.out.println(fileUrl);
					String filePath = null;
					if(fileUrl.startsWith("http")) {
						filePath = fileUrl.replaceAll("http://.+?/", "");
					}else {
						filePath = fileUrl;
					}
					boolean deleteFile = new File(rootPath+filePath).delete();
					pw.print(deleteFile);
				}
				request.getSession().setAttribute("flag", "false");
				
				
			}else if(cmd.equals("/textList.board")) { // 湲�紐⑸줉 �럹�씠吏�濡� �씠�룞
				int currentPage = Integer.parseInt(request.getParameter("currentPage"));
				request.setAttribute("currentPage", currentPage);
				List<String> pageNavi = dao.getNavi(currentPage);
				request.setAttribute("pageNavi", pageNavi);
				List<BoardDTO> result = dao.selectByPage(currentPage);
				int pageTotalCount = dao.pageTotalCount;
				request.setAttribute("pageTotalCount", pageTotalCount);
				request.setAttribute("result", result);
				request.getRequestDispatcher("/WEB-INF/boards/board.jsp").forward(request, response);

			}else if(cmd.equals("/reading.board")) { // 寃뚯떆湲� �븯�굹瑜� 蹂대뒗 �럹�씠吏�濡� �씠�룞
				int textNum = Integer.parseInt(request.getParameter("textNo"));
				request.setAttribute("myId", request.getSession().getAttribute("loginId"));
				BoardDTO result = dao.showArticle(textNum);
				request.setAttribute("result", result);
				request.getRequestDispatcher("/WEB-INF/boards/readArticle.jsp").forward(request, response);

			}else if(cmd.equals("/articleSearch.board")) { // 寃��깋 �궎�썙�뱶�뿉 留욎떠�꽌 湲�紐⑸줉 �떎�떆 蹂댁뿬二쇨린
				String option = request.getParameter("option");
				String keyword = request.getParameter("keyword");
				request.setAttribute("option", option);
				request.setAttribute("keyword", keyword);
				int currentPage = Integer.parseInt(request.getParameter("currentPage"));
				request.setAttribute("currentPage", currentPage);
				List<BoardDTO> list = dao.selectByKeyword(option, keyword);
				int countArticle = list.size(); // �궎�썙�뱶 寃��깋�뼱濡� 媛��졇�삩 湲��쓽 媛쒖닔
				List<BoardDTO> result = dao.getSubList(currentPage, list, countArticle);
				List<String> pageNavi = dao.getNaviForKeywordSearch(currentPage, countArticle);
				request.setAttribute("pageNavi", pageNavi);
				request.setAttribute("result", result);
				request.getRequestDispatcher("/WEB-INF/boards/boardByKeyword.jsp").forward(request, response);

			}else if(cmd.equals("/readingByKeyword.board")) { // �궎�썙�뱶濡� 寃��깋�맂 紐⑸줉 以� 寃뚯떆湲� �븯�굹瑜� 蹂대뒗 �럹�씠吏�濡� �씠�룞
				String option = request.getParameter("option");
				String keyword = request.getParameter("keyword");
				request.setAttribute("option", option);
				request.setAttribute("keyword", keyword);
				int currentPage = Integer.parseInt(request.getParameter("currentPage"));
				request.setAttribute("currentPage", currentPage);
				int textNum = Integer.parseInt(request.getParameter("textNo"));
				request.setAttribute("myId", request.getSession().getAttribute("loginId"));
				BoardDTO result = dao.showArticle(textNum);
				request.setAttribute("result", result);
				request.getRequestDispatcher("/WEB-INF/boards/readArticleByKeyword.jsp").forward(request, response);

			}else if(cmd.equals("/editArticle.board")) { // 寃뚯떆湲� �닔�젙�쓣 �쐞�븳 �럹�씠吏�濡� �씠�룞
				int textNo = Integer.parseInt(request.getParameter("textNo"));
				request.setAttribute("textNo", textNo);
				BoardDTO result = dao.showArticle(textNo);
				request.setAttribute("result", result);
				request.getRequestDispatcher("/WEB-INF/boards/editing.jsp").forward(request, response);

			}else if(cmd.equals("/editedArticle.board")) { // 寃뚯떆湲� �닔�젙�븯湲�
				int textNo = Integer.parseInt(request.getParameter("textNo"));
				request.setAttribute("textNo", textNo);
				String title = request.getParameter("mytitle");
				String content = request.getParameter("mycontent");
				int result = dao.editArticle(textNo, title, content);
				request.setAttribute("result", result);
				request.getRequestDispatcher("/WEB-INF/boards/editOk.jsp").forward(request, response);

			}else if(cmd.equals("/removeArticle.board")) { // 寃뚯떆湲� �궘�젣
				int textNo = Integer.parseInt(request.getParameter("textNo"));
				request.setAttribute("textNo", textNo);
				int result = dao.deleteArticle(textNo);
				request.setAttribute("result", result);
				request.getRequestDispatcher("/WEB-INF/boards/deleteArticle.jsp").forward(request, response);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
