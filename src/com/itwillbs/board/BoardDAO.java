package com.itwillbs.board;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class BoardDAO {
	// 공통으로 사용하는 변수

	// Connection con; 객체 X
	Connection con = null; // 객체 O - null
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String sql = "";

	// 공통으로 사용하는 디비연결동작
	private Connection getCon() throws Exception {
		/*
		 * try { // 1. 드라이버 로드 Class.forName("com.mysql.cj.jdbc.Driver"); // 2.
		 * 디비연결 con =
		 * DriverManager.getConnection("jdbc:mysql://localhost:3306/jspdb",
		 * "root", "1234"); } catch (ClassNotFoundException e) {
		 * System.out.println(" 드라이버 로드 실패! "); e.printStackTrace(); } catch
		 * (SQLException e) { System.out.println(" 디비 연결 실패! ");
		 * e.printStackTrace(); }
		 */

		// 커넥션풀을 사용한 디비 연결
		// 0. 프로젝트에 필요한 API 설치 (WEB-INF/lib/설치)
		// commons-collections4-4.4.jar
		// commons-dbcp2-2.9.0.jar
		// commons-pool2-2.11.1.jar
		// 1. 1~2단계에서 사용했던정보를 호출
		// => WebContext/META-INF/context.xml 파일생성
		// 2. WebContext/WEB-INF/web.xml 파일을 수정
		// => context.xml 파일의 정보를 기록
		// 3. DAO 파일에서 연결정보 처리

		// Context(프로젝트) 객체 생성(javax.naming)
		Context initCTX = new InitialContext();

		// 프로젝트 안에 디비연결에 필요한 정보 가져오기
		// => context.xml파일의 정보를 읽어와서 DataSource파일의 형태로
		// 변경해서 저장해놓기
		DataSource ds = (DataSource) initCTX.lookup("java:comp/env/jdbc/mysqldb");

		// 연결정보를 사용해서 디비 연결
		con = ds.getConnection();

		return con;
	}

	// " 디비 자원해제 동작
	public void closeDB() {
		try {
			if (rs != null)
				rs.close();
			if (pstmt != null)
				pstmt.close();
			if (con != null)
				con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	// insertBoard(dto)
	public void insertBoard(BoardDTO dto) {

		int num = 0; // 글번호 저장

		try {
			con = getCon();

			// 글번호 계산
			// 3. sql 생성 & pstmt 객체
			sql = "select max(num) from itwill_board";
			pstmt = con.prepareStatement(sql);

			// 4. sql 구문 실행
			rs = pstmt.executeQuery();
			// 5. 데이터 처리
			if (rs.next()) {
				// 기존의 글번호(저장된최대값) + 1
				num = rs.getInt(1) + 1; // 1번 인덱스 컬럼
				// num = rs.getInt("max(num)")+1;`
				// getInt(인덱스) -> 컬럼의 값을 리턴, 만약에 SQL null이면 0리턴
			}
			// else{
			// num = 1;
			// }

			System.out.println(" 글 번호 : " + num);
			///////////////////////////////////////////////////////////////////////
			// 전달받은 글정보를 DB insert 
			
			// 3. sql 작성 (insert) & pstmt 객체 생성
			sql = "insert into itwill_board(num,name,pass,subject,content,readcount,"
					+ "re_ref,re_lev,re_seq,date,ip,file) "
					+ "values(?,?,?,?,?,?,?,?,?,now(),?,?)";
			
			pstmt = con.prepareStatement(sql);
			
			// ?
			pstmt.setInt(1, num);
			pstmt.setString(2, dto.getName());
			pstmt.setString(3, dto.getPass());
			pstmt.setString(4, dto.getSubject());
			pstmt.setString(5, dto.getContent());
			pstmt.setInt(6, 0);// 조회수 0으로 초기화
			pstmt.setInt(7, num);  // re_ref 그룹번호
			pstmt.setInt(8, 0);   //re_lev 레벨값
			pstmt.setInt(9, 0);   // re_seq 순서
			pstmt.setString(10, dto.getIp());
			pstmt.setString(11, dto.getFile());
			
			// 4. sql 실행
			pstmt.executeUpdate();
			
			System.out.println(" DAO : 글작성 완료! ");

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}

	}
	// insertBoard(dto)
	
	// getBoardCount()
	public int getBoardCount(){
		int cnt = 0;
		
		try {
			// 1,2 디비연결
			con = getCon();
			// 3 sql 작성(select) & pstmt 객체
			sql = "select count(*) from itwill_board";
			pstmt = con.prepareStatement(sql);
			// 4 sql 실행
			rs = pstmt.executeQuery();
			// 5 데이터 처리
			if(rs.next()){
				//데이터 있을때 (글개수)
				cnt = rs.getInt(1);	
				//cnt = rs.getInt("count(*)");
			}
			
			System.out.println(" DAO : 글개수 ("+cnt+")");
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
		
		return cnt;
	}
	// getBoardCount()
	
	
	// getBoardList()
	public List getBoardList(){
		List boardList = new ArrayList();
//		List<Object> boardList = new ArrayList<Object>();
		
		try {
			// 1,2 디비연결
			con = getCon();
			// 3 sql 작성 & pstmt 객체 생성
			sql = "select * from itwill_board";
			pstmt = con.prepareStatement(sql);
			// 4 sql 실행
			rs = pstmt.executeQuery();
			// 5 데이터처리 (글 1개의 정보 -> DTO 1개 -> ArrayList 1칸)
			while(rs.next()){
				//데이터 있을때 마다 글 1개의 정보를 저장하는 객체 생성
				BoardDTO bdto = new BoardDTO();
				
				bdto.setContent(rs.getString("content"));
				bdto.setDate(rs.getDate("date"));
				bdto.setFile(rs.getString("file"));
				bdto.setIp(rs.getString("ip"));
				bdto.setName(rs.getString("name"));
				bdto.setNum(rs.getInt("num"));
				bdto.setPass(rs.getString("pass"));
				bdto.setRe_lev(rs.getInt("re_lev"));
				bdto.setRe_ref(rs.getInt("re_ref"));
				bdto.setRe_seq(rs.getInt("re_seq"));
				bdto.setReadcount(rs.getInt("readcount"));
				bdto.setSubject(rs.getString("subject"));
				
				// DTO 객체를 ArrayList 한칸에 저장
				boardList.add(bdto);				
				
			}//while
			
			System.out.println(" DAO : 글 정보 저장완료! "+boardList.size());
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
		
		return boardList;
	}
	// getBoardList()
	
	
	// getBoardList(startRow,pageSize)
	public List getBoardList(int startRow,int pageSize){
		List boardList = new ArrayList();
//		List<Object> boardList = new ArrayList<Object>();
		
		try {
			// 1,2 디비연결
			con = getCon();
			// 3 sql 작성 & pstmt 객체 생성
			// 글 re_ref 최신글 위쪽(내림차순), re_seq (오름차순)
			// DB데이터를 원하는만큼씩 짤라내기 : limit 시작행-1,페이지크기 
			sql = "select * from itwill_board order by re_ref desc, re_seq asc limit ?,?";
			pstmt = con.prepareStatement(sql);
			
			//?
			pstmt.setInt(1, startRow-1); // 시작행-1  (시작 ROW인덱스 번호)
			pstmt.setInt(2, pageSize); // 페이지크기  (한번에 출력되는 수)
			
			// 4 sql 실행
			rs = pstmt.executeQuery();
			// 5 데이터처리 (글 1개의 정보 -> DTO 1개 -> ArrayList 1칸)
			while(rs.next()){
				//데이터 있을때 마다 글 1개의 정보를 저장하는 객체 생성
				BoardDTO bdto = new BoardDTO();
				
				bdto.setContent(rs.getString("content"));
				bdto.setDate(rs.getDate("date"));
				bdto.setFile(rs.getString("file"));
				bdto.setIp(rs.getString("ip"));
				bdto.setName(rs.getString("name"));
				bdto.setNum(rs.getInt("num"));
				bdto.setPass(rs.getString("pass"));
				bdto.setRe_lev(rs.getInt("re_lev"));
				bdto.setRe_ref(rs.getInt("re_ref"));
				bdto.setRe_seq(rs.getInt("re_seq"));
				bdto.setReadcount(rs.getInt("readcount"));
				bdto.setSubject(rs.getString("subject"));
				
				// DTO 객체를 ArrayList 한칸에 저장
				boardList.add(bdto);				
				
			}//while
			
			System.out.println(" DAO : 글 정보 저장완료! "+boardList.size());
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
		
		return boardList;
	}
	// getBoardList(startRow,pageSize)
	
	
	// updateReadcount(num)
	public void updateReadcount(int num){
		try {
			//1.2. 디비연결
			con = getCon();
			// 3. sql 구문 & pstmt 객체
			// 조회수(readcount)를 기존값에서 1증가(update)
			sql = "update itwill_board set readcount = readcount+1 where num=?";
			pstmt = con.prepareStatement(sql);
			
			//?
			pstmt.setInt(1, num);
			
			// 4. sql 실행
			pstmt.executeUpdate();
			
			System.out.println("DAO : 조회수 1증가");
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
		
	}
	// updateReadcount(num)
	
	// getBoard(num)
	public BoardDTO getBoard(int num){
		BoardDTO bdto = null;
		
		try {
			// 1.2. 디비연결
			con = getCon();
			// 3. sql 작성(select) & pstmt 객체 생성
			// num에 해당하는 글정보를 가져오기
			sql = "select * from itwill_board where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			
			// 4. sql 실행
			rs = pstmt.executeQuery();
			
			// 5. 데이터처리
			if(rs.next()){
				bdto = new BoardDTO();
				
				bdto.setContent(rs.getString("content"));
				bdto.setDate(rs.getDate("date"));
				bdto.setFile(rs.getString("file"));
				bdto.setIp(rs.getString("ip"));
				bdto.setName(rs.getString("name"));
				bdto.setNum(rs.getInt("num"));
				bdto.setPass(rs.getString("pass"));
				bdto.setRe_lev(rs.getInt("re_lev"));
				bdto.setRe_ref(rs.getInt("re_ref"));
				bdto.setRe_seq(rs.getInt("re_seq"));
				bdto.setReadcount(rs.getInt("readcount"));
				bdto.setSubject(rs.getString("subject"));
				
			}//if
			
			System.out.println(" DAO : 글정보 저장완료!");			
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
		
		return bdto;
	}
	// getBoard(num)
	
	
	// updateBoard(bdto)
	public int updateBoard(BoardDTO bdto){
		int result = -1;
		
		try {
			//1.2. 디비연결
			con = getCon();
			//3. sql 구문 & pstmt 객체
			sql = "select pass from itwill_board where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, bdto.getNum());
			
			// 4. sql 실행
			rs = pstmt.executeQuery();
			
			// 5. 데이터 처리
			if(rs.next()){
				if(bdto.getPass().equals(rs.getString("pass"))){
					// 게시판 글 있음 -> 수정
					// 3. sql 생성 & pstmt 객체 생성
					sql = "update itwill_board set name=?,subject=?,content=? "
							+ "where num=?";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, bdto.getName());
					pstmt.setString(2, bdto.getSubject());
					pstmt.setString(3, bdto.getContent());
					pstmt.setInt(4, bdto.getNum());
					
					// 4. sql 실행
					result = pstmt.executeUpdate();
					
				}else{
					// 게시판 글 비밀번호 오류
					result = 0;
				}				
			}else{
				// 게시판 글없음
				result = -1;
			}
			
			System.out.println(" DAO : 글 수정완료 "+result);
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}

		return result;
	}
	// updateBoard(bdto)
	
	// deleteBoard(num,pass)
	public int deleteBoard(int num,String pass){
		int result = -1;
		
		try {
			// 1.2. 디비연결
			con = getCon();
			// 3. sql 작성 & pstmt 객체 생성
			sql = "select pass from itwill_board where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			
			// 4. sql 실행
			rs = pstmt.executeQuery();
			
			// 5. 데이터 처리
			if(rs.next()){
				if(pass.equals(rs.getString("pass"))){
					// 3. sql
					sql ="delete from itwill_board where num=?";
					pstmt = con.prepareStatement(sql);
					
					pstmt.setInt(1, num);
					// 4. sql 실행
					result = pstmt.executeUpdate();		
				}else{
					result = 0;
				}
			}else{
				result = -1;
			}
			
			System.out.println(" DAO : 게시판 글 삭제 완료! "+result);
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}		
		
		return result;
	}
	// deleteBoard(num,pass)
	
	// reInsertBoard(dto)
	public void reInsertBoard(BoardDTO bdto){
		int num = 0;
		
		try {
			// 답글번호 계산 (num)
			// 1.2 디비연결
			con = getCon();
			// 3. sql 작성 & pstmt 객체
			sql = "select max(num) from itwill_board";
			pstmt = con.prepareStatement(sql);
			// 4. sql 실행
			rs = pstmt.executeQuery();
			// 5. 데이터처리
			if(rs.next()){
				num = rs.getInt(1)+1;
			}
			System.out.println(" DAO : 답글 번호(num) : "+num);
			
			// 답글순서 재배치 (re_ref동일그룹에서 re_seq기존의 값보다 큰값이 있을때 re_seq를 1증가)
				// 3. sql 작성 & pstmt
				sql ="update itwill_board set re_seq = re_seq + 1 "
						+ "where re_ref=? and re_seq>?";
				pstmt = con.prepareStatement(sql);
				
				pstmt.setInt(1, bdto.getRe_ref()); // 부모글의 ref
				pstmt.setInt(2, bdto.getRe_seq()); // 부모글의 seq
				
				// 4. sql 실행
				pstmt.executeUpdate();
			// 답글순서 재배치 (re_ref동일그룹에서 re_seq기존의 값보다 큰값이 있을때 re_seq를 1증가)
			
			// 답글 쓰기(insert)
			// 3. sql 작성 (insert) & pstmt 객체 생성
			sql = "insert into itwill_board(num,name,pass,subject,content,readcount,"
					+ "re_ref,re_lev,re_seq,date,ip,file) "
					+ "values(?,?,?,?,?,?,?,?,?,now(),?,?)";
			
			pstmt = con.prepareStatement(sql);
			
			// ?
			pstmt.setInt(1, num);
			pstmt.setString(2, bdto.getName());
			pstmt.setString(3, bdto.getPass());
			pstmt.setString(4, bdto.getSubject());
			pstmt.setString(5, bdto.getContent());
			pstmt.setInt(6, 0);// 조회수 0으로 초기화
			pstmt.setInt(7, bdto.getRe_ref());  // re_ref 그룹번호 = 부모글의 그룹번호
			pstmt.setInt(8, bdto.getRe_lev()+1);   //re_lev 레벨값 => 부모글 lev + 1
			pstmt.setInt(9, bdto.getRe_seq()+1);   // re_seq 순서 => 부모글 seq + 1
			pstmt.setString(10, bdto.getIp());
			pstmt.setString(11, bdto.getFile());
			
			// 4. sql 실행
			pstmt.executeUpdate();
			
			System.out.println(" DAO : 답글 작성 완료!");
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}		
		
	}
	
	// reInsertBoard(dto)
	
	
	

}//DAO
