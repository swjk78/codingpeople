package cope.beans.utils;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

// Date 자료형을 다루기 위한 클래스
public class DateUtils {
	// 회원 정지 상태 갱신을 위한 현재 시간과 비교하는 기능
	public boolean compareWithSysdate(Date inputDate) throws Exception {
		SimpleDateFormat simpleDateformat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");				
		String currentTime = simpleDateformat.format(System.currentTimeMillis());
		Date sysdate = simpleDateformat.parse(currentTime);

		// 입력 날짜가 현재 시간을 지났을 경우 true를 반환
		return inputDate.before(sysdate);
	}
	
	// 회원 정지 날짜 계산 기능
	public Date getUnlockDate(int lockHour) throws Exception {
		SimpleDateFormat simpleDateformat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");				
		String currentTime = simpleDateformat.format(System.currentTimeMillis());
		Calendar cal = Calendar.getInstance();
		cal.setTime(simpleDateformat.parse(currentTime));
		
		// 시연용 처리
		if (lockHour == 0) {
			cal.add(Calendar.SECOND, 10);
			return cal.getTime();
		}
		
		cal.add(Calendar.HOUR_OF_DAY, lockHour);
		
		return cal.getTime();
	}
	
	//오늘인지 아닌지 식별하는 기능
	public boolean isToday(Date inputDate) throws Exception{
		SimpleDateFormat simpleDateformat = new SimpleDateFormat("yyyy-MM-dd");
		String currentTime = simpleDateformat.format(System.currentTimeMillis());
		String targetTime = simpleDateformat.format(inputDate);
		
		Date today = simpleDateformat.parse(currentTime);
		Date thatDay = simpleDateformat.parse(targetTime);
		
		if(thatDay.compareTo(today) < 0) {
			return true;
		}
		else {
			return false;
		}
	}
}
