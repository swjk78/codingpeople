package cope.beans.utils;

import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;

// String 객체를 Date Type으로 변환하는 클래스
public class StringToDate {
	public Date transformDate(String inputDate) {
		if (inputDate == null) {
			return null;
		}

		Date d = Date.valueOf(inputDate);

		return d;
	}
}
