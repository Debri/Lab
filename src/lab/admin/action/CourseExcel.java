package lab.admin.action;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.List;
import lab.bean.Course;
import lab.util.ReadExcel;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

public class CourseExcel {
	/**
	 * 对外提供读取excel 的方法
	 * */
	public static List<Course> readExcel(File file) throws IOException {
		String fileName = file.getName();
		String extension = fileName.lastIndexOf(".") == -1 ? "" : fileName
				.substring(fileName.lastIndexOf(".") + 1);
		if ("xls".equals(extension)) {
			return read2003Excel(file);
		} else if ("xlsx".equals(extension)) {
			return read2007Excel(file);
		} else {
			throw new IOException("不支持的文件类型");
		}
	}

	/**
	 * 读取 office 2003 excel
	 * 
	 */
	private static List<Course> read2003Excel(File file)
			throws IOException {
		List<Course> al = new ArrayList<Course>();
		HSSFWorkbook hwb = new HSSFWorkbook(new FileInputStream(file));
		HSSFSheet sheet = hwb.getSheetAt(0);
		HSSFRow row = null;
		HSSFCell cell = null;
		
		//获取第一行标题
		row = sheet.getRow(0);
		// 标题总列数
		int colNum = row.getLastCellNum();
		// 将标题放入数组
		String[] title = new String[colNum];
		for (int i = 0; i < colNum; i++) {
			title[i] = row.getCell(i).toString();
		}
		//读取excel的类容
		for (int i = sheet.getFirstRowNum()+1; i <= sheet
				.getPhysicalNumberOfRows(); i++) {
			row = sheet.getRow(i);
			if (row == null) {
				continue;
			}
			Course c = new Course();
			for (int j = row.getFirstCellNum(); j <= row.getLastCellNum(); j++) {
				cell = row.getCell(j);
				if (cell == null) {
					continue;
				}
				if(title[j].equals("课程编号")){
					c.setCourseNumber(CourseExcel.getHSSFCellStringValue(cell));
				}else if(title[j].equals("课程名称")){
					System.out.println(ReadExcel.getHSSFCellStringValue(cell));
					c.setCourseName(CourseExcel.getHSSFCellStringValue(cell));
				}else if(title[j].equals("学期")){
					c.setTerm(CourseExcel.getHSSFCellStringValue(cell));
				}
			}
			al.add(c);
		}
		return al;
	}

	/**
	 * 读取Office 2007 excel
	 * */
	private static List<Course> read2007Excel(File file)
			throws IOException {
		List<Course> al = new ArrayList<Course>();
		// 构造 XSSFWorkbook 对象，strPath 传入文件路径
		XSSFWorkbook xwb = new XSSFWorkbook(new FileInputStream(file));
		// 读取第一章表格内容
		XSSFSheet sheet = xwb.getSheetAt(0);
		XSSFRow row = null;
		XSSFCell cell = null;
		
		//获取第一行标题
		row = sheet.getRow(0);
		// 标题总列数
		int colNum = row.getLastCellNum();
		// 将标题放入数组
		String[] title = new String[colNum];
		for (int i = 0; i < colNum; i++) {
			title[i] = row.getCell(i).toString();
		}
		//读取excel的类容
		for (int i = sheet.getFirstRowNum(); i <= sheet
				.getPhysicalNumberOfRows(); i++) {
			row = sheet.getRow(i);
			if (row == null) {
				continue;
			}
			Course c = new Course();
			for (int j = row.getFirstCellNum(); j <= row.getLastCellNum(); j++) {
				cell = row.getCell(j);
				if (cell == null) {
					continue;
				}
				if(title[j].equals("课程编号")){
					c.setCourseNumber(CourseExcel.getXSSFCellStringValue(cell));
				}
				if(title[j].equals("课程名称")){
					c.setCourseName(CourseExcel.getXSSFCellStringValue(cell));
				}else if(title[j].equals("学期")){
					c.setTerm(CourseExcel.getXSSFCellStringValue(cell));
				}
			}
			al.add(c);
		}
		return al;
	}
	
	public static String getHSSFCellStringValue(HSSFCell cell) {      
        String cellValue = "";      
        switch (cell.getCellType()) {      
        case HSSFCell.CELL_TYPE_STRING://字符串类型  
            cellValue = cell.getStringCellValue().trim();      
            if(cellValue.trim().equals("")||cellValue.trim().length()<=0)      
                cellValue=" ";      
            break;      
        case HSSFCell.CELL_TYPE_NUMERIC: //数值类型  
            double value = cell.getNumericCellValue();  
            cellValue = new DecimalFormat("#").format(value);
            break;      
        case HSSFCell.CELL_TYPE_FORMULA: //公式  
            cell.setCellType(HSSFCell.CELL_TYPE_NUMERIC);      
            cellValue = String.valueOf(cell.getNumericCellValue()).trim();      
            break;      
        case HSSFCell.CELL_TYPE_BLANK:      
            cellValue=" ";      
            break;      
        case HSSFCell.CELL_TYPE_BOOLEAN:      
            break;      
        case HSSFCell.CELL_TYPE_ERROR:      
            break;      
        default:      
            break;      
        }      
        return cellValue;      
    }
	
	
	public static String getXSSFCellStringValue(XSSFCell cell) {      
        String cellValue = "";      
        switch (cell.getCellType()) {      
        case XSSFCell.CELL_TYPE_STRING://字符串类型  
            cellValue = cell.getStringCellValue().trim();      
            if(cellValue.trim().equals("")||cellValue.trim().length()<=0)      
                cellValue=" ";      
            break;      
        case XSSFCell.CELL_TYPE_NUMERIC: //数值类型  
        	double value = cell.getNumericCellValue();  
            cellValue = new DecimalFormat("#").format(value);
            break;      
        case XSSFCell.CELL_TYPE_FORMULA: //公式  
            cell.setCellType(XSSFCell.CELL_TYPE_NUMERIC);      
            cellValue = String.valueOf(cell.getNumericCellValue()).trim();      
            break;      
        case XSSFCell.CELL_TYPE_BLANK:      
            cellValue=" ";      
            break;      
        case XSSFCell.CELL_TYPE_BOOLEAN:      
            break;      
        case XSSFCell.CELL_TYPE_ERROR:      
            break;      
        default:      
            break;      
        }      
        return cellValue;      
    }
}
