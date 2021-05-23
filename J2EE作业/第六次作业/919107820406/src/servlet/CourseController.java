package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.Date;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import javaBean.Course;
import javaBean.Login;
import service.CourseService;
/**
 * Servlet implementation class CourseController
 */
public class CourseController extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private CourseService cService;
    /**
     * @throws SQLException 
     * @throws ClassNotFoundException 
     * @see HttpServlet#HttpServlet()
     */
    public CourseController() throws ClassNotFoundException, SQLException {
        super();
        this.cService=new CourseService();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Login login=(Login)request.getSession().getAttribute("user");
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		if(login != null){
			try {
				Object operate_1=request.getAttribute("operate");
				int operate;
				if(operate_1==null){
					if(request.getParameter("operate")!=null){
						if(request.getParameter("operate").equals("2")){
							request.setAttribute("operate",2);
						}else if(request.getParameter("operate").equals("3")){
							request.setAttribute("operate",3);
						}else if(request.getParameter("operate").equals("4")){
							request.setAttribute("operate",4);
						}
					}
					else{
						request.setAttribute("operate",1);
					}
				}
				operate=(int)request.getAttribute("operate");;
				List<Course>list=null;
				int result;
				PrintWriter pw;
				switch (operate) {
				case 1://查询
					list=cService.searchCourse(login);
					result=list.size();
					request.setAttribute("course", list);
					request.getRequestDispatcher("course/manageCourse.jsp").forward(request, response);
					break;
				case 2://增加
					String[] id=request.getParameterValues("id[]");
					String[] creater=request.getParameterValues("creater[]");
					String[] courseName=request.getParameterValues("courseName[]");
					List<Course>clist=new ArrayList<Course>();
					for (int i=0;i<id.length;i++) {
						clist.add(new Course(id[i], login.getUser(), creater[i], courseName[i], new Date()));
					}
					int[] result_1=cService.insertCourse(clist);
					result=0;
					String addFalse="";
					int j=0;
					for (int i : result_1) {
						addFalse+=clist.get(j).toString()+"  ";
						switch (i) {
							case 1:
								result++;
								addFalse+="添加成功\n";
								break;
							case -2:
								addFalse+="课程名与已创建课程号不相同\n";
								break;
							case -3:
								addFalse+="该用户已添加过该课程\n";
								break;
							default:
								break;
						}
						j++;
					}
					request.setAttribute("result", String.format("申请添加%d条课程信息，成功添加%d条\n%s",clist.size(), result,addFalse));
					response.setContentType("text/plain");
					pw=response.getWriter();
					pw.println(String.format("申请添加%d条课程信息，成功添加%d条:\n%s",clist.size(), result,addFalse));
					break;
				case 3://删除
					String[] delList_1=request.getParameterValues("deleteId[]");
					List<String> delList=new ArrayList<String>();
					int i=0;
					for (String delItem : delList_1) {
						if(delItem!=null){//删除
							delList.add(delItem);
						}
						i++;
					}
					result=cService.deleteCourses(login,delList);
					if(i!=result){
						throw new Exception("删除失败，信息不存在");
					}
					response.setContentType("text/plain");
					pw=response.getWriter();
					pw.println(String.format("请求删除%d条课程，成功删除%d条课程",i,result));
					break;
				default:
					list=cService.searchCourse(login);
					result=list.size();
					request.setAttribute("course", list);
					request.getRequestDispatcher("course/delCourse.jsp").forward(request, response);
					break;
				}
			} catch (SQLException e) {
				response.getWriter().println("errorMes="+e.getMessage()+" "+e.getSQLState());
				e.printStackTrace();
			}
			catch (Exception e) {
				response.getWriter().println("errorMes="+e.getMessage());
				e.printStackTrace();
			}
		}else{
			request.getRequestDispatcher("login/login.jsp").forward(request, response);
		}
		request.setAttribute("operate",1);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}
	
	public void destroy() {
		try {
			cService.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			super.destroy();
		}
		 // Just puts "destroy" string in log
		// Put your code here
	}
}
