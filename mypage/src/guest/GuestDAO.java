package guest;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import db.DBClose;
import db.DBOpen;



public class GuestDAO {
	public boolean create(GuestDTO dto) {
		boolean flag=false;
		Connection con=DBOpen.open();
		PreparedStatement ps=null;
		StringBuffer sql=new StringBuffer();
		sql.append(" insert into guest(gno, title, content, wdate, grpno) ");
		sql.append(" values(memo_seq.nextval,?,?,sysdate, ");
		sql.append(" 		(select nvl(max(grpno),0)+1 from guest)  ) ");
			
		try {
			ps=con.prepareStatement(sql.toString());
			ps.setString(1, dto.getTitle());
			ps.setString(2, dto.getContent());
			
			int cnt=ps.executeUpdate();
			if(cnt>0)flag=true;
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			DBClose.close(ps, con);
		}
		
		return flag;
	}
	
	public GuestDTO read(int gno) {
		GuestDTO dto=new GuestDTO();
		Connection con=DBOpen.open();
		PreparedStatement ps=null;
		ResultSet rs=null;
		
		StringBuffer sql=new StringBuffer();
		sql.append(" select gno, title, content, ");
		sql.append(" to_char(wdate,'yyyy-mm-dd')wdate, viewcnt ");
		sql.append(" from guest where gno=? ");
	
		try {
			ps=con.prepareStatement(sql.toString());
			ps.setInt(1, gno);
			
			rs=ps.executeQuery();
			
			if(rs.next()) {
				dto=new GuestDTO();
				dto.setGno(rs.getInt("gno"));
				dto.setTitle(rs.getString("title"));
				dto.setContent(rs.getString("content"));
				dto.setWdate(rs.getString("wdate"));
				dto.setViewcnt(rs.getInt("viewcnt"));
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			DBClose.close(rs, ps, con);
		}
				
		return dto;
	}
	
	public List<GuestDTO> list(){
		List<GuestDTO> list=new ArrayList<GuestDTO>();
		Connection con=DBOpen.open();
		PreparedStatement ps=null;
		ResultSet rs=null;
		
		StringBuffer sql=new StringBuffer();
		sql.append(" select gno,title, to_char(wdate, 'yyyy-mm-dd')wdate, ");
		sql.append("   viewcnt, grpno, indent, ansnum ");
		sql.append(" from guest ");
		sql.append(" order by grpno DESC, ansnum ");
			
		try {
			ps=con.prepareStatement(sql.toString());
			
			rs=ps.executeQuery();
			
			while(rs.next()) {
				GuestDTO dto=new GuestDTO();
				dto.setGno(rs.getInt("gno"));
				dto.setTitle(rs.getString("title"));
				dto.setWdate(rs.getString("wdate"));
				dto.setViewcnt(rs.getInt("viewcnt"));
				dto.setGrpno(rs.getInt("grpno"));
				dto.setIndent(rs.getInt("indent"));
				dto.setAnsnum(rs.getInt("ansnum"));
				
				list.add(dto);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			DBClose.close(rs, ps, con);
		}
		
		
		return list;
	}
	
	public boolean update(GuestDTO dto) {
		boolean flag=false;
		Connection con=DBOpen.open();
		PreparedStatement ps=null;
		
		StringBuffer sql=new StringBuffer();
		sql.append(" update guest ");
		sql.append(" set title=?, ");
		sql.append(" 	 content=? ");
		sql.append("  where gno=? ");
	
		try {
			ps=con.prepareStatement(sql.toString());
			ps.setString(1, dto.getTitle());
			ps.setString(2, dto.getContent());
			ps.setInt(3, dto.getGno());
			
			int cnt=ps.executeUpdate();
			if(cnt>0)flag=true;
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			DBClose.close(ps,con);
		}
		
		return flag;
	}
	
	public boolean delete(int gno) {
		boolean flag=false;
		Connection con=DBOpen.open();
		PreparedStatement ps=null;
		
		StringBuffer sql=new StringBuffer();
		sql.append(" delete from guest ");
		sql.append(" where gno=? ");
		
		try {
			ps=con.prepareStatement(sql.toString());
			ps.setInt(1, gno);
			
			int cnt=ps.executeUpdate();
			if(cnt>0)flag=true;
			
		} catch (SQLException e) {	
			e.printStackTrace();
		}finally {
			DBClose.close(ps, con);
		}
		
		return flag;
	}
	
	public void updateViewcnt(int gno) {
		Connection con=DBOpen.open();
		PreparedStatement ps=null;
		
		StringBuffer sql=new StringBuffer();
		sql.append(" update guest ");
		sql.append(" set viewcnt=viewcnt+1 ");
		sql.append(" where gno=? ");
	
		try {
			ps=con.prepareStatement(sql.toString());
			ps.setInt(1, gno);
			ps.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			DBClose.close(ps,con);
		}
	}
	
	public boolean replyCreate(GuestDTO dto) {
		boolean flag=false;
		Connection con=DBOpen.open();
		PreparedStatement ps=null;
		
		StringBuffer sql=new StringBuffer();
		sql.append(" insert into guest ");
		sql.append("  (gno, title, content, wdate, grpno, indent, ansnum) ");
		sql.append(" value(guest_seq.nextval,?,?,sysdate, ");
		sql.append(" 		?, ?, ?) ");
		
		try {
			ps=con.prepareStatement(sql.toString());
			ps.setString(1, dto.getTitle());
			ps.setString(2, dto.getContent());
			ps.setInt(3, dto.getGrpno()); //주의) 부모와 같다
			ps.setInt(4, dto.getIndent()+1); // 부모값에 +1을 한다.
			ps.setInt(5, dto.getAnsnum()+1); // 부모값에 +1을 한다.
			
			int cnt=ps.executeUpdate();
			if(cnt>0)flag=true;
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			DBClose.close(ps, con);
		}
		
		return flag;
	}
	
	public GuestDTO replyRead(int gno) {
		GuestDTO dto=new GuestDTO();
		Connection con=DBOpen.open();
		PreparedStatement ps=null;
		ResultSet rs=null;
		
		StringBuffer sql=new StringBuffer();
		sql.append(" select gno, title, grpno, indent, ansnum  ");
		sql.append(" from guest where gno=?  ");
		
		try {
			ps=con.prepareStatement(sql.toString());
			ps.setInt(1, gno);
			rs=ps.executeQuery();
			if(rs.next()) {
				//GuestDTO dto=new GuestDTO();
				dto.setGno(rs.getInt("gno"));
				dto.setTitle(rs.getString("title"));
				dto.setGrpno(rs.getInt("grpno"));
				dto.setIndent(rs.getInt("indent"));
				dto.setAnsnum(rs.getInt("ansnum"));
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			DBClose.close(rs, ps, con);
		}
		
		return dto;
	}

	public void upAnsnum(Map map) {
		Connection con=DBOpen.open();
		PreparedStatement ps=null;
		int grpno=(Integer)map.get("grpno");
		int ansnum=(Integer)map.get("ansnum");
		
		StringBuffer sql=new StringBuffer();
		sql.append(" update guest ");
		sql.append(" set ansnum=ansnum+1 ");
		sql.append(" where grpno=? and ansnum > ? ");

		try {
			ps=con.prepareStatement(sql.toString());
			ps.setInt(1, grpno);
			ps.setInt(2, ansnum);
			
			ps.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			DBClose.close(ps, con);
		}
	}
}
