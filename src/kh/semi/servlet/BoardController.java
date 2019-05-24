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

import kh.semi.dao.BoardDAO;
import kh.semi.dto.BoardDTO;
import kh.semi.dto.UfileDTO;


@WebServlet("*.board")
public class BoardController extends HttpServlet {	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter pw = response.getWriter();
		String requestURI = request.getRequestURI(); 
		String contextPath = request.getContextPath();

		String cmd = requestURI.substring(contextPath.length());
		BoardDAO dao = new BoardDAO();
		try {
			if(cmd.equals("/newArticle.board")) { // 글쓰기 페이지로 이동
				String currentPage = request.getParameter("currentPage");
				request.setAttribute("currentPage", currentPage);
				request.getRequestDispatcher("/WEB-INF/boards/writer.jsp").forward(request, response);

			}else if(cmd.equals("/insertArticle.board")) { // 글 작성 완료
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

			}else if(cmd.equals("/uploadImage.board")) { // 사진 파일 업로드
				SimpleDateFormat sdf = new SimpleDateFormat("yy-MM-dd");
				Long currentTime = System.currentTimeMillis();
				String newDate = sdf.format(currentTime);
				
				String rootPath = this.getServletContext().getRealPath("/"); // this 대신 request라고 해도 똑같음.
				String id = (String)request.getSession().getAttribute("loginId");
				String filePath = rootPath + id + "/" + newDate;
				// UUID uuid = UUID.randomUUID(); // 유일한 식별자를 생성해주는 클래스 UUID
				System.out.println(rootPath);

				File uploadPath = new File(filePath);
				if(!uploadPath.exists()) {
					uploadPath.mkdir(); // make directory 폴더를 만들어라.
				}

				DiskFileItemFactory diskFactory = new DiskFileItemFactory();
				diskFactory.setRepository(new File(rootPath + "/WEB-INF/imgs"));
				ServletFileUpload sfu = new ServletFileUpload(diskFactory);
				sfu.setSizeMax(10 * 1024 * 1024);

				try { 
					List<FileItem> items = sfu.parseRequest(request); 
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
								fi.write(new File(filePath+"/"+tempFileName)); // 임시 폴더에 있는 파일을 우리가 원하는 경로로 다시 복사해주는 코드
								dto.setFileName(tempFileName);
								break;
							}catch(Exception e) {
								System.out.println("파일 이름 재설정.");
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
				
				
			}else if(cmd.equals("/textList.board")) { // 글목록 페이지로 이동
				int currentPage = Integer.parseInt(request.getParameter("currentPage"));
				request.setAttribute("currentPage", currentPage);
				List<String> pageNavi = dao.getNavi(currentPage);
				request.setAttribute("pageNavi", pageNavi);
				List<BoardDTO> result = dao.selectByPage(currentPage);
				int pageTotalCount = dao.pageTotalCount;
				request.setAttribute("pageTotalCount", pageTotalCount);
				request.setAttribute("result", result);
				request.getRequestDispatcher("/WEB-INF/boards/board.jsp").forward(request, response);

			}else if(cmd.equals("/reading.board")) { // 게시글 하나를 보는 페이지로 이동
				int textNum = Integer.parseInt(request.getParameter("textNo"));
				request.setAttribute("myId", request.getSession().getAttribute("loginId"));
				BoardDTO result = dao.showArticle(textNum);
				request.setAttribute("result", result);
				request.getRequestDispatcher("/WEB-INF/boards/readArticle.jsp").forward(request, response);

			}else if(cmd.equals("/articleSearch.board")) { // 검색 키워드에 맞춰서 글목록 다시 보여주기
				String option = request.getParameter("option");
				String keyword = request.getParameter("keyword");
				request.setAttribute("option", option);
				request.setAttribute("keyword", keyword);
				int currentPage = Integer.parseInt(request.getParameter("currentPage"));
				request.setAttribute("currentPage", currentPage);
				List<BoardDTO> list = dao.selectByKeyword(option, keyword);
				int countArticle = list.size(); // 키워드 검색어로 가져온 글의 개수
				List<BoardDTO> result = dao.getSubList(currentPage, list, countArticle);
				List<String> pageNavi = dao.getNaviForKeywordSearch(currentPage, countArticle);
				request.setAttribute("pageNavi", pageNavi);
				request.setAttribute("result", result);
				request.getRequestDispatcher("/WEB-INF/boards/boardByKeyword.jsp").forward(request, response);

			}else if(cmd.equals("/readingByKeyword.board")) { // 키워드로 검색된 목록 중 게시글 하나를 보는 페이지로 이동
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

			}else if(cmd.equals("/editArticle.board")) { // 게시글 수정을 위한 페이지로 이동
				int textNo = Integer.parseInt(request.getParameter("textNo"));
				request.setAttribute("textNo", textNo);
				BoardDTO result = dao.showArticle(textNo);
				request.setAttribute("result", result);
				request.getRequestDispatcher("/WEB-INF/boards/editing.jsp").forward(request, response);

			}else if(cmd.equals("/editedArticle.board")) { // 게시글 수정하기
				int textNo = Integer.parseInt(request.getParameter("textNo"));
				request.setAttribute("textNo", textNo);
				String title = request.getParameter("mytitle");
				String content = request.getParameter("mycontent");
				int result = dao.editArticle(textNo, title, content);
				request.setAttribute("result", result);
				request.getRequestDispatcher("/WEB-INF/boards/editOk.jsp").forward(request, response);

			}else if(cmd.equals("/removeArticle.board")) { // 게시글 삭제
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
